From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH v2 1/4] pwm: Add PWM polarity flag macro for DT
Date: Thu, 18 Jul 2013 00:54:21 +0200
Message-ID: <1374101664-21112-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1374101664-21112-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:36058 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757814Ab3GQWxo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Jul 2013 18:53:44 -0400
In-Reply-To: <1374101664-21112-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Boris BREZILLON <linux-arm@overkiz.com>, Shawn Guo <shawn.guo@linaro.org>, Steffen Trumtrar <s.trumtrar@pengutronix.de>, Stephen Warren <swarren@wwwdotorg.org>, Tomasz Figa <t.figa@samsung.com>

Define a PWM_POLARITY_INVERTED macro in include/dt-bindings/pwm/pwm.h to
be used by device tree sources.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 Documentation/devicetree/bindings/pwm/pwm.txt |  7 ++++---
 include/dt-bindings/pwm/pwm.h                 | 14 ++++++++++++++
 2 files changed, 18 insertions(+), 3 deletions(-)
 create mode 100644 include/dt-bindings/pwm/pwm.h

diff --git a/Documentation/devicetree/bindings/pwm/pwm.txt b/Documentation/devicetree/bindings/pwm/pwm.txt
index 06e6724..8556263 100644
--- a/Documentation/devicetree/bindings/pwm/pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/pwm.txt
@@ -43,13 +43,14 @@ because the name "backlight" would be used as fallback anyway.
 pwm-specifier typically encodes the chip-relative PWM number and the PWM
 period in nanoseconds.
 
-Optionally, the pwm-specifier can encode a number of flags in a third cell:
-- bit 0: PWM signal polarity (0: normal polarity, 1: inverse polarity)
+Optionally, the pwm-specifier can encode a number of flags (defined in
+<dt-bindings/pwm/pwm.h>) in a third cell:
+- PWM_POLARITY_INVERTED: invert the PWM signal polarity
 
 Example with optional PWM specifier for inverse polarity
 
 	bl: backlight {
-		pwms = <&pwm 0 5000000 1>;
+		pwms = <&pwm 0 5000000 PWM_POLARITY_INVERTED>;
 		pwm-names = "backlight";
 	};
 
diff --git a/include/dt-bindings/pwm/pwm.h b/include/dt-bindings/pwm/pwm.h
new file mode 100644
index 0000000..96f49e8
--- /dev/null
+++ b/include/dt-bindings/pwm/pwm.h
@@ -0,0 +1,14 @@
+/*
+ * This header provides constants for most PWM bindings.
+ *
+ * Most PWM bindings can include a flags cell as part of the PWM specifier.
+ * In most cases, the format of the flags cell uses the standard values
+ * defined in this header.
+ */
+
+#ifndef _DT_BINDINGS_PWM_PWM_H
+#define _DT_BINDINGS_PWM_PWM_H
+
+#define PWM_POLARITY_INVERTED			(1 << 0)
+
+#endif
-- 
1.8.1.5

