From: "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 01/11] ARM: dts: am43xx: Introduce additional pinmux definitions for DS0
Date: Fri, 29 Sep 2017 11:44:19 -0500
Message-ID: <20170929164429.780-2-afd@ti.com>
References: <20170929164429.780-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170929164429.780-1-afd-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Andrew F . Davis" <afd-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

AM43xx platform pinmux registers contain bits to set state during
suspend (DS0), add these bit definitions here.

Signed-off-by: Andrew F. Davis <afd-l0cyMroinI0@public.gmane.org>
---
 include/dt-bindings/pinctrl/am43xx.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/dt-bindings/pinctrl/am43xx.h b/include/dt-bindings/pinctrl/am43xx.h
index 344bd1eb3386..fc31ef7ce219 100644
--- a/include/dt-bindings/pinctrl/am43xx.h
+++ b/include/dt-bindings/pinctrl/am43xx.h
@@ -21,9 +21,21 @@
 #define INPUT_EN		(1 << 18)
 #define SLEWCTRL_SLOW		(1 << 19)
 #define SLEWCTRL_FAST		0
+#define DS0_FORCE_OFF_MODE	(1 << 24)
+#define DS0_INPUT		(1 << 25)
+#define DS0_FORCE_OUT_HIGH	(1 << 26)
 #define DS0_PULL_UP_DOWN_EN	(1 << 27)
+#define DS0_PULL_UP_SEL		(1 << 28)
 #define WAKEUP_ENABLE		(1 << 29)
 
+#define DS0_PIN_OUTPUT		(DS0_FORCE_OFF_MODE)
+#define DS0_PIN_OUTPUT_HIGH	(DS0_FORCE_OFF_MODE | DS0_FORCE_OUT_HIGH)
+#define DS0_PIN_OUTPUT_PULLUP	(DS0_FORCE_OFF_MODE | DS0_PULL_UP_DOWN_EN | DS0_PULL_UP_SEL)
+#define DS0_PIN_OUTPUT_PULLDOWN	(DS0_FORCE_OFF_MODE | DS0_PULL_UP_DOWN_EN)
+#define DS0_PIN_INPUT		(DS0_FORCE_OFF_MODE | DS0_INPUT)
+#define DS0_PIN_INPUT_PULLUP	(DS0_FORCE_OFF_MODE | DS0_INPUT | DS0_PULL_UP_DOWN_EN | DS0_PULL_UP_SEL)
+#define DS0_PIN_INPUT_PULLDOWN	(DS0_FORCE_OFF_MODE | DS0_INPUT | DS0_PULL_UP_DOWN_EN)
+
 #define PIN_OUTPUT		(PULL_DISABLE)
 #define PIN_OUTPUT_PULLUP	(PULL_UP)
 #define PIN_OUTPUT_PULLDOWN	0
-- 
2.14.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
