From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 19/81] ARM: dts: omap3-gta04: Fix graph_port warning
Date: Thu, 28 Feb 2019 10:07:11 -0500
Message-ID: <20190228150813.10256-19-sashal@kernel.org>
References: <20190228150813.10256-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190228150813.10256-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, "H . Nikolaus Schaller" <hns@goldelico.com>, Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit 5b90df44fd9b415d8c5d11b92746212a63d3c47f ]

We're currently getting a warning with make dtbs:

arch/arm/boot/dts/omap3-gta04.dtsi:720.7-727.4: Warning (graph_port):
/ocp@68000000/dss@48050000/encoder@48050c0 0/port: graph node unit
address error, expected "0"

Tested-by: H. Nikolaus Schaller <hns@goldelico.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index d5fe55392230d..68e6752589065 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -714,11 +714,7 @@
 
 	vdda-supply = <&vdac>;
 
-	#address-cells = <1>;
-	#size-cells = <0>;
-
 	port {
-		reg = <0>;
 		venc_out: endpoint {
 			remote-endpoint = <&opa_in>;
 			ti,channels = <1>;
-- 
2.19.1
