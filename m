From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [PATCH 2/2] ARM: dts: omap3-igep0030: Add NAND flash support
Date: Fri, 10 May 2013 21:31:11 +0200
Message-ID: <1368214271-22780-2-git-send-email-javier.martinez@collabora.co.uk>
References: <1368214271-22780-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:43416 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753089Ab3EJTbX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 May 2013 15:31:23 -0400
In-Reply-To: <1368214271-22780-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Enric Balletbo i Serra <eballetbo@gmail.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Javier Martinez Canillas <javier.martinez@collabora.co.uk>

The IGEP COM Module has an 512MB NAND flash memory.

Add a device node for this NAND and its parition layout.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 arch/arm/boot/dts/omap3-igep0020.dts |    1 +
 arch/arm/boot/dts/omap3-igep0030.dts |   50 ++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-igep0020.dts b/arch/arm/boot/dts/omap3-igep0020.dts
index 0ba4313..6f0ecf4 100644
--- a/arch/arm/boot/dts/omap3-igep0020.dts
+++ b/arch/arm/boot/dts/omap3-igep0020.dts
@@ -155,3 +155,4 @@
 		smsc,save-mac-address;
 	};
 };
+
diff --git a/arch/arm/boot/dts/omap3-igep0030.dts b/arch/arm/boot/dts/omap3-igep0030.dts
index 9dc48d2..6b71656 100644
--- a/arch/arm/boot/dts/omap3-igep0030.dts
+++ b/arch/arm/boot/dts/omap3-igep0030.dts
@@ -42,3 +42,53 @@
 		};
 	};
 };
+
+&gpmc {
+	ranges = <0 0 0x00000000 0x20000000>;
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
+};
\ No newline at end of file
-- 
1.7.7.6

