From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 6/6] ARM: dts: am43x-epos-evm: Disable QSPI to prevent conflict with GPMC-NAND
Date: Tue, 2 Sep 2014 16:57:07 +0300
Message-ID: <1409666227-20622-7-git-send-email-rogerq@ti.com>
References: <1409666227-20622-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49577 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753979AbaIBN5X (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 2 Sep 2014 09:57:23 -0400
In-Reply-To: <1409666227-20622-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: pekon@pek-sem.com, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>, Sourav Poddar <sourav.poddar@ti.com>

Both QSPI and GPMC-NAND share the same Pin (A8) from the SoC for Chip Select
functionality. So both can't be enabled simultaneously.

Disable QSPI node to prevent the pin conflict as well as
be similar to 3.12 release.

CC: Sourav Poddar <sourav.poddar@ti.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/am43x-epos-evm.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index b489b27..ac3e485 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -435,7 +435,7 @@
 };
 
 &gpmc {
-	status = "okay";
+	status = "okay";	/* Disable QSPI when enabling GPMC (NAND) */
 	pinctrl-names = "default";
 	pinctrl-0 = <&nand_flash_x8>;
 	ranges = <0 0 0x08000000 0x10000000>;	/* CS0: NAND */
@@ -556,7 +556,7 @@
 };
 
 &qspi {
-	status = "okay";
+	status = "disabled";	/* Disable GPMC (NAND) when enabling QSPI */
 	pinctrl-names = "default";
 	pinctrl-0 = <&qspi1_default>;
 
-- 
1.8.3.2

