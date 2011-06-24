From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCHv2] omap2+: pm: cpufreq: Fix loops_per_jiffy calculation
Date: Fri, 24 Jun 2011 19:29:48 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024D6C2EE5@dbde02.ent.ti.com>
References: <1308923618-5333-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42672 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753244Ab1FXOAi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Jun 2011 10:00:38 -0400
In-Reply-To: <1308923618-5333-1-git-send-email-premi@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

> -----Original Message-----
> From: Premi, Sanjeev 
> Sent: Friday, June 24, 2011 7:24 PM
> To: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Cc: Premi, Sanjeev
> Subject: [PATCHv2] omap2+: pm: cpufreq: Fix loops_per_jiffy 
> calculation
> 
> Currently, loops_per_jiffy is being calculated twice for
> non-SMP processors.
>  - Before calling cpufreq_notify_transition()
>  - From within cpufreq_notify_transition()
> 
> Double adjustment leads to incorrect value being assigned to
> loops_per_jiffy. This manifests as incorrect BogoMIPS in
> "cat /proc/cpuinfo".
> 
> The value of loops_per_jiffy needs to be calculated only
> when CONFIG_SMP is true. It is the core change included
> in this patch.
> 
> The patch also leverages the definition of for_each_cpu()
> with and without CONFIG_SMP to consolidate the mechanism
> to call cpufreq_notify_transition().
> 
> Signed-off-by: Sanjeev Premi <premi@ti.com>
> ---
>  Changes since v1:
>    * loops_per_jiffy are updated when CONFIG_SMP is true.
>    * leverage definition of for_each_cpu()
> 
>  Tested on OMAP3EVM with and without CONFIG_SMP.
>  Since the log is rather long, will be posting the log in
>  a follow-up mail.
> 
[snip]...[snip]

Snapshot of test log - with and without SMP included here:

To ensure compile-time and run-time checks for SMP are visible,
the patch was tested with this code inserted at enty of function
omap_target().

#ifdef CONFIG_SMP
	printk (KERN_ERR "I am defined SMP!\n");
#else
	printk (KERN_ERR "I am not defined SMP!\n");
#endif
	if (is_smp())
		printk (KERN_ERR "Runtime evaluating to SMP!\n");
	else
		printk (KERN_ERR "Runtime evaluating to no SMP!\n");


With CONFIG_SMP disabled
========================

[root@OMAP3EVM /]# cd /sys/devices/system/cpu/cpu0/cpufreq/
[root@OMAP3EVM cpufreq]#
[root@OMAP3EVM cpufreq]#
[root@OMAP3EVM cpufreq]#
[root@OMAP3EVM cpufreq]# cat scaling_available_frequencies
300000 600000 800000 1000000
[root@OMAP3EVM cpufreq]#
[root@OMAP3EVM cpufreq]#
[root@OMAP3EVM cpufreq]#
[root@OMAP3EVM cpufreq]# echo 300000 > scaling_setspeed
[   56.278137] I am not defined SMP!
[   56.281768] Runtime evaluating to no SMP!
[root@OMAP3EVM cpufreq]#
[root@OMAP3EVM cpufreq]#
[root@OMAP3EVM cpufreq]#
[root@OMAP3EVM cpufreq]# cat cpuinfo_cur_freq
300000
[root@OMAP3EVM cpufreq]#
[root@OMAP3EVM cpufreq]#
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
[   96.938049] I am not defined SMP!
[   96.941833] Runtime evaluating to no SMP!
[root@OMAP3EVM cpufreq]#
[root@OMAP3EVM cpufreq]#
[root@OMAP3EVM cpufreq]#
[root@OMAP3EVM cpufreq]#
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
[root@OMAP3EVM cpufreq]#
[root@OMAP3EVM cpufreq]#
[root@OMAP3EVM cpufreq]# echo 100000 > scaling_setspeed
[  110.865631] I am not defined SMP!
[  110.870025] Runtime evaluating to no SMP!
[root@OMAP3EVM cpufreq]# echo 1000000 > scaling_setspeed
[  116.258941] I am not defined SMP!
[  116.262725] Runtime evaluating to no SMP!
[root@OMAP3EVM cpufreq]#
[root@OMAP3EVM cpufreq]#
[root@OMAP3EVM cpufreq]# cat cpuinfo_cur_freq
1000000
[root@OMAP3EVM cpufreq]#
[root@OMAP3EVM cpufreq]#
[root@OMAP3EVM cpufreq]# cat /proc/cpuinfo
Processor       : ARMv7 Processor rev 2 (v7l)
BogoMIPS        : 996.74
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

With CONFIG_SMP enabled
========================

[root@OMAP3EVM /]# cd /sys/devices/system/cpu/cpu0/cpufreq/
[root@OMAP3EVM cpufreq]#
[root@OMAP3EVM cpufreq]#
[root@OMAP3EVM cpufreq]#
[root@OMAP3EVM cpufreq]# cat scaling_available_frequencies
300000 600000 800000 1000000
[root@OMAP3EVM cpufreq]#
[root@OMAP3EVM cpufreq]#
[root@OMAP3EVM cpufreq]# echo 300000 > scaling_setspeed
[   25.040496] I am defined SMP!
[   25.043884] Runtime evaluating to no SMP!
[root@OMAP3EVM cpufreq]#
[root@OMAP3EVM cpufreq]#
[root@OMAP3EVM cpufreq]# cat /proc/cpuinfo
Processor       : ARMv7 Processor rev 2 (v7l)
processor       : 0
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
[root@OMAP3EVM cpufreq]# cat cpuinfo_cur_freq
300000
[root@OMAP3EVM cpufreq]#
[root@OMAP3EVM cpufreq]# echo 800000 > scaling_setspeed
[   46.333618] I am defined SMP!
[   46.336822] Runtime evaluating to no SMP!
[root@OMAP3EVM cpufreq]#
[root@OMAP3EVM cpufreq]#
[root@OMAP3EVM cpufreq]# cat cpuinfo_cur_freq
800000
[root@OMAP3EVM cpufreq]#
[root@OMAP3EVM cpufreq]#
[root@OMAP3EVM cpufreq]# cat /proc/cpuinfo
Processor       : ARMv7 Processor rev 2 (v7l)
processor       : 0
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
[root@OMAP3EVM cpufreq]#
[root@OMAP3EVM cpufreq]# echo 600000 > scaling_setspeed
[ 1344.705413] I am defined SMP!
[ 1344.709259] Runtime evaluating to no SMP!
[root@OMAP3EVM cpufreq]#
[root@OMAP3EVM cpufreq]#
[root@OMAP3EVM cpufreq]# cat /proc/cpuinfo
Processor       : ARMv7 Processor rev 2 (v7l)
processor       : 0
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
