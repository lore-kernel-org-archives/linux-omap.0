From: Abraham Arce <abraham.arce.moreno@gmail.com>
Subject: [linux-omap-pm] some test results
Date: Tue, 26 May 2009 00:10:16 -0500
Message-ID: <cb8016980905252210n9ffca22u6a469796e6cdead5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f166.google.com ([209.85.217.166]:51621 "EHLO
	mail-gx0-f166.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751347AbZEZFKP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 May 2009 01:10:15 -0400
Received: by gxk10 with SMTP id 10so6250605gxk.13
        for <linux-omap@vger.kernel.org>; Mon, 25 May 2009 22:10:16 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: omap <linux-omap@vger.kernel.org>

Hi,

Find some some results after applying some level of testing to
linux-omap-pm tree. Please let me know any question you may have.

-> Board
 OMAP ES3.1, TRITON2 ES3.1

-> Kernel Tree
 git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git
Commit
 417a059f1bac2781ce10ad614d31b5a17513d469
 OMAP3: PM: remove save/restore of exception handler state

-> Default K Configuration
 omap_3430sdp_pm_defconfig

The following configurations have been tested so far

 Default K Configuration + [*] No PM layer
 Default K Configuration + [*] No-op/debug PM layer
 Default K Configuration + [*] PM layer implemented using SRF
 Default K Configuration + [ ] Power Management support + [*] No PM layer
 Default K Configuration + [ ] Power Management support + [*]
No-op/debug PM layer

-> U-Boot Tree
 git://git.omapzoom.org/repo/u-boot.git
Commit
 80441279e3aecd8b8ca020faf65990d52978843b
 Uboot Use tag of head in the local version.

-> Toolchain
 Sourcery G++ Lite 2008q3-72

-> Filesystem
 8 MB, Ramdisk

-> Messages at boot up time, taking Default K Configuration
 .....
 Reprogramming SDRC
 dpll3_m2_clk rate change failed: -22
 .....
 clock: dpll5_ck failed transition to 'locked'
 .....
 SR1: VDD autocomp is not active
 .....

-> The following issues apply for the following configurations
 - Taking Default K Configuration + [*] No PM layer
 - Taking Default K Configuration + [*] No-op/debug PM layer
 - Taking Default K Configuration + [*] PM layer implemented using SRF

* All the issues were confirmed after booting the board with no
previous activity
* Using both wake up modes, manual and GPT

{1}
Error messages when enabling /sys/power/sleep_while_idle
 # echo 1 > /sys/power/sleep_while_idle
 omapfb omapfb: irq error status 00e2
 omapfb omapfb: irq error status 00c2
 omapfb omapfb: irq error status 0060
 __ratelimit: 1750 callbacks suppressed
 Spurious irq 95: 0xffffffdf, please flush posted write for irq 25

{2}
omapfb message when resuming
 # echo 1 > /sys/power/sleep_while_idle
 # echo mem > /sys/power/state
 PM: Syncing filesystems ... done.
 ......
 omapfb omapfb: timeout waiting for FRAME DONE

{3}
SYS_OFF_MODE Led won't light up red the first time
 # echo 1 > /sys/power/sleep_while_idle
 # echo 1 > /sys/power/enable_off_mode
 # echo 1 > /sys/power/voltage_off_while_idle
 # echo 1 > /sys/devices/platform/serial8250.0/sleep_timeout
 # echo mem > /sys/power/state
 SYS_OFF_MODE Led | Green Light
 VCORE_EN Led | Green Light
 # echo mem > /sys/power/state
 SYS_OFF_MODE Led | Red Light
 VCORE_EN Led | Green Light

* VCORE_EN Led will not go out if /sys/power/enable_off_mode is enabled
* SYS_OFF_MODE can light up red the first time following the above
steps but if no activity is present in console for more than 30
seconds before suspending, as

 # echo 1 > /sys/power/sleep_while_idle
 # echo 1 > /sys/power/enable_off_mode
 # echo 1 > /sys/power/voltage_off_while_idle
 # echo 1 > /sys/devices/platform/serial8250.0/sleep_timeout
 <wait for more than 30 seconds>
 # echo mem > /sys/power/state

{4}
System is rebooting when suspending several times, the steps to reproduce are
as follows but not 100% reproducible, "x seconds" can vary
 # echo 1 > /sys/power/sleep_while_idle
 # echo 1 > /sys/power/enable_off_mode
 # echo 1 > /sys/power/voltage_off_while_idle
  <wait for x seconds>
 # echo mem > /sys/power/state
 PM: Syncing filesystems ... done.
 Freezing user space processes ... (elapsed 0.00 seconds) done.
 Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
 Suspending console(s) (use no_console_suspend to debug)
  <wait for x seconds>
 omapfb omapfb: timeout waiting for FRAME DONE
 Successfully put all powerdomains to target state
 Restarting tasks ... done.
 # echo mem > /sys/power/state
 PM: Syncing filesystems ... done.
 Freezing user space processes ... (elapsed 0.00 seconds) done.
 Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
 Suspending console(s) (use no_console_suspend to debug)


 U-Boot 1.1.4-g80441279 (May 14 2009 - 23:46:51)


-> Power Management Tester > https://garage.maemo.org/projects/pm-test/
This is considered to be tested, I'll give details when it is done...

Best Regards
Abraham
