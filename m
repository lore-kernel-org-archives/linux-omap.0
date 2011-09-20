From: Tasslehoff Kjappfot <tasskjapp@gmail.com>
Subject: suspend/resume trouble on 2.6.39
Date: Tue, 20 Sep 2011 10:00:18 +0200
Message-ID: <CAJJ=G6_MahLmGowi97smwDhNfimOqN7dOKWEOOhBBTWVZjTHog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:47986 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752796Ab1ITIAT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Sep 2011 04:00:19 -0400
Received: by iaqq3 with SMTP id q3so349936iaq.19
        for <linux-omap@vger.kernel.org>; Tue, 20 Sep 2011 01:00:19 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

I have problems making suspend/resume work on 2.6.39 from
org.openembedded.dev. I believe this kernel has most/all functionality
from the pm-branch. I've tested on Beagleboard C3 (which never
resumes), and slightly modified C3 (which resumes, but says that it
had problems with core_pwrdm). Below is some output from the latter.

Output from suspend/resume:
root@proto:~# echo mem > /sys/power/state
[  165.707061] PM: Syncing filesystems ... done.
^C[  186.674713] Freezing user space processes ... (elapsed 0.02 seconds) done.
[  186.703308] Freezing remaining freezable tasks ... (elapsed 0.02
seconds) done.
[  186.734863] Suspending console(s) (use no_console_suspend to debug)
[  186.859222] omap_device: usbhs_omap.-1: new worst case deactivate
latency 0: 61035
[  186.860931] PM: suspend of devices complete after 118.225 msecs
[  186.861663] PM: late suspend of devices complete after 0.701 msecs
[  186.862152] omap_device: omap_uart.1: new worst case deactivate
latency 0: 30517
[  193.183654] Powerdomain (core_pwrdm) didn't enter target state 1
[  193.183685] Could not enter target state in pm_suspend
[  193.184448] PM: early resume of devices complete after 0.579 msecs
[  193.570251] PM: resume of devices complete after 385.467 msecs
[  193.624176] Restarting tasks ... done.

mem
root@proto:~#


Before suspend:

root@proto:~# cat /debug/pm_debug/count
usbhost_pwrdm (ON),OFF:0,RET:0,INA:1,ON:2,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
sgx_pwrdm (OFF),OFF:1,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
per_pwrdm (ON),OFF:0,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
dss_pwrdm (ON),OFF:0,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
cam_pwrdm (RET),OFF:0,RET:1,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
core_pwrdm (ON),OFF:0,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,RET-MEMBANK2-OFF:0
neon_pwrdm (ON),OFF:0,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0
mpu_pwrdm (ON),OFF:0,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
iva2_pwrdm (RET),OFF:0,RET:1,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,RET-MEMBANK2-OFF:0,RET-MEMBANK3-OFF:0,RET-MEMBANK4-OFF:0
per_clkdm->per_pwrdm (20)
usbhost_clkdm->usbhost_pwrdm (3)
cam_clkdm->cam_pwrdm (0)
dss_clkdm->dss_pwrdm (3)
core_l4_clkdm->core_pwrdm (23)
core_l3_clkdm->core_pwrdm (5)
d2d_clkdm->core_pwrdm (0)
sgx_clkdm->sgx_pwrdm (0)
iva2_clkdm->iva2_pwrdm (0)
neon_clkdm->neon_pwrdm (0)
mpu_clkdm->mpu_pwrdm (0)
prm_clkdm->wkup_pwrdm (0)
cm_clkdm->core_pwrdm (0)

After suspend:

root@proto:~# cat /debug/pm_debug/count
usbhost_pwrdm (ON),OFF:0,RET:1,INA:1,ON:3,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
sgx_pwrdm (OFF),OFF:1,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
per_pwrdm (ON),OFF:0,RET:1,INA:0,ON:2,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
dss_pwrdm (ON),OFF:0,RET:1,INA:0,ON:2,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
cam_pwrdm (RET),OFF:0,RET:1,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
core_pwrdm (ON),OFF:0,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,RET-MEMBANK2-OFF:0
neon_pwrdm (ON),OFF:0,RET:1,INA:0,ON:2,RET-LOGIC-OFF:0
mpu_pwrdm (ON),OFF:0,RET:1,INA:0,ON:2,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
iva2_pwrdm (RET),OFF:0,RET:1,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,RET-MEMBANK2-OFF:0,RET-MEMBANK3-OFF:0,RET-MEMBANK4-OFF:0
per_clkdm->per_pwrdm (20)
usbhost_clkdm->usbhost_pwrdm (3)
cam_clkdm->cam_pwrdm (0)
dss_clkdm->dss_pwrdm (3)
core_l4_clkdm->core_pwrdm (23)
core_l3_clkdm->core_pwrdm (5)
d2d_clkdm->core_pwrdm (0)
sgx_clkdm->sgx_pwrdm (0)
iva2_clkdm->iva2_pwrdm (0)
neon_clkdm->neon_pwrdm (0)
mpu_clkdm->mpu_pwrdm (0)
prm_clkdm->wkup_pwrdm (0)
cm_clkdm->core_pwrdm (0)

I've started reading kernel source, but so far I have no idea what
could be wrong or how to debug this. Anyone got any ideas?

- Tasslehoff
