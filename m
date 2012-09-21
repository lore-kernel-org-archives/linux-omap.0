From: Chris Hoffmann <chrmhoffmann@gmail.com>
Subject: CPU_IDLE causes random reboots on custom 4430
Date: Sat, 22 Sep 2012 00:49:33 +0200
Message-ID: <505CEEFD.1080507@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:37534 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932852Ab2IUWti (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Sep 2012 18:49:38 -0400
Received: by weyx8 with SMTP id x8so2231041wey.19
        for <linux-omap@vger.kernel.org>; Fri, 21 Sep 2012 15:49:37 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

We're trying to get a custom 4430 board (aka. nook tablet with OMAP4430 
ES2.3 HS TWL6030 ES2.1) working with p-android-omap-3.0 on android jelly 
bean. The board works quite well, but we experience random hangs and the 
watchdog kicks the board to reboot.

The problem is that kmsg_last doesn't not show any useful information 
and the fiq debugger refuses to work when the device is locked up. We 
also enabled various kernel lock debugging configs to get more info ... 
in vain.

Experimenting with it for a while (removing non-standard drivers like 
accel, charger, battery, etc) we found that removing CONFIG_CPU_IDLE or 
setting disallow_smp_idle in cpuidle44xx.c seems to cure the random 
lockups and make the board work fine (apart from the maybe obvious 
consequences that it doesn't go to deep sleep anymore).

Further below a few sample infos from the board.

We'd very much appreciate any further help on how to proceed to find the 
root cause and happy to provide any more info from sys, debug or 
omapconf tool.

Rgds,
Chris

A dmesg from a normal boot:
https://dl.dropbox.com/u/21820416/CPU_IDLE_CRASH/dmesg.log

Kernel source:
https://github.com/Kuzma30/kernel3NookTablet/tree/jellybean

omapconf --cpuinfo
https://dl.dropbox.com/u/21820416/CPU_IDLE_CRASH/omapconf.cpuinfo

cat /sys/kernel/debug/clock/summary
https://dl.dropbox.com/u/21820416/CPU_IDLE_CRASH/clock.summary

... what else can we provide to track this down?
