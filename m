From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 106/205] ARM: dts: omap3-gta04: give spi_lcd node a label so that we can overwrite in other DTS files
Date: Fri,  8 Nov 2019 06:36:13 -0500
Message-ID: <20191108113752.12502-106-sashal@kernel.org>
References: <20191108113752.12502-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191108113752.12502-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: "H. Nikolaus Schaller" <hns@goldelico.com>, Tony Lindgren <tony@atomide.com>, Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: "H. Nikolaus Schaller" <hns@goldelico.com>

[ Upstream commit fa0d7dc355c890725b6178dab0cc11b194203afa ]

needed for device variants based on GTA04 board but with
different display panel (driver).

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index ac830b9177763..ae33e0e0f1d2c 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -78,7 +78,7 @@
 		#sound-dai-cells = <0>;
 	};
 
-	spi_lcd {
+	spi_lcd: spi_lcd {
 		compatible = "spi-gpio";
 		#address-cells = <0x1>;
 		#size-cells = <0x0>;
-- 
2.20.1
