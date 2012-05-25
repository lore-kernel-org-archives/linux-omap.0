From: <jgq516@gmail.com>
Subject: [PATCH 0/3] omap3/omap4: add device tree support for wdt
Date: Fri, 25 May 2012 18:42:29 +0800
Message-ID: <1337942552-28218-1-git-send-email-jgq516@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:44714 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752927Ab2EYJ4f (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 May 2012 05:56:35 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux@arm.linux.org.uk, b-cousson@ti.com, rob.herring@calxeda.com, grant.likely@secretlab.ca, rnayak@ti.com, tony@atomide.com, wim@iguana.be
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-watchdog@vger.kernel.org

From: Xiao Jiang <jgq516@gmail.com>

This series can be applied to dt branch of linux-omap tree.

Since omap24xx series has different wdt base addr (omap2420: 0x48022000 and
omap2430: 0x49016000) per commit 2817142f31bfbf26c216bf4f9192540c81b2d071, so
I don't add wdt node in omap2.dtsi just like omap3 and omap4, maybe different
dts files are needed for omap2420 and omap2430.

Tested with omap4430 blaze board.

Xiao Jiang (3):
  arm/dts: add wdt node for omap3 and omap4
  OMAP: wdt: add device tree support
  watchdog: omap_wdt: add device tree support

 arch/arm/boot/dts/omap3.dtsi  |    5 +++++
 arch/arm/boot/dts/omap4.dtsi  |    5 +++++
 arch/arm/mach-omap2/devices.c |    2 +-
 drivers/watchdog/omap_wdt.c   |    8 ++++++++
 4 files changed, 19 insertions(+), 1 deletions(-)

-- 
1.7.3

