From: Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH] dt-bindings: i2c: omap: Add new compatible for J721E SoCs
Date: Wed, 5 Jun 2019 14:15:04 +0530
Message-ID: <20190605084504.2777-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>, Rob Herring <robh+dt@kernel.org>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: Peter Ujfalusi <peter.ujfalusi@ti.com>

J721E SoCs have same I2C IP as OMAP SoCs. Add new compatible to
handle J721E SoCs.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---

Initial support for J721E Platform is proposed here:
https://lore.kernel.org/patchwork/cover/1077382/

 Documentation/devicetree/bindings/i2c/i2c-omap.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-omap.txt b/Documentation/devicetree/bindings/i2c/i2c-omap.txt
index 4b90ba9f31b7..a44573d7c118 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-omap.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-omap.txt
@@ -7,6 +7,7 @@ Required properties :
 	"ti,omap3-i2c" for OMAP3 SoCs
 	"ti,omap4-i2c" for OMAP4+ SoCs
 	"ti,am654-i2c", "ti,omap4-i2c" for AM654 SoCs
+	"ti,j721e-i2c", "ti,omap4-i2c" for J721E SoCs
 - ti,hwmods : Must be "i2c<n>", n being the instance number (1-based)
 - #address-cells = <1>;
 - #size-cells = <0>;
-- 
2.21.0
