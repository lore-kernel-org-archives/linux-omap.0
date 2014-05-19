From: Pekon Gupta <pekon@ti.com>
Subject: [PATCH v4 4/4] mtd: nand: omap: Documentation: How to select correct ECC scheme for your device ?
Date: Mon, 19 May 2014 13:24:42 +0530
Message-ID: <1400486082-4345-5-git-send-email-pekon@ti.com>
References: <1400486082-4345-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54570 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751621AbaESHzc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 May 2014 03:55:32 -0400
In-Reply-To: <1400486082-4345-1-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-mtd <linux-mtd@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Stefan Roese <sr@denx.de>, Felipe Balbi <balbi@ti.com>, Pekon Gupta <pekon@ti.com>, devicetree@vger.kernel.org

 - Adds DT binding property for BCH16 ECC scheme
 - Adds describes on factors which determine choice of ECC scheme for particular device

CC: devicetree@vger.kernel.org
Signed-off-by: Pekon Gupta <pekon@ti.com>
---
 .../devicetree/bindings/mtd/gpmc-nand.txt          | 45 ++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/gpmc-nand.txt b/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
index 5e1f31b..eb81435 100644
--- a/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
+++ b/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
@@ -28,6 +28,8 @@ Optional properties:
 		"ham1"		1-bit Hamming ecc code
 		"bch4"		4-bit BCH ecc code
 		"bch8"		8-bit BCH ecc code
+		"bch16"		16-bit BCH ECC code
+		Refer below "How to select correct ECC scheme for your device ?"
 
  - ti,nand-xfer-type:		A string setting the data transfer type. One of:
 
@@ -90,3 +92,46 @@ Example for an AM33xx board:
 		};
 	};
 
+How to select correct ECC scheme for your device ?
+--------------------------------------------------
+Higher ECC scheme usually means better protection against bit-flips and
+increased system lifetime. However, selection of ECC scheme is dependent
+on various other factors also like;
+
+(1) support of built in hardware engines.
+	Some legacy OMAP SoC do not have ELM harware engine, so those SoC cannot
+	support ecc-schemes with hardware error-correction (BCHx_HW). However
+	such SoC can use ecc-schemes with software library for error-correction
+	(BCHx_HW_DETECTION_SW). The error correction capability with software
+	library remains equivalent to their hardware counter-part, but there is
+	slight CPU penalty when too many bit-flips are detected during reads.
+
+(2) Device parameters like OOBSIZE.
+	Other factor which governs the selection of ecc-scheme is oob-size.
+	Higher ECC schemes require more OOB/Spare area to store ECC syndrome,
+	so the device should have enough free bytes available its OOB/Spare
+	area to accomodate ECC for entire page. In general following expression
+	helps in determining if given device can accomodate ECC syndrome:
+	"2 + (PAGESIZE / 512) * ECC_BYTES" >= OOBSIZE"
+	where
+		OOBSIZE		number of bytes in OOB/spare area
+		PAGESIZE	number of bytes in main-area of device page
+		ECC_BYTES	number of ECC bytes generated to protect
+		                512 bytes of data, which is:
+				'3' for HAM1_xx ecc schemes
+				'7' for BCH4_xx ecc schemes
+				'14' for BCH8_xx ecc schemes
+				'26' for BCH16_xx ecc schemes
+
+	Example(a): For a device with PAGESIZE = 2048 and OOBSIZE = 64 and
+		trying to use BCH16 (ECC_BYTES=26) ecc-scheme.
+		Number of ECC bytes per page = (2 + (2048 / 512) * 26) = 106 B
+		which is greater than capacity of NAND device (OOBSIZE=64)
+		Hence, BCH16 cannot be supported on given device. But it can
+		probably use lower ecc-schemes like BCH8.
+
+	Example(b): For a device with PAGESIZE = 2048 and OOBSIZE = 128 and
+		trying to use BCH16 (ECC_BYTES=26) ecc-scheme.
+		Number of ECC bytes per page = (2 + (2048 / 512) * 26) = 106 B
+		which can be accomodate in the OOB/Spare area of this device
+		(OOBSIZE=128). So this device can use BCH16 ecc-scheme.
-- 
1.8.5.1.163.gd7aced9

