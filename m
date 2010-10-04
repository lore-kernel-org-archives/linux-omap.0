From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: PATCH [0/4] perf: clean-up of power events API
Date: Mon,  4 Oct 2010 17:20:57 +0200
Message-ID: <1286205661-24448-1-git-send-email-jean.pihet@newoldbits.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:64957 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755957Ab0JDPWG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Oct 2010 11:22:06 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-trace-users@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-perf-users@vger.kernel.org, mingo@elte.hu, arjan@linux.intel.com, rjw@sisk.pl, linux-omap@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Kevin Hilman <khilman@deeprootsystems.com>, Steven Rostedt <rostedt@goodmis.org>, Frank Eigler <fche@redhat.com>, mathieu.desnoyers@efficios.com

Here is a re-spin of the patches after discussion.
It includes:
- clean-up of the API,
- a deprecation process for backward compatibility,
- support for x86 and OMAP processors,
- support for the following tracepoints: cpuidle, cpufreq,
   system suspend, clocks & power domains

ToDO:
- documentation of the new API (once the code is agreed on),
- cpu idle latency tracing not included


  [PATCH 1/4] perf: cleanup power events API
  [PATCH 2/4] perf: add OMAP support for the new power events
  [PATCH 3/4] perf: add calls to suspend trace point
  [PATCH 4/4] perf: provide a DEPRECTAED power trace API to user space
