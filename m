From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/7] ARM: dts: Add pinctrl macros for dm814x
Date: Thu,  3 Dec 2015 17:25:29 -0800
Message-ID: <1449192335-10137-2-git-send-email-tony@atomide.com>
References: <1449192335-10137-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1449192335-10137-1-git-send-email-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Matthijs van Duin <matthijsvanduin@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Neil Armstrong <narmstrong@baylibre.com>, Philipp Rosenberger <ilu@linutronix.de>, Delio Brignoli <dbrignoli@audioscience.com>, Brian Hutchinson <b.hutchman@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Let's add the DM814X_IOPAD macro the same way as we have for dm816x and
am33xx as this allows comparing the registers with the documentation easily.
The pinctrl bits are yet again different on dm814x.

Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/dm814x.dtsi        |  2 +-
 include/dt-bindings/pinctrl/dm814x.h | 48 ++++++++++++++++++++++++++++++++++++
 include/dt-bindings/pinctrl/omap.h   |  1 +
 3 files changed, 50 insertions(+), 1 deletion(-)
 create mode 100644 include/dt-bindings/pinctrl/dm814x.h

diff --git a/arch/arm/boot/dts/dm814x.dtsi b/arch/arm/boot/dts/dm814x.dtsi
index 09a8d88..ca92346 100644
--- a/arch/arm/boot/dts/dm814x.dtsi
+++ b/arch/arm/boot/dts/dm814x.dtsi
@@ -5,7 +5,7 @@
  */
 
 #include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/pinctrl/omap.h>
+#include <dt-bindings/pinctrl/dm814x.h>
 
 #include "skeleton.dtsi"
 
diff --git a/include/dt-bindings/pinctrl/dm814x.h b/include/dt-bindings/pinctrl/dm814x.h
new file mode 100644
index 0000000..0f48427
--- /dev/null
+++ b/include/dt-bindings/pinctrl/dm814x.h
@@ -0,0 +1,48 @@
+/*
+ * This header provides constants specific to DM814X pinctrl bindings.
+ */
+
+#ifndef _DT_BINDINGS_PINCTRL_DM814X_H
+#define _DT_BINDINGS_PINCTRL_DM814X_H
+
+#include <dt-bindings/pinctrl/omap.h>
+
+#undef INPUT_EN
+#undef PULL_UP
+#undef PULL_ENA
+
+/*
+ * Note that dm814x silicon revision 2.1 and older require input enabled
+ * (bit 18 set) for all 3.3V I/Os to avoid cumulative hardware damage. For
+ * more info, see errata advisory 2.1.87. We leave bit 18 out of
+ * function-mask in dm814x.h and rely on the bootloader for it.
+ */
+#define INPUT_EN		(1 << 18)
+#define PULL_UP			(1 << 17)
+#define PULL_DISABLE		(1 << 16)
+
+/* update macro depending on INPUT_EN and PULL_ENA */
+#undef PIN_OUTPUT
+#undef PIN_OUTPUT_PULLUP
+#undef PIN_OUTPUT_PULLDOWN
+#undef PIN_INPUT
+#undef PIN_INPUT_PULLUP
+#undef PIN_INPUT_PULLDOWN
+
+#define PIN_OUTPUT		(PULL_DISABLE)
+#define PIN_OUTPUT_PULLUP	(PULL_UP)
+#define PIN_OUTPUT_PULLDOWN	0
+#define PIN_INPUT		(INPUT_EN | PULL_DISABLE)
+#define PIN_INPUT_PULLUP	(INPUT_EN | PULL_UP)
+#define PIN_INPUT_PULLDOWN	(INPUT_EN)
+
+/* undef non-existing modes */
+#undef PIN_OFF_NONE
+#undef PIN_OFF_OUTPUT_HIGH
+#undef PIN_OFF_OUTPUT_LOW
+#undef PIN_OFF_INPUT_PULLUP
+#undef PIN_OFF_INPUT_PULLDOWN
+#undef PIN_OFF_WAKEUPENABLE
+
+#endif
+
diff --git a/include/dt-bindings/pinctrl/omap.h b/include/dt-bindings/pinctrl/omap.h
index 1394925..d1e1512 100644
--- a/include/dt-bindings/pinctrl/omap.h
+++ b/include/dt-bindings/pinctrl/omap.h
@@ -61,6 +61,7 @@
 #define OMAP3430_CORE2_IOPAD(pa, val)	OMAP_IOPAD_OFFSET((pa), 0x25d8) (val)
 #define OMAP3630_CORE2_IOPAD(pa, val)	OMAP_IOPAD_OFFSET((pa), 0x25a0) (val)
 #define OMAP3_WKUP_IOPAD(pa, val)	OMAP_IOPAD_OFFSET((pa), 0x2a00) (val)
+#define DM814X_IOPAD(pa, val)		OMAP_IOPAD_OFFSET((pa), 0x0800) (val)
 #define DM816X_IOPAD(pa, val)		OMAP_IOPAD_OFFSET((pa), 0x0800) (val)
 #define AM33XX_IOPAD(pa, val)		OMAP_IOPAD_OFFSET((pa), 0x0800) (val)
 #define AM4372_IOPAD(pa, val)		OMAP_IOPAD_OFFSET((pa), 0x0800) (val)
-- 
2.6.2
