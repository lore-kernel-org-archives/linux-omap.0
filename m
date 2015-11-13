From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 31/39] ARM: dts: omap4-panda-a4: Use OMAP4_IOPAD pinmux macro
Date: Fri, 13 Nov 2015 01:54:09 -0300
Message-ID: <1447390457-1158-32-git-send-email-javier@osg.samsung.com>
References: <1447390457-1158-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1447390457-1158-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: linux-omap@vger.kernel.org

Use the pinmux IOPAD macros to define the register as an offset from
the padconf physical address instead of the offset from padconf base.
This makes the DTS easier to read since matches the addresses listed
in the Technical Reference Manual.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 arch/arm/boot/dts/omap4-panda-a4.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/omap4-panda-a4.dts b/arch/arm/boot/dts/omap4-panda-a4.dts
index 133f1b74e8ae..78d363177762 100644
--- a/arch/arm/boot/dts/omap4-panda-a4.dts
+++ b/arch/arm/boot/dts/omap4-panda-a4.dts
@@ -13,8 +13,8 @@
 /* Pandaboard Rev A4+ have external pullups on SCL & SDA */
 &dss_hdmi_pins {
 	pinctrl-single,pins = <
-		0x5a (PIN_INPUT_PULLUP | MUX_MODE0)	/* hdmi_cec.hdmi_cec */
-		0x5c (PIN_INPUT | MUX_MODE0)		/* hdmi_scl.hdmi_scl */
-		0x5e (PIN_INPUT | MUX_MODE0)		/* hdmi_sda.hdmi_sda */
+		OMAP4_IOPAD(0x09a, PIN_INPUT_PULLUP | MUX_MODE0)	/* hdmi_cec.hdmi_cec */
+		OMAP4_IOPAD(0x09c, PIN_INPUT | MUX_MODE0)		/* hdmi_scl.hdmi_scl */
+		OMAP4_IOPAD(0x09e, PIN_INPUT | MUX_MODE0)		/* hdmi_sda.hdmi_sda */
 		>;
 };
-- 
2.4.3
