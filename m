From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: Suspend/Resume support with Omap2fb
Date: Wed, 11 Mar 2009 12:25:14 +0530
Message-ID: <19F8576C6E063C45BE387C64729E73940427C51975@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52978 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751120AbZCKGzY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Mar 2009 02:55:24 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n2B6tGid016278
	for <linux-omap@vger.kernel.org>; Wed, 11 Mar 2009 01:55:21 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n2B6tFTe012844
	for <linux-omap@vger.kernel.org>; Wed, 11 Mar 2009 12:25:15 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

I am using New Frame-Buffer driver which is based on DSS2 library submitted by Tomi, and I am trying to add full power management support. But things are not working out as expected, every time when I am issuing command "echo mem > /sys/power/state" the system doesn't go into off state. It always points to dss_prwdm, below are the steps I am following - 

	- Build the kernel with CPU_IDLE
	- Enable all the PM flags 

		# echo 1 > /sys/power/sleep_while_idle
		# echo 1 > /sys/power/clocks_off_while_idle
		# echo 1 > /sys/power/enable_off_mode

 	- From Linux prompt issue command 

		# echo mem > /sys/power/state

The log is - 
------------

root@arago:~# echo mem > /sys/power/state
<6>PM: Syncing filesystems ... PM: Syncing filesystems ... done.
done.
Freezing user space processes ... Freezing user space processes ... (elapsed 0.00 seconds) (elapsed 0.00 seconds) done.
done.
Freezing remaining freezable tasks ... Freezing remaining freezable tasks ... (elapsed 0.06 seconds) (elapsed 0.06 seconds) done.done.
Suspending console(s) (use no_console_suspend to debug)
Suspending console(s) (use no_console_suspend to debug)
<6>omap-backlight: suspending...
omapfb_suspend

omapfb_resume
<6>omap-backlight: resuming...
omap-backlight: suspending...
omapfb_suspend
Powerdomain (core_pwrdm) didn't enter target state 0
Powerdomain (dss_pwrdm) didn't enter target state 0
Powerdomain (per_pwrdm) didn't enter target state 0
Could not enter target state in pm_suspend
eth0: link down
omapfb_resume
omap-backlight: resuming...
Restarting tasks ... Restarting tasks ... done.
done.

root@arago:~#


Some analysis which I observed during debugging this issue - 

	- The root-cause is, DSS PowerDomain always shows it is in ON state (PWRDM_POWER_ON), and if I understand correctly this is only dependent on clocks. But I am making sure that DSS clocks are disabled. And with CPU_IDLE enabled I am going to complete OFF state. (/sys/devices/system/cpu/cpu0/cpuidle/state5/usage is incrementing).

	- If I compile out framebuffer driver and include DSS2 and V4L2 driver, everything works fine. I am not sure how "omapfb" is being tied with PowerDomain. Again I have seen references in arch/arm/mach-omap2/omapdev3xxx.h to the pdev_name = "omapfb", not sure how this is being used. 
 
I believe if system is hitting OFF state, then my enable/disable paths are proper, but really not sure about why "mem" is causing problem here.

Thanks,
Vaibhav Hiremath
Platform Support Products
Texas Instruments Inc
Ph: +91-80-25099927


Thanks,
Vaibhav Hiremath
Platform Support Products
Texas Instruments Inc
Ph: +91-80-25099927

