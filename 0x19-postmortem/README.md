# Apache Server Outage Postmortem

## Overview

This document provides a detailed postmortem of the Apache server outage that occurred on March 24, 2017. The outage lasted for 32 minutes and affected all users attempting to access the web service. The root cause was identified as a misconfiguration in the WordPress PHP files, leading to a fatal error.

## Issue Summary

**Duration:**
- **Start Time:** 07:00 GMT, March 24, 2017
- **End Time:** 07:32 GMT, March 24, 2017

**Impact:**
- The Apache server was completely inaccessible.
- Users received a "500 Internal Server Error" message.
- 100% of users were affected.

**Root Cause:**
- Misconfiguration in the WordPress PHP files.

## Timeline

- **07:00 GMT:** Issue detected by automated monitoring alert indicating the server was down.
- **07:01 GMT:** Initial investigation began by checking server status using `curl -sI 127.0.0.1`.
- **07:05 GMT:** Error "HTTP/1.0 500 Internal Server Error" confirmed; Apache logs reviewed.
- **07:10 GMT:** Attempted to restart Apache server, issue persisted.
- **07:15 GMT:** Misleading assumption that server resource limits might be the cause, checked memory and CPU usage.
- **07:20 GMT:** Escalated to the DevOps team for further investigation.
- **07:25 GMT:** DevOps team identified the issue with WordPress configuration via `strace` and other diagnostic tools.
- **07:30 GMT:** Applied fix using Puppet script (`puppet apply 0-strace_is_your_friend.pp`).
- **07:32 GMT:** Service restored, confirmed by successful `curl -sI 127.0.0.1:80` response and checking web content.

## Root Cause and Resolution

**Root Cause:**
- The Apache server was serving a WordPress site which, due to a misconfiguration in the WordPress PHP files, was causing a fatal error. The error was not handled correctly, resulting in the server returning a "500 Internal Server Error" for all requests.

**Resolution:**
- The issue was resolved by running a Puppet script designed to fix common WordPress configuration issues. The script (`0-strace_is_your_friend.pp`) made the necessary adjustments to the PHP configuration, allowing the Apache server to handle requests correctly. This restored the website to its fully operational state.

## Corrective and Preventative Measures

**Improvements/Fixes:**
- Improve monitoring to detect specific issues with PHP and Apache configurations.
- Implement better error handling in the PHP code to avoid entire site outages.
- Regular audits of server configurations to prevent similar issues.

**Tasks to Address the Issue:**
1. **Patch Apache Server:** Ensure all servers are running the latest versions of Apache and PHP.
2. **Add Monitoring:** Implement detailed monitoring for Apache server logs to catch PHP errors early.
3. **Regular Configuration Reviews:** Schedule monthly audits of WordPress and Apache configurations.
4. **Enhanced Error Handling:** Update WordPress PHP scripts to include comprehensive error handling to prevent fatal errors from causing full outages.
5. **Training:** Conduct training sessions for developers and operations teams on best practices for server configuration and error handling.

## Conclusion

This incident highlighted the critical importance of robust server and application configuration management. By implementing the corrective and preventative measures outlined, we aim to significantly reduce the likelihood of similar issues occurring in the future, ensuring a more reliable service for our users.

## Contact

For more information, please contact the DevOps team:
Benslimane Hamza <benslimanebiopro@gmail.com>


