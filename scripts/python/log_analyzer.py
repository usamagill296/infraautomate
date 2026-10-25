import re
import json
from datetime import datetime
from collections import Counter
# Sample logs (in production these come from CloudWatch)
SAMPLE_LOGS = """
2026-10-25 08:00:01 INFO Request received /health
2026-10-25 08:00:02 INFO Request received /api/transactions
2026-10-25 08:01:15 ERROR Internal server error 500
2026-10-25 08:02:30 ERROR Database connection failed
2026-10-25 08:03:00 WARNING High memory usage 85%
2026-10-25 08:04:00 ERROR Internal server error 500
2026-10-25 08:05:00 INFO Request received /health
2026-10-25 08:06:00 ERROR Unauthorized API call detected
2026-10-25 08:07:00 WARNING High memory usage 92%
2026-10-25 08:08:00 ERROR Internal server error 500
"""
def parse_logs(log_text):
    """Parse log lines into structured data"""
    logs = []
    for line in log_text.strip().split('\n'):
        if not line:
            continue
        parts = line.split(' ', 3)
        if len(parts) >= 4:
            logs.append({
                'date': parts[0],
                'time': parts[1],
                'level': parts[2],
                'message': parts[3]
            })
    return logs

def analyze_logs(logs):
    """Analyze logs for issues"""
    errors = []
    warnings = []
    error_types = Counter()

    for log in logs:
        level = log['level']
        message = log['message']

        if level == 'ERROR':
            errors.append(log)
            error_types[message] += 1

        elif level == 'WARNING':
            warnings.append(log)

    return {
        'total_lines': len(logs),
        'error_count': len(errors),
        'warning_count': len(warnings),
        'error_types': dict(error_types),
        'errors': errors,
        'warnings': warnings
    }

def generate_report(analysis):
    """Generate readable report from analysis"""
    print("\n" + "="*50)
    print("📊 LOG ANALYSIS REPORT")
    print("="*50)
    print(f"Generated: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    print(f"\nTotal log lines:  {analysis['total_lines']}")
    print(f"Total errors:     {analysis['error_count']}")
    print(f"Total warnings:   {analysis['warning_count']}")

    if analysis['error_types']:
        print("\n🚨 Error Breakdown:")
        for error, count in sorted(
            analysis['error_types'].items(),
            key=lambda x: x[1],
            reverse=True
        ):
            print(f"  [{count}x] {error}")

    if analysis['warnings']:
        print("\n⚠️  Warnings:")
        for warning in analysis['warnings']:
            print(f"  {warning['time']} - {warning['message']}")

    if analysis['error_count'] > 2:
        print("\n🔴 ALERT: High error rate detected!")
        print("   Recommend immediate investigation!")

def run_analyzer():
      """Main function to run log analysis"""
      print("🔍 Starting log analysis...")
    
    # Parse logs
      logs = parse_logs(SAMPLE_LOGS)
    
    # Analyze
      analysis = analyze_logs(logs)
    
    # Generate report
      generate_report(analysis)
    
      print("\n✅ Analysis complete!")
      return analysis

if __name__ == "__main__":
    run_analyzer()