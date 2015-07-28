From: Vignesh R <vigneshr@ti.com>
Subject: [RFC PATCH 5/5] ARM: dts: AM4372: Add memory map region entries for qspi
Date: Tue, 28 Jul 2015 14:11:16 +0530
Message-ID: <1438072876-16338-6-git-send-email-vigneshr@ti.com>
References: <1438072876-16338-1-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438072876-16338-1-git-send-email-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>
Cc: Huang Shijie <b32955@freescale.com>, Vignesh R <vigneshr@ti.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Add qspi memory mapped region entries for AM43xx based SoCs.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 8f1e25bcecbd..75a17c78b0ad 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -1103,8 +1103,10 @@
 
 		qspi: qspi@4b300000 {
 			compatible = "ti,dra7xxx-qspi";
-			reg = <0x4b300000 0x100>;
-			reg-names = "qspi_base";
+			reg = <0x4b300000 0x100>, <0x4a002558 0x4>,
+			      <0x5c000000 0x3ffffff>;
+			reg-names = "qspi_base", "qspi_ctrlmod",
+				    "qspi_mmap";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "qspi";
-- 
2.4.6
