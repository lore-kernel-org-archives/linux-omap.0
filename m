From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Suspend to RAM broken on BeagleBoard ?
Date: Fri, 10 Sep 2010 17:48:14 +0200
Message-ID: <20100910174814.6e5d439e@surf>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:58196 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754089Ab0IJPsW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Sep 2010 11:48:22 -0400
Received: from surf (humanoidz.org [82.247.183.72])
	by mail.free-electrons.com (Postfix) with ESMTPA id 16FC8E0
	for <linux-omap@vger.kernel.org>; Fri, 10 Sep 2010 17:48:13 +0200 (CEST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hello,

I've tested the current linux-omap Git tree and Kevin's pm-core branch
on a BeagleBoard using the omap3_defconfig, and when trying a suspend
to RAM, I get a "Class driver suspend failed for cpu0" :

# echo mem > /sys/power/state 
[   93.395050] PM: Syncing filesystems ... done.
[   93.410827] Freezing user space processes ... (elapsed 0.01 seconds) done.
[   93.434570] Freezing remaining freezable tasks ... (elapsed 0.01 seconds) done.
[   93.458557] Suspending console(s) (use no_console_suspend to debug)
[   93.590728] PM: suspend of devices complete after 119.629 msecs
[   93.593902] PM: late suspend of devices complete after 3.112 msecs
[   93.594421] Class driver suspend failed for cpu0
[   93.595153] PM: early resume of devices complete after 0.518 msecs
[   93.887603] PM: resume of devices complete after 292.052 msecs
[   93.922851] Restarting tasks ... done.

Is this a known issue ?

I also have a problem with USB support, both on linux-omap and Kevin's
pm-core branch. My USB Ethernet adapter, supported by the asix driver,
isn't detected anymore. With a pm git tree of a couple of weeks ago, it
was working. This is again with just a plain omap3_defconfig.

Thanks!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
