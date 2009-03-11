From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: Suspend/Resume support with Omap2fb
Date: Wed, 11 Mar 2009 09:53:10 +0200
Message-ID: <1236757990.12797.20.camel@tubuntu>
References: <19F8576C6E063C45BE387C64729E73940427C51975@dbde02.ent.ti.com>
Reply-To: tomi.valkeinen@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:62764 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750835AbZCKHx1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Mar 2009 03:53:27 -0400
In-Reply-To: <19F8576C6E063C45BE387C64729E73940427C51975@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Wed, 2009-03-11 at 07:55 +0100, ext Hiremath, Vaibhav wrote:
> Hi,
> 
> I am using New Frame-Buffer driver which is based on DSS2 library submitted by Tomi, and I am trying to add full power management support. But things are not working out as expected, every time when I am issuing command "echo mem > /sys/power/state" the system doesn't go into off state. It always points to dss_prwdm, below are the steps I am following - 

OFF mode should work. I have verified it with DSI, DPI and SDI. However,
it needs passing the get_last_off_on_transaction_id pointer in
omap_dss_platform_data.

Also, see below.

> 	- Build the kernel with CPU_IDLE
> 	- Enable all the PM flags 
> 
> 		# echo 1 > /sys/power/sleep_while_idle
> 		# echo 1 > /sys/power/clocks_off_while_idle
> 		# echo 1 > /sys/power/enable_off_mode
> 
>  	- From Linux prompt issue command 
> 
> 		# echo mem > /sys/power/state
> 
> The log is - 
> ------------
> 
> root@arago:~# echo mem > /sys/power/state
> <6>PM: Syncing filesystems ... PM: Syncing filesystems ... done.
> done.
> Freezing user space processes ... Freezing user space processes ... (elapsed 0.00 seconds) (elapsed 0.00 seconds) done.
> done.
> Freezing remaining freezable tasks ... Freezing remaining freezable tasks ... (elapsed 0.06 seconds) (elapsed 0.06 seconds) done.done.
> Suspending console(s) (use no_console_suspend to debug)
> Suspending console(s) (use no_console_suspend to debug)
> <6>omap-backlight: suspending...
> omapfb_suspend
> 
> omapfb_resume
> <6>omap-backlight: resuming...
> omap-backlight: suspending...
> omapfb_suspend
> Powerdomain (core_pwrdm) didn't enter target state 0
> Powerdomain (dss_pwrdm) didn't enter target state 0
> Powerdomain (per_pwrdm) didn't enter target state 0
> Could not enter target state in pm_suspend
> eth0: link down
> omapfb_resume
> omap-backlight: resuming...
> Restarting tasks ... Restarting tasks ... done.
> done.
> 
> root@arago:~#
> 
> 
> Some analysis which I observed during debugging this issue - 
> 
> 	- The root-cause is, DSS PowerDomain always shows it is in ON state (PWRDM_POWER_ON), and if I understand correctly this is only dependent on clocks. But I am making sure that DSS clocks are disabled. And with CPU_IDLE enabled I am going to complete OFF state. (/sys/devices/system/cpu/cpu0/cpuidle/state5/usage is incrementing).
> 
> 	- If I compile out framebuffer driver and include DSS2 and V4L2 driver, everything works fine. I am not sure how "omapfb" is being tied with PowerDomain. Again I have seen references in arch/arm/mach-omap2/omapdev3xxx.h to the pdev_name = "omapfb", not sure how this is being used. 

You have to change it to omapdss (or omap-dss in earlier DSS2 versions).

 Tomi

>  
> I believe if system is hitting OFF state, then my enable/disable paths are proper, but really not sure about why "mem" is causing problem here.
> 
> Thanks,
> Vaibhav Hiremath
> Platform Support Products
> Texas Instruments Inc
> Ph: +91-80-25099927
> 
> 
> Thanks,
> Vaibhav Hiremath
> Platform Support Products
> Texas Instruments Inc
> Ph: +91-80-25099927
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

