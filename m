From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v2 1/2] ARM: dts: Add omap specific pinctrl defines to use padconf addresses
Date: Fri, 20 Dec 2013 16:51:16 +0100
Message-ID: <1387554677-21100-2-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1387554677-21100-1-git-send-email-laurent.pinchart@ideasonboard.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:53454 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752826Ab3LTPu7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Dec 2013 10:50:59 -0500
In-Reply-To: <1387554677-21100-1-git-send-email-laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>, Sebastian Reichel <sre@debian.org>, Sakari Ailus <sakari.ailus@iki.fi>

From: Tony Lindgren <tony@atomide.com>

As we have one to three pinctrl-single instances for each SoC it is
a bit confusing to configure the padconf register offset from the
base of the padconf register base.

Let's add macros that allow using the physical address of the
padconf register directly, or in most cases, just the last 16-bits
of the address as they are shown in the documentation.

Note that most documentation shows two padconf registers for each
32-bit address, so adding 2 to the documentation address is needed for
the second padconf register as we treat them as 16-bit registers
for omap3+.

For example, omap36xx documentation shows sdmmc2_clk at 0x48002158,
so we can just use the last 16-bits of that value:

	pinctrl-single,pins = <
		OMAP3_CORE1_IOPAD(0x2158, PIN_INPUT_PULLUP | MUX_MODE0)
		...
	>;

And we don't need to separately calculate the offset from the 0x2030
base:

	pinctrl-single,pins = <
		0x128 (PIN_INPUT_PULLUP | MUX_MODE0)
		...
	>;

Naturally both ways of defining the registers can be used, and I'm
not saying we should replace all the existing defines. But it may
be handy to use these macros for new entries and when doing other
related .dts file clean-up.

Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 include/dt-bindings/pinctrl/omap.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/dt-bindings/pinctrl/omap.h b/include/dt-bindings/pinctrl/omap.h
index bed35e3..f8484ee 100644
--- a/include/dt-bindings/pinctrl/omap.h
+++ b/include/dt-bindings/pinctrl/omap.h
@@ -49,5 +49,24 @@
 #define PIN_OFF_INPUT_PULLDOWN	(OFF_EN | OFF_PULL_EN)
 #define PIN_OFF_WAKEUPENABLE	WAKEUP_EN
 
+/*
+ * Macros to allow using the absolute physical address instead of the
+ * padconf registers instead of the offset from padconf base.
+ */
+#define OMAP_IOPAD_OFFSET(pa, offset)	(((pa) & 0xffff) - (offset))
+
+#define OMAP2420_CORE_IOPAD(pa, val)	OMAP_IOPAD_OFFSET((pa), 0x0030) (val)
+#define OMAP2430_CORE_IOPAD(pa, val)	OMAP_IOPAD_OFFSET((pa), 0x2030) (val)
+#define OMAP3_CORE1_IOPAD(pa, val)	OMAP_IOPAD_OFFSET((pa), 0x2030) (val)
+#define OMAP3_CORE2_IOPAD(pa, val)	OMAP_IOPAD_OFFSET((pa), 0x25a0) (val)
+#define OMAP3_WKUP_IOPAD(pa, val)	OMAP_IOPAD_OFFSET((pa), 0x2a00) (val)
+#define AM33XX_IOPAD(pa, val)		OMAP_IOPAD_OFFSET((pa), 0x0800) (val)
+#define OMAP4_CORE_IOPAD(pa, val)	OMAP_IOPAD_OFFSET((pa), 0x0040) (val)
+#define OMAP4_WKUP_IOPAD(pa, val)	OMAP_IOPAD_OFFSET((pa), 0xe040) (val)
+#define AM4372_IOPAD(pa, val)		OMAP_IOPAD_OFFSET((pa), 0x0800) (val)
+#define OMAP5_CORE_IOPAD(pa, val)	OMAP_IOPAD_OFFSET((pa), 0x2840) (val)
+#define OMAP5_WKUP_IOPAD(pa, val)	OMAP_IOPAD_OFFSET((pa), 0xc840) (val)
+#define DRA7XX_CORE_IOPAD(pa, val)	OMAP_IOPAD_OFFSET((pa), 0x3400) (val)
+
 #endif
 
-- 
1.8.3.2

