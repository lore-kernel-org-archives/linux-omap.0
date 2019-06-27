From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.1 21/95] ARM: dts: Drop bogus CLKSEL for timer12 on dra7
Date: Wed, 26 Jun 2019 20:29:06 -0400
Message-ID: <20190627003021.19867-21-sashal@kernel.org>
References: <20190627003021.19867-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190627003021.19867-1-sashal@kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Tero Kristo <t-kristo@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit 34f61de87017aff3c8306280d196dddb1e168a88 ]

There is no CLKSEL for timer12 on dra7 unlike for timer1. This
causes issues on booting the device that Tomi noticed if
DEBUG_SLAB is enabled and the clkctrl clock does not properly
handle non-existing clock. Let's drop the bogus CLKSEL clock,
the clkctrl clock handling gets fixed separately.

Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Reported-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Tested-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Tested-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Fixes: 4ed0dfe3cf39 ("ARM: dts: dra7: Move l4 child devices to probe them with ti-sysc")
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/dra7-l4.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/dra7-l4.dtsi b/arch/arm/boot/dts/dra7-l4.dtsi
index 73f5c050f586..17f0d8e93622 100644
--- a/arch/arm/boot/dts/dra7-l4.dtsi
+++ b/arch/arm/boot/dts/dra7-l4.dtsi
@@ -4450,8 +4450,6 @@
 			timer12: timer@0 {
 				compatible = "ti,omap5430-timer";
 				reg = <0x0 0x80>;
-				clocks = <&wkupaon_clkctrl DRA7_WKUPAON_TIMER12_CLKCTRL 24>;
-				clock-names = "fck";
 				interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
 				ti,timer-alwon;
 				ti,timer-secure;
-- 
2.20.1
