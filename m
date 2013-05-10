From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [PATCH 1/2] ARM: dts: omap3-igep0020: Add NAND flash support
Date: Fri, 10 May 2013 21:31:10 +0200
Message-ID: <1368214271-22780-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:43405 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753089Ab3EJTbT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 May 2013 15:31:19 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Enric Balletbo i Serra <eballetbo@gmail.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Javier Martinez Canillas <javier.martinez@collabora.co.uk>

The IGEPv2 board has an 512MB NAND flash memory.

Add a device node for this NAND and its parition layout.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---

Benoit,

This patch depends on a previous posted patch:

[PATCH] ARM: dts: omap3-igep0020: Add SMSC911x LAN chip support

Best regards,
Javier

 arch/arm/boot/dts/omap3-igep0020.dts |   50 +++++++++++++++++++++++++++++++++-
 1 files changed, 49 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-igep0020.dts b/arch/arm/boot/dts/omap3-igep0020.dts
index 4bac32e..0ba4313 100644
--- a/arch/arm/boot/dts/omap3-igep0020.dts
+++ b/arch/arm/boot/dts/omap3-igep0020.dts
@@ -68,7 +68,55 @@
 };
 
 &gpmc {
-	ranges = <5 0 0x2c000000 0x1000000>;
+	ranges = <0 0 0x00000000 0x20000000>,
+		 <5 0 0x2c000000 0x01000000>;
+
+	nand@0,0 {
+		linux,mtd-name= "micron,mt29c4g96maz";
+		reg = <0 0 0>;
+		nand-bus-width = <16>;
+		ti,nand-ecc-opt = "bch8";
+
+		gpmc,sync-clk-ps = <0>;
+		gpmc,cs-on-ns = <0>;
+		gpmc,cs-rd-off-ns = <44>;
+		gpmc,cs-wr-off-ns = <44>;
+		gpmc,adv-on-ns = <6>;
+		gpmc,adv-rd-off-ns = <34>;
+		gpmc,adv-wr-off-ns = <44>;
+		gpmc,we-off-ns = <40>;
+		gpmc,oe-off-ns = <54>;
+		gpmc,access-ns = <64>;
+		gpmc,rd-cycle-ns = <82>;
+		gpmc,wr-cycle-ns = <82>;
+		gpmc,wr-access-ns = <40>;
+		gpmc,wr-data-mux-bus-ns = <0>;
+
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		partition@0 {
+			label = "SPL";
+			reg = <0 0x100000>;
+		};
+		partition@0x80000 {
+			label = "U-Boot";
+			reg = <0x100000 0x180000>;
+		};
+		partition@0x1c0000 {
+			label = "Environment";
+			reg = <0x280000 0x100000>;
+		};
+		partition@0x280000 {
+			label = "Kernel";
+			reg = <0x380000 0x300000>;
+		};
+		partition@0x780000 {
+			label = "Filesystem";
+			reg = <0x680000 0x1f980000>;
+		};
+	};
+
 	ethernet@5,0 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&smsc911x_pins>;
-- 
1.7.7.6

