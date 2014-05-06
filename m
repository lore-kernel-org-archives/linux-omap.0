From: Andrew LeCain <alecain@google.com>
Subject: dss_pwrdm & core_pwrdm not entering sleep state correctly on am37xx
Date: Tue, 6 May 2014 12:09:40 -0700
Message-ID: <CABCN2SufRoYEDokszRJ4Xme91f6xsfXZ9M7=wp_CUGZaTXAteQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ig0-f176.google.com ([209.85.213.176]:51863 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751444AbaEFTJl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 May 2014 15:09:41 -0400
Received: by mail-ig0-f176.google.com with SMTP id hl10so6678498igb.3
        for <linux-omap@vger.kernel.org>; Tue, 06 May 2014 12:09:41 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

I'm trying to backport a display driver for an RFBI panel to 2.6.32,
but the dss_pwrdm is complaining about not entering target state:

root@02AA01AB381207S7# cat /sys/kernel/debug/pm_debug/count | grep dss
dss_pwrdm (ON),OFF:0,RET:11,INA:0,ON:12
dss_clkdm->dss_pwrdm (0)

root@02AA01AB381207S7# echo -n "mem" > /sys/power/state
PM: Syncing filesystems ... done.
PM: Preparing system for mem sleep
Freezing user space processes ... (elapsed 0.02 seconds) done.
Freezing remaining freezable tasks ... (elapsed 0.04 seconds) done.
PM: Entering mem sleep
spidev spi2.0: ... can't suspend
WLAN: Suspend call
WLAN_firmware Suspend
Wake locks are active (count: 0)
Shutting Down I&F Clock Interface
Powerdomain (core_pwrdm) didn't enter target state 0
Powerdomain (dss_pwrdm) didn't enter target state 0
Could not enter target state in pm_suspend
<snip>
#no change after attempted suspend.
root@02AA01AB381207S7# cat /sys/kernel/debug/pm_debug/count | grep dss

dss_pwrdm (ON),OFF:0,RET:11,INA:0,ON:12
dss_clkdm->dss_pwrdm (0)


I was worried it might be the dss clocks not being disabled, but I
instrumented dss_clk_(en|dis)able to print clock counts and it goes to
0 before suspending. I don't really understand what will prevent the
dss power domain from entering retain state or not, so any pointers
would be useful.

I'm less worried about the core_pwrdm error because that isn't a
regression from the old panel, and power numbers are low enough
without it, but any tips there would be great as well.

Thanks
-Andrew
