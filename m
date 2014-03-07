From: Pekon Gupta <pekon@ti.com>
Subject: [PATCH v2 4/4] mtd: nand: omap: Documentation: How to select correct ECC scheme for your device ?
Date: Fri, 7 Mar 2014 18:54:53 +0530
Message-ID: <1394198693-8003-5-git-send-email-pekon@ti.com>
References: <1394198693-8003-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46965 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752533AbaCGN0d (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 7 Mar 2014 08:26:33 -0500
In-Reply-To: <1394198693-8003-1-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-mtd <linux-mtd@lists.infradead.org>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Stefan Roese <sr@denx.de>, Jon Cormier <jcormier@criticallink.com>, Daniel Mack <zonque@gmail.com>, Felipe Balbi <balbi@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Pekon Gupta <pekon@ti.com>

 - Adds DT binding property for BCH16 ECC scheme
 - Adds describes on factors which determine choice of ECC scheme for particular device

Signed-off-by: Pekon Gupta <pekon@ti.com>
---
 .../devicetree/bindings/mtd/gpmc-nand.txt          | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/gpmc-nand.txt b/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
index 5e1f31b..f2dbb33 100644
--- a/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
+++ b/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
@@ -28,6 +28,8 @@ Optional properties:
 		"ham1"		1-bit Hamming ecc code
 		"bch4"		4-bit BCH ecc code
 		"bch8"		8-bit BCH ecc code
+		"bch16"		16-bit BCH ECC code
+		Refer below "How to select correct ECC scheme for your device ?"
 
  - ti,nand-xfer-type:		A string setting the data transfer type. One of:
 
@@ -90,3 +92,40 @@ Example for an AM33xx board:
 		};
 	};
 
+How to select correct ECC scheme for your device ?
+--------------------------------------------------
+Higher ECC scheme usually means better protection against bit-flips and
+increased system lifetime. However, selection of ECC scheme is dependent
+on various other factors like;
+(1) Presence of supporting hardware engines on SoC.
+	Some legacy OMAP SoC do not have ELM h/w engine thus such SoC cannot
+	support BCHx_HW ECC schemes. But such SoC can support
+	BCHx_HW_DETECTION_SW ECC schemes which use s/w library with slight
+	CPU performance panalty only when too bit-flips are detected.
+(2) Device parameters like OOBSIZE
+	Higher ECC schemes require more OOB/Spare area to store ECC.
+	So choice of ECC scheme is limited by NAND oobsize. In general
+	following expression help determine whether given device can
+	accomodate ECC syndrome or not:
+	"2 + (PAGESIZE / 512) * ECC_BYTES" >= OOBSIZE
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
+	Example(a): For a device with PAGESIZE = 2048 and OOBSIZE = 64
+		Number of spare/OOB bytes required for using BCH16 ecc-scheme
+		"(2 + (2048 / 512) * 26) = 106 bytes" is greater than OOBSIZE
+		(As per above table for BCH16 ecc-scheme, ECC_BYTES = 26)
+		Thus BCH16 cannot be supported on 2K NAND with OOBSIZE=64 bytes
+
+	Example(b): For a device with PAGESIZE = 2048 and OOBSIZE = 128
+		Number of spare/OOB bytes required for using BCH16 ecc-scheme
+		"(2 + (2048 / 512) * 26) = 106 bytes" is less than OOBSIZE
+		(As per above table for BCH16 ecc-scheme, ECC_BYTES = 26)
+		Thus BCH16 can be supported on 4K NAND with OOBSIZE=128 bytes
-- 
1.8.5.1.163.gd7aced9

