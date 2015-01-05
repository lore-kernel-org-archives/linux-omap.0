From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: dts: Revert disabling of smc91x for n900
Date: Mon, 5 Jan 2015 15:02:29 -0800
Message-ID: <20150105230228.GO4081@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:61266 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753214AbbAEXGV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Jan 2015 18:06:21 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Sebastian Reichel <sre@kernel.org>, Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>, Pavel Machek <pavel@ucw.cz>

Revert "ARM: dts: Disable smc91x on n900 until bootloader
dependency is removed". We've now fixed the issues that
caused problems with uninitialized hardware depending on
the bootloader version. Mostly things got fixed with
the following commits:

9a894953a97b ("ARM: dts: Fix bootloader version dependencies by muxing n900 smc91x pins")
7d2911c43815 ("net: smc91x: Fix gpios for device tree based booting")

Note that this only affects the early development boards
with Ethernet that we still have in a few automated boot
test systems.

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -702,9 +702,6 @@
 
 	ethernet@gpmc {
 		compatible = "smsc,lan91c94";
-
-		status = "disabled";
-
 		interrupt-parent = <&gpio2>;
 		interrupts = <22 IRQ_TYPE_LEVEL_HIGH>;	/* gpio54 */
 		reg = <1 0x300 0xf>;		/* 16 byte IO range at offset 0x300 */
