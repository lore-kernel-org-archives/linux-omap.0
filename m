From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH v3 1/3] dt-bindings: i2c-omap: Add new compatible for AM654 SoCs
Date: Thu, 8 Nov 2018 14:49:29 +0530
Message-ID: <20181108091931.3342-2-vigneshr@ti.com>
References: <20181108091931.3342-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181108091931.3342-1-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Tony Lindgren <tony@atomide.com>
Cc: Vignesh R <vigneshr@ti.com>, Rob Herring <robh+dt@kernel.org>, Grygorii Strashko <grygorii.strashko@ti.com>, linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

AM654 SoCs have same I2C IP as OMAP SoCs. Add new compatible to
handle AM654 SoCs. While at that reformat the existing compatible list
for older SoCs to list one valid compatible per line.

Signed-off-by: Vignesh R <vigneshr@ti.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 Documentation/devicetree/bindings/i2c/i2c-omap.txt | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-omap.txt b/Documentation/devicetree/bindings/i2c/i2c-omap.txt
index 7e49839d4124..4b90ba9f31b7 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-omap.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-omap.txt
@@ -1,8 +1,12 @@
 I2C for OMAP platforms
 
 Required properties :
-- compatible : Must be "ti,omap2420-i2c", "ti,omap2430-i2c", "ti,omap3-i2c"
-  or "ti,omap4-i2c"
+- compatible : Must be
+	"ti,omap2420-i2c" for OMAP2420 SoCs
+	"ti,omap2430-i2c" for OMAP2430 SoCs
+	"ti,omap3-i2c" for OMAP3 SoCs
+	"ti,omap4-i2c" for OMAP4+ SoCs
+	"ti,am654-i2c", "ti,omap4-i2c" for AM654 SoCs
 - ti,hwmods : Must be "i2c<n>", n being the instance number (1-based)
 - #address-cells = <1>;
 - #size-cells = <0>;
-- 
2.19.1
