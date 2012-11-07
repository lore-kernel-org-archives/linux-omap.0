From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH 2/6] ARM/dts: omap4-sdp: Add pinmux configuration for
 HDMI
Date: Wed, 7 Nov 2012 11:57:45 +0100
Message-ID: <509A3EA9.2040407@ti.com>
References: <1352121259-5836-1-git-send-email-tomi.valkeinen@ti.com> <1352121259-5836-3-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52824 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754545Ab2KGK55 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Nov 2012 05:57:57 -0500
In-Reply-To: <1352121259-5836-3-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: archit@ti.com, tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, s-guiriec@ti.com, Ricardo Neri <ricardo.neri@ti.com>

On 11/05/2012 02:14 PM, Tomi Valkeinen wrote:
> From: Ricardo Neri <ricardo.neri@ti.com>
> 
> Add the pinmux configuration for HDMI and TPD12S015A. Configure the
> gpios for the TPD12S015A and SDA, SCL and CEC for HDMI.
> 
> Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

I've just changed the subject, and applied it in the for_3.8/dts_part2 branch.

Please find below the updated version.

Regards,
Benoit 

---
>From 347bf48f2b5d2b45a4e42b89dd61b27ca8baced4 Mon Sep 17 00:00:00 2001
From: Ricardo Neri <ricardo.neri@ti.com>
Date: Mon, 5 Nov 2012 15:14:15 +0200
Subject: [PATCH 2/2] ARM: dts: omap4-sdp: Add pinmux configuration for HDMI

Add the pinmux configuration for HDMI and TPD12S015A. Configure the
gpios for the TPD12S015A and SDA, SCL and CEC for HDMI.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Benoit Cousson <b-cousson@ti.com>
---
 arch/arm/boot/dts/omap4-sdp-es23plus.dts |   17 +++++++++++++++++
 arch/arm/boot/dts/omap4-sdp.dts          |   18 ++++++++++++++++++
 2 files changed, 35 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap4-sdp-es23plus.dts

diff --git a/arch/arm/boot/dts/omap4-sdp-es23plus.dts b/arch/arm/boot/dts/omap4-sdp-es23plus.dts
new file mode 100644
index 0000000..b4a40ff
--- /dev/null
+++ b/arch/arm/boot/dts/omap4-sdp-es23plus.dts
@@ -0,0 +1,17 @@
+/*
+ * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+/include/ "omap4-sdp.dts"
+
+/* SDP boards with 4430 ES2.3+ or 4460 have external pullups on SCL & SDA */
+&dss_hdmi_pins {
+	pinctrl-single,pins = <
+		0x5a 0x118	/* hdmi_cec.hdmi_cec INPUT PULLUP | MODE 0 */
+		0x5c 0x100	/* hdmi_scl.hdmi_scl INPUT | MODE 0 */
+		0x5e 0x100	/* hdmi_sda.hdmi_sda INPUT | MODE 0 */
+		>;
+};
diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
index 0f57bdf..43e5258 100644
--- a/arch/arm/boot/dts/omap4-sdp.dts
+++ b/arch/arm/boot/dts/omap4-sdp.dts
@@ -124,6 +124,8 @@
 			&dmic_pins
 			&mcbsp1_pins
 			&mcbsp2_pins
+			&dss_hdmi_pins
+			&tpd12s015_pins
 	>;
 
 	uart2_pins: pinmux_uart2_pins {
@@ -194,6 +196,22 @@
 			0xbc 0x100	/* abe_mcbsp2_fsx.abe_mcbsp2_fsx INPUT | MODE0 */
 		>;
 	};
+
+	dss_hdmi_pins: pinmux_dss_hdmi_pins {
+		pinctrl-single,pins = <
+			0x5a 0x118	/* hdmi_cec.hdmi_cec INPUT PULLUP | MODE 0 */
+			0x5c 0x118	/* hdmi_scl.hdmi_scl INPUT PULLUP | MODE 0 */
+			0x5e 0x118	/* hdmi_sda.hdmi_sda INPUT PULLUP | MODE 0 */
+		>;
+	};
+
+	tpd12s015_pins: pinmux_tpd12s015_pins {
+		pinctrl-single,pins = <
+			0x22 0x3	/* gpmc_a17.gpio_41 OUTPUT | MODE3 */
+			0x48 0x3	/* gpmc_nbe1.gpio_60 OUTPUT | MODE3 */
+			0x58 0x10b	/* hdmi_hpd.gpio_63 INPUT PULLDOWN | MODE3 */
+		>;
+	};
 };
 
 &i2c1 {
-- 
1.7.0.4


