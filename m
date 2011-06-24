From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH 0/2] omap2+: pm: Fix code syntax and BogoMIPS
Date: Fri, 24 Jun 2011 16:05:40 +0530
Message-ID: <1308911742-27394-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33924 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753362Ab1FXKf5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Jun 2011 06:35:57 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Sanjeev Premi <premi@ti.com>

Current implementation was using "goto" to get to a basic
if..else structure - but wasn't too obvious on first few
reads.

Once the code was restructured, the relation between the
calls to cpufreq_scale() and cpufreq_notify_transition()
became obvious. And small trip to drivers/cpufreq/cpufreq.c
revealed double adjustment of the jiffies.

Though the patches may seem unrelated, but as described here
first led to second. Hence, submitting them together.

The BogoMIPS calculation has been tested on OMAP3EVM.

Before
======

[root@OMAP3EVM cpufreq]# cat scaling_available_frequencies
300000 600000 800000 1000000
[root@OMAP3EVM cpufreq]# cat /proc/cpuinfo
Processor       : ARMv7 Processor rev 2 (v7l)
BogoMIPS        : 298.32
Features        : swp half thumb fastmult vfp edsp thumbee neon vfpv3
CPU implementer : 0x41
CPU architecture: 7
CPU variant     : 0x3
CPU part        : 0xc08
CPU revision    : 2

Hardware        : OMAP3 EVM
Revision        : 0020
Serial          : 0000000000000000
[root@OMAP3EVM cpufreq]#
[root@OMAP3EVM cpufreq]#
[root@OMAP3EVM cpufreq]# echo 800000 > scaling_setspeed
[root@OMAP3EVM cpufreq]#
[root@OMAP3EVM cpufreq]#
[root@OMAP3EVM cpufreq]# cat /proc/cpuinfo
Processor       : ARMv7 Processor rev 2 (v7l)
BogoMIPS        : 2125.51
Features        : swp half thumb fastmult vfp edsp thumbee neon vfpv3
CPU implementer : 0x41
CPU architecture: 7
CPU variant     : 0x3
CPU part        : 0xc08
CPU revision    : 2

Hardware        : OMAP3 EVM
Revision        : 0020
Serial          : 0000000000000000
[root@OMAP3EVM cpufreq]#

After
=====

[root@OMAP3EVM cpufreq]# cat scaling_available_frequencies
300000 600000 800000 1000000
[root@OMAP3EVM cpufreq]# cat /proc/cpuinfo
Processor       : ARMv7 Processor rev 2 (v7l)
BogoMIPS        : 597.64
Features        : swp half thumb fastmult vfp edsp thumbee neon vfpv3
CPU implementer : 0x41
CPU architecture: 7
CPU variant     : 0x3
CPU part        : 0xc08
CPU revision    : 2

Hardware        : OMAP3 EVM
Revision        : 0020
Serial          : 0000000000000000
[root@OMAP3EVM cpufreq]# echo 300000 > scaling_setspeed
[root@OMAP3EVM cpufreq]# cat /proc/cpuinfo
Processor       : ARMv7 Processor rev 2 (v7l)
BogoMIPS        : 298.32
Features        : swp half thumb fastmult vfp edsp thumbee neon vfpv3
CPU implementer : 0x41
CPU architecture: 7
CPU variant     : 0x3
CPU part        : 0xc08
CPU revision    : 2

Hardware        : OMAP3 EVM
Revision        : 0020
Serial          : 0000000000000000
[root@OMAP3EVM cpufreq]# echo 600000 > scaling_setspeed
[root@OMAP3EVM cpufreq]# cat /proc/cpuinfo
Processor       : ARMv7 Processor rev 2 (v7l)
BogoMIPS        : 597.64
Features        : swp half thumb fastmult vfp edsp thumbee neon vfpv3
CPU implementer : 0x41
CPU architecture: 7
CPU variant     : 0x3
CPU part        : 0xc08
CPU revision    : 2

Hardware        : OMAP3 EVM
Revision        : 0020
Serial          : 0000000000000000
[root@OMAP3EVM cpufreq]# echo 800000 > scaling_setspeed
[root@OMAP3EVM cpufreq]# cat /proc/cpuinfo
Processor       : ARMv7 Processor rev 2 (v7l)
BogoMIPS        : 796.19
Features        : swp half thumb fastmult vfp edsp thumbee neon vfpv3
CPU implementer : 0x41
CPU architecture: 7
CPU variant     : 0x3
CPU part        : 0xc08
CPU revision    : 2

Hardware        : OMAP3 EVM
Revision        : 0020
Serial          : 0000000000000000
[root@OMAP3EVM cpufreq]#

PS: 800MHz and 1GHZ were enabled via out of tree patch - to be submitted soon.


I don't have an OMAP4 board handy. Confirmation that BogoMIPS
calculations are right on the platform will help.

The patchset applied on the 
40d1020 : rebuild PM from branches

Sanjeev Premi (2):
  omap2+: pm: Use if...else instead of goto
  omap2+: pm: cpufreq: Fix loops_per_jiffy calculation

 arch/arm/mach-omap2/omap2plus-cpufreq.c |   51 ++++++++----------------------
 1 files changed, 14 insertions(+), 37 deletions(-)

-- 
1.7.2.2

