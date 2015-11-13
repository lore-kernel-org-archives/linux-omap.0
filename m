From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 01/39] pinctrl: Move am4372 and dra7 macros to the the SoC header files
Date: Fri, 13 Nov 2015 01:53:39 -0300
Message-ID: <1447390457-1158-2-git-send-email-javier@osg.samsung.com>
References: <1447390457-1158-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1447390457-1158-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@osg.samsung.com>, linux-gpio@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-omap@vger.kernel.org

The <dt-bindings/pinctrl/omap.h> header file defines a set of macros
for different SoCs families that falls under the OMAP sub-arch, that
allow to define the padconf register physical address instead of the
register offset from the padconf base.

But the am43xx and dra7xx SoCs families have their own pinctrl header
file so the DTS using these SoCs aren't able to use the AM4372_IOPAD()
and DRA7XX_CORE_IOPAD() macros since <dt-bindings/pinctrl/omap.h> is
not included.

Move the macros to the correct header files so can be used by the DTS.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

 include/dt-bindings/pinctrl/am43xx.h | 6 ++++++
 include/dt-bindings/pinctrl/dra.h    | 6 ++++++
 include/dt-bindings/pinctrl/omap.h   | 2 --
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/dt-bindings/pinctrl/am43xx.h b/include/dt-bindings/pinctrl/am43xx.h
index 774dc1e843c5..344bd1eb3386 100644
--- a/include/dt-bindings/pinctrl/am43xx.h
+++ b/include/dt-bindings/pinctrl/am43xx.h
@@ -31,5 +31,11 @@
 #define PIN_INPUT_PULLUP	(INPUT_EN | PULL_UP)
 #define PIN_INPUT_PULLDOWN	(INPUT_EN)
 
+/*
+ * Macro to allow using the absolute physical address instead of the
+ * padconf registers instead of the offset from padconf base.
+ */
+#define AM4372_IOPAD(pa, val)	(((pa) & 0xffff) - 0x0800) (val)
+
 #endif
 
diff --git a/include/dt-bindings/pinctrl/dra.h b/include/dt-bindings/pinctrl/dra.h
index 4379e29f0460..5c75e80915fc 100644
--- a/include/dt-bindings/pinctrl/dra.h
+++ b/include/dt-bindings/pinctrl/dra.h
@@ -67,5 +67,11 @@
 #define PIN_INPUT_PULLUP	(PULL_ENA | INPUT_EN | PULL_UP)
 #define PIN_INPUT_PULLDOWN	(PULL_ENA | INPUT_EN)
 
+/*
+ * Macro to allow using the absolute physical address instead of the
+ * padconf registers instead of the offset from padconf base.
+ */
+#define DRA7XX_CORE_IOPAD(pa, val)	(((pa) & 0xffff) - 0x3400) (val)
+
 #endif
 
diff --git a/include/dt-bindings/pinctrl/omap.h b/include/dt-bindings/pinctrl/omap.h
index 13949259705a..8100de13851c 100644
--- a/include/dt-bindings/pinctrl/omap.h
+++ b/include/dt-bindings/pinctrl/omap.h
@@ -63,8 +63,6 @@
 #define OMAP3_WKUP_IOPAD(pa, val)	OMAP_IOPAD_OFFSET((pa), 0x2a00) (val)
 #define DM816X_IOPAD(pa, val)		OMAP_IOPAD_OFFSET((pa), 0x0800) (val)
 #define AM33XX_IOPAD(pa, val)		OMAP_IOPAD_OFFSET((pa), 0x0800) (val)
-#define AM4372_IOPAD(pa, val)		OMAP_IOPAD_OFFSET((pa), 0x0800) (val)
-#define DRA7XX_CORE_IOPAD(pa, val)	OMAP_IOPAD_OFFSET((pa), 0x3400) (val)
 
 /*
  * Macros to allow using the offset from the padconf physical address
-- 
2.4.3
