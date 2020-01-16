From: Sasha Levin <sashal-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH AUTOSEL 4.19 535/671] ARM: dts: logicpd-som-lv: Fix i2c2 and i2c3 Pin mux
Date: Thu, 16 Jan 2020 12:02:53 -0500
Message-ID: <20200116170509.12787-272-sashal@kernel.org>
References: <20200116170509.12787-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200116170509.12787-1-sashal-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Adam Ford <aford173-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Sasha Levin <sashal-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

From: Adam Ford <aford173-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

[ Upstream commit a932b77b4d1939ad173f18be87da409427fb705c ]

When the pinmux configuration was added, it was accidentally placed into
the omap3_pmx_wkup node  when it should have been placed into the
omap3_pmx_core.  This error was accidentally propagated to stable by
me when I blindly requested the pull after seeing I2C issues without
actually reviewing the content of the pinout.  Since the bootloader
previously muxed these correctly in the past, was a hidden error.

This patch moves the i2c2_pins and i2c3_pins to the correct node
which should eliminate i2c bus errors and timeouts due to the fact
the bootloader uses the save device tree that no longer properly
assigns these pins.

Fixes: 5fe3c0fa0d54 ("ARM: dts: Add pinmuxing for i2c2 and i2c3
for LogicPD SOM-LV") #4.9+

Signed-off-by: Adam Ford <aford173-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Sasha Levin <sashal-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 arch/arm/boot/dts/logicpd-som-lv.dtsi | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/logicpd-som-lv.dtsi b/arch/arm/boot/dts/logicpd-som-lv.dtsi
index 98b682a8080c..c5d54c4d3747 100644
--- a/arch/arm/boot/dts/logicpd-som-lv.dtsi
+++ b/arch/arm/boot/dts/logicpd-som-lv.dtsi
@@ -232,6 +232,20 @@
 		>;
 	};
 
+	i2c2_pins: pinmux_i2c2_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x21be, PIN_INPUT | MUX_MODE0)	/* i2c2_scl */
+			OMAP3_CORE1_IOPAD(0x21c0, PIN_INPUT | MUX_MODE0)	/* i2c2_sda */
+		>;
+	};
+
+	i2c3_pins: pinmux_i2c3_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x21c2, PIN_INPUT | MUX_MODE0)	/* i2c3_scl */
+			OMAP3_CORE1_IOPAD(0x21c4, PIN_INPUT | MUX_MODE0)	/* i2c3_sda */
+		>;
+	};
+
 	tsc2004_pins: pinmux_tsc2004_pins {
 		pinctrl-single,pins = <
 			OMAP3_CORE1_IOPAD(0x2186, PIN_INPUT | MUX_MODE4)	/* mcbsp4_dr.gpio_153 */
@@ -253,18 +267,6 @@
 			OMAP3_WKUP_IOPAD(0x2a0c, PIN_OUTPUT | MUX_MODE4)	/* sys_boot1.gpio_3 */
 		>;
 	};
-	i2c2_pins: pinmux_i2c2_pins {
-		pinctrl-single,pins = <
-			OMAP3_CORE1_IOPAD(0x21be, PIN_INPUT | MUX_MODE0)	/* i2c2_scl */
-			OMAP3_CORE1_IOPAD(0x21c0, PIN_INPUT | MUX_MODE0)	/* i2c2_sda */
-		>;
-	};
-	i2c3_pins: pinmux_i2c3_pins {
-		pinctrl-single,pins = <
-			OMAP3_CORE1_IOPAD(0x21c2, PIN_INPUT | MUX_MODE0)	/* i2c3_scl */
-			OMAP3_CORE1_IOPAD(0x21c4, PIN_INPUT | MUX_MODE0)	/* i2c3_sda */
-		>;
-	};
 };
 
 &omap3_pmx_core2 {
-- 
2.20.1
