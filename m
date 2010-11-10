From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: BeagleBoard not resuming from uart with latest pm-core ?
Date: Wed, 10 Nov 2010 16:44:14 +0100
Message-ID: <20101110164414.4529cbda@surf>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:35988 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756240Ab0KJPoW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Nov 2010 10:44:22 -0500
Received: from surf (humanoidz.org [82.247.183.72])
	by mail.free-electrons.com (Postfix) with ESMTPA id 4BDF511D
	for <linux-omap@vger.kernel.org>; Wed, 10 Nov 2010 16:44:15 +0100 (CET)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello,

I've updated my tree to the last pm-core branch today (I'm at commit
42289e226ec996a13ab8a2aaef5ad9dda61ee57e), and I've built the
omap2plus_defconfig with no change (except adding an initramfs). On my
BeagleBoard, I enable the wakeup from UART
in /sys/devices/platform/omap/omap-hsuart.2/tty/ttyO2/power/wakeup,
then trigger suspend to RAM. It enters suspend to RAM, but then
it doesn't wakeup when I send data through the UART.

Is it a known problem, or is again a mistake on my side ?

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
