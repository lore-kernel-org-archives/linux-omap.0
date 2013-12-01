From: Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: [PATCH] ARM: dts: omap3-igep00x0: Fix nand ECC to maintain backward compatibility.
Date: Sun,  1 Dec 2013 12:23:15 +0100
Message-ID: <1385896995-16803-1-git-send-email-eballetbo@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:51622 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751807Ab3LAL0W (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 1 Dec 2013 06:26:22 -0500
Received: by mail-wg0-f41.google.com with SMTP id y10so3249785wgg.4
        for <linux-omap@vger.kernel.org>; Sun, 01 Dec 2013 03:26:21 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <martinez.javier@gmail.com>, linux-omap@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: Enric Balletbo i Serra <eballetbo@gmail.com>

Legacy board files for IGEP Processor Boards used 1-bit Hamming ECC layout but
new DT uses BCH8 software layout. This breaks the backward compatibility for
people that used board files before and switch to DT and have the problem that
they can't flash the rootfs using the bootloader.

This patch sets the ECC layout to 1-bit Hamming ECC in order to maintain this
compatibility.

Reported-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Reported-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Signed-off-by: Enric Balletbo i Serra <eballetbo@gmail.com>
---
 arch/arm/boot/dts/omap3-igep0020.dts | 2 +-
 arch/arm/boot/dts/omap3-igep0030.dts | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-igep0020.dts b/arch/arm/boot/dts/omap3-igep0020.dts
index d5cc792..4229e94 100644
--- a/arch/arm/boot/dts/omap3-igep0020.dts
+++ b/arch/arm/boot/dts/omap3-igep0020.dts
@@ -116,7 +116,7 @@
 		linux,mtd-name= "micron,mt29c4g96maz";
 		reg = <0 0 0>;
 		nand-bus-width = <16>;
-		ti,nand-ecc-opt = "bch8";
+		ti,nand-ecc-opt = "ham1";
 
 		gpmc,sync-clk-ps = <0>;
 		gpmc,cs-on-ns = <0>;
diff --git a/arch/arm/boot/dts/omap3-igep0030.dts b/arch/arm/boot/dts/omap3-igep0030.dts
index 525e6d9..9043e97 100644
--- a/arch/arm/boot/dts/omap3-igep0030.dts
+++ b/arch/arm/boot/dts/omap3-igep0030.dts
@@ -59,7 +59,7 @@
 		linux,mtd-name= "micron,mt29c4g96maz";
 		reg = <0 0 0>;
 		nand-bus-width = <16>;
-		ti,nand-ecc-opt = "bch8";
+		ti,nand-ecc-opt = "ham1";
 
 		gpmc,sync-clk-ps = <0>;
 		gpmc,cs-on-ns = <0>;
-- 
1.8.1.2

