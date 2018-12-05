From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 011/123] ARM: dts: am3517-som: Fix WL127x Wifi interrupt
Date: Wed,  5 Dec 2018 04:34:03 -0500
Message-ID: <20181205093555.5386-11-sashal@kernel.org>
References: <20181205093555.5386-1-sashal@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181205093555.5386-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Adam Ford <aford173@gmail.com>, Tony Lindgren <tony@atomide.com>, Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Adam Ford <aford173@gmail.com>

[ Upstream commit 419b194cdedc76d0d3cd5b0900db0fa8177c4a52 ]

At the same time the AM3517 EVM was gaining WiFi support,
separate patches were introduced to move the interrupt
from HIGH to RISING.  Because they overlapped, this was not
done to the AM3517-EVM.  This patch fixes Kernel 4.19+

Fixes: 6bf5e3410f19 ("ARM: dts: am3517-som: Add WL127x Wifi")

Signed-off-by: Adam Ford <aford173@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/am3517-som.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am3517-som.dtsi b/arch/arm/boot/dts/am3517-som.dtsi
index dae6e458e59f..b1c988eed87c 100644
--- a/arch/arm/boot/dts/am3517-som.dtsi
+++ b/arch/arm/boot/dts/am3517-som.dtsi
@@ -163,7 +163,7 @@
 		compatible = "ti,wl1271";
 		reg = <2>;
 		interrupt-parent = <&gpio6>;
-		interrupts = <10 IRQ_TYPE_LEVEL_HIGH>; /* gpio_170 */
+		interrupts = <10 IRQ_TYPE_EDGE_RISING>; /* gpio_170 */
 		ref-clock-frequency = <26000000>;
 		tcxo-clock-frequency = <26000000>;
 	};
-- 
2.17.1
