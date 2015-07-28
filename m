From: Vignesh R <vigneshr@ti.com>
Subject: [RFC PATCH 4/5] ARM: dts: DRA7: Add memory map region entries for qspi
Date: Tue, 28 Jul 2015 14:11:15 +0530
Message-ID: <1438072876-16338-5-git-send-email-vigneshr@ti.com>
References: <1438072876-16338-1-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438072876-16338-1-git-send-email-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>
Cc: Huang Shijie <b32955@freescale.com>, Vignesh R <vigneshr@ti.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Add qspi memory mapped region entries for DRA7xx based SoCs.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index ade28c790f4b..5317a0f24ab9 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -902,7 +902,9 @@
 
 		qspi: qspi@47900000 {
 			compatible = "ti,am4372-qspi";
-			reg = <0x47900000 0x100>;
+			reg = <0x47900000 0x100>,
+			      <0x30000000 0x3ffffff>;
+			reg-names = "qspi_base", "qspi_mmap";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "qspi";
-- 
2.4.6
