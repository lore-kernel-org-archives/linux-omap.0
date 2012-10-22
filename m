From: Sourav Poddar <sourav.poddar@ti.com>
Subject: [PATCHv2] arm: dts: omap4-sdp: pinmux configuration for keypad
Date: Mon, 22 Oct 2012 18:43:21 +0530
Message-ID: <1350911601-20337-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, b-cousson@ti.com
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Sourav Poddar <sourav.poddar@ti.com>, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

Currently, omap4 keypad mux settings are done in the board file.
Populate the mux settings in the dts file for the keypad to
work via dt.

Tested on omap4430 sdp with 3.7-rc1.

Cc: Felipe Balbi <balbi@ti.com>
Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
---
v1->v2
change the hex letter to lower case.
 arch/arm/boot/dts/omap4-sdp.dts |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
index 5b7e04f..27d16a8 100644
--- a/arch/arm/boot/dts/omap4-sdp.dts
+++ b/arch/arm/boot/dts/omap4-sdp.dts
@@ -194,6 +194,27 @@
 			0xbc 0x100	/* abe_mcbsp2_fsx.abe_mcbsp2_fsx INPUT | MODE0 */
 		>;
 	};
+
+	keypad_pins: pinmux_keypad_pins {
+		pinctrl-single,pins = <
+			0x24 0x4119   /* gpmc_a18.kpd_row6 OMAP_PULL_ENA | OMAP_PULL_UP | OMAP_WAKEUP_EN | OMAP_MUX_MODE1 | OMAP_INPUT_EN */
+			0x26 0x4119   /* gpmc_a19.kpd_row6 OMAP_PULL_ENA | OMAP_PULL_UP | OMAP_WAKEUP_EN | OMAP_MUX_MODE1 | OMAP_INPUT_EN */
+			0x2c 0x4001   /* gpmc_a22.kpd_col6 OMAP_WAKEUP_EN | OMAP_MUX_MODE1 */
+			0x2e 0x4001   /* gpmc_a23.kpd_col7 OMAP_WAKEUP_EN | OMAP_MUX_MODE1 */
+			0x13c 0x4001  /* kpd_col0.kpd_col0 OMAP_WAKEUP_EN | OMAP_MUX_MODE1 */
+			0x13e 0x4001  /* kpd_col1.kpd_col1 OMAP_WAKEUP_EN | OMAP_MUX_MODE1 */
+			0x140 0x4001  /* kpd_col2.kpd_col2 OMAP_WAKEUP_EN | OMAP_MUX_MODE1 */
+			0x142 0x10f   /* kpd_col3.kpd_col3 OMAP_WAKEUP_EN | OMAP_MUX_MODE1 */
+			0x144 0x4001  /* kpd_col4.kpd_col4 OMAP_WAKEUP_EN | OMAP_MUX_MODE1 */
+			0x146 0x4001  /* kpd_col5.kpd_col5 OMAP_WAKEUP_EN | OMAP_MUX_MODE1 */
+			0x148 0xc119  /* kpd_row0.kpd_row0 OMAP_PULL_ENA | OMAP_PULL_UP | OMAP_WAKEUP_EN | OMAP_MUX_MODE1 | OMAP_INPUT_EN */
+			0x14a 0x4119  /* kpd_row1.kpd_row1 OMAP_PULL_ENA | OMAP_PULL_UP | OMAP_WAKEUP_EN | OMAP_MUX_MODE1 | OMAP_INPUT_EN */
+			0x14c 0x4119  /* kpd_row2.kpd_row2 OMAP_PULL_ENA | OMAP_PULL_UP | OMAP_WAKEUP_EN | OMAP_MUX_MODE1 | OMAP_INPUT_EN */
+			0x14e 0x4119  /* kpd_row3.kpd_row3 OMAP_PULL_ENA | OMAP_PULL_UP | OMAP_WAKEUP_EN | OMAP_MUX_MODE1 | OMAP_INPUT_EN */
+			0x150 0x4119  /* kpd_row4.kpd_row4 OMAP_PULL_ENA | OMAP_PULL_UP | OMAP_WAKEUP_EN | OMAP_MUX_MODE1 | OMAP_INPUT_EN */
+			0x152 0x4119  /* kpd_row5.kpd_row5 OMAP_PULL_ENA | OMAP_PULL_UP | OMAP_WAKEUP_EN | OMAP_MUX_MODE1 | OMAP_INPUT_EN */
+		>;
+	};
 };
 
 &i2c1 {
@@ -406,3 +427,8 @@
 &mcbsp3 {
 	status = "disabled";
 };
+
+&keypad {
+        pinctrl-names = "default";
+        pinctrl-0 = <&keypad_pins>;
+};
-- 
1.7.1
