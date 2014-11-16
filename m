From: Ran Shalit <ranshalit@gmail.com>
Subject: Fail to enter retention
Date: Sun, 16 Nov 2014 22:10:35 +0200
Message-ID: <CAJ2oMh+jALrwq8sOf84+zK-0=vSS790jsW-jjgZtBCXvJDuG4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:61862 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751589AbaKPUKh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 16 Nov 2014 15:10:37 -0500
Received: by mail-wi0-f176.google.com with SMTP id ex7so3882195wid.3
        for <linux-omap@vger.kernel.org>; Sun, 16 Nov 2014 12:10:35 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello,

I'm using OMAP3530 with custom board. I have enabled all power mode
features as described in PSP wiki, but it still fails to enter any
state different from state0.

~ # cat /dbg/pm_debug/count
usbhost_pwrdm (ON),OFF:0,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
sgx_pwrdm (OFF),OFF:1,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
per_pwrdm (ON),OFF:0,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
dss_pwrdm (ON),OFF:0,RET:3,INA:4,ON:7,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
cam_pwrdm (RET),OFF:0,RET:1,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
core_pwrdm (ON),OFF:0,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,RET-MEMBANK2-OFF:0
neon_pwrdm (ON),OFF:0,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0
mpu_pwrdm (ON),OFF:0,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
iva2_pwrdm (RET),OFF:0,RET:1,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,RET-MEMBANK2-OFF:0,RET-MEMBANK3-OFF:0,RET-MEMBANK4-OFF:0
per_clkdm->per_pwrdm (11)
usbhost_clkdm->usbhost_pwrdm (3)
cam_clkdm->cam_pwrdm (0)
dss_clkdm->dss_pwrdm (2)
core_l4_clkdm->core_pwrdm (12)
core_l3_clkdm->core_pwrdm (4)
d2d_clkdm->core_pwrdm (0)
sgx_clkdm->sgx_pwrdm (0)
iva2_clkdm->iva2_pwrdm (0)
neon_clkdm->neon_pwrdm (0)
mpu_clkdm->mpu_pwrdm (0)
prm_clkdm->wkup_pwrdm (0)
cm_clkdm->core_pwrdm (0)

The next thing was trying to get the uart to sleep (though there might
be also problems with other domains ?) .

On trying to enable uart as wakeup source I get the following:

echo enabled >  /sys/devices/platform/omap/omap_uart.2/power/wakeup

cat  /sys/devices/platform/omap/omap_uart.2/power/wakeup

#> disabled      (?????)

echo 1 >  /sys/devices/platform/omap/omap_uart.2/sleep_timeout
~ # [   85.006622] omap_device: omap_uart.2: new worst case deactivate
latency 0: 61035
[   85.559844] omap_device: omap_uart.2: new worst case activate
latency 0: 61035
[  982.415161] omap_device: omap_uart.2: new worst case deactivate
latency 0: 91552

< console hangs here >



Thanks for any suggestions,

Ran
