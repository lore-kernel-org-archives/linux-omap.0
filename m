From: Franklin S Cooper Jr <fcooper@ti.com>
Subject: [PATCH 1/2] doc: dt: mtd: add w25q64 to list of supported SPI flashes
Date: Tue, 7 Mar 2017 15:57:50 -0600
Message-ID: <20170307215751.29266-2-fcooper@ti.com>
References: <20170307215751.29266-1-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170307215751.29266-1-fcooper@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-mtd@lists.infradead.org, tony@atomide.com, robh+dt@kernel.org
Cc: Sekhar Nori <nsekhar@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Sekhar Nori <nsekhar@ti.com>

W25Q64 is found on TI's AM335x ICEv2 board. Add it to list
for supported SPI flash devices. This flash can be identified
using JEDEC READ ID opcode.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt
index 3e920ec..9ce35af 100644
--- a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt
+++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt
@@ -40,6 +40,7 @@ Required properties:
                  w25x80
                  w25x32
                  w25q32
+                 w25q64
                  w25q32dw
                  w25q80bl
                  w25q128
-- 
2.10.0
