From: Thomas Renninger <trenn@suse.de>
Subject: Cleanup and enhance power trace events
Date: Thu, 28 Oct 2010 11:02:56 +0200
Message-ID: <1288256579-22957-1-git-send-email-trenn@suse.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:52689 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752220Ab0J1JDD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Oct 2010 05:03:03 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: trenn@suse.de, linux-omap@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-trace-users@vger.kernel.org, jean.pihet@newoldbits.com, arjan@linux.intel.com, mingo@elte.hu, rjw@sisk.pl

Tested with:
acpi_idle and intel_idle as cpuidle drivers.
also tested perf timechart userspace tool without the new interface
and it still works fine with the new kernel changes.

There are quite some issues with the balance of cpu_idle
enter/leave a sleep state, but this was the case already.
perf timechart handles double "leave idle" events gracefully (should
still get fixed up at some time).

The first patch makes intel_idle cpuidle driver tracable, even
if compiled as a module.

Ingo: Can you please push these into an approprate git tree/branch.

Thanks,

    Thomas


