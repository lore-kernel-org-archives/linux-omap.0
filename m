From: Luke Gong <lukejgong@gmail.com>
Subject: beagle board cannot suspend to RAM
Date: Wed, 19 Jan 2011 19:45:51 -0500
Message-ID: <AANLkTimzk0rw+NrYF1kMtJqzbz4TSRw8UH3nxniG982k@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:61937 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753052Ab1ATAqD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Jan 2011 19:46:03 -0500
Received: by wwi17 with SMTP id 17so877930wwi.1
        for <linux-omap@vger.kernel.org>; Wed, 19 Jan 2011 16:46:01 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello,

I compiled linux-omap-pm kernel 2.6.32 enabling suspend to RAM. But
with this new kernel, the board freezes when I try to let it suspend
to ram. Here is the log:

root@beagleboard:~# echo mem > /sys/power/state
PM: Syncing filesystems ... done.
Freezing user space processes ... (elapsed 0.00 seconds) done.
Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
Suspending console(s) (use no_console_suspend to debug)
***************************************************************

I list part of config file to enable power management feature as well:

#
# Power management options
#
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
CONFIG_PM_SLEEP=y
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
# CONFIG_APM_EMULATION is not set
# CONFIG_PM_RUNTIME is not set
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_NET=y
*************************************************************

Any suggestion is appreciated.
--
Luke
