From: Thomas Renninger <trenn@suse.de>
Subject: Cleanup and fixes for power trace events
Date: Wed, 27 Oct 2010 01:43:21 +0200
Message-ID: <1288136605-10526-1-git-send-email-trenn@suse.de>
Return-path: <linux-trace-users-owner@vger.kernel.org>
Sender: linux-trace-users-owner@vger.kernel.org
To: arjan@linux.intel.com, jean.pihet@newoldbits.com, mingo@elte.hu, rjw@sisk.pl, linux-omap@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-trace-users@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


[PATCH 1/4] PERF: Do not export power_frequency, but power_start event
[PATCH 2/4] PERF(kernel): Cleanup power events V3
[PATCH 3/4] PERF(userspace): Adjust perf timechart to the new power events V3
[PATCH 4/4] PERF: fix power:cpu_idle double end events

