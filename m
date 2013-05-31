From: Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>
Subject: [PATCH v4 4/5] ARM: dts: OMAP2+: Header file for pinctrl constants
Date: Fri, 31 May 2013 14:32:58 +0200
Message-ID: <1370003579-30219-5-git-send-email-florian.vaussard@epfl.ch>
References: <1370003579-30219-1-git-send-email-florian.vaussard@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1370003579-30219-1-git-send-email-florian.vaussard-p8DiymsW2f8@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Most of the constants are taken from arch/arm/mach-omap2/mux.h.
Define some others for the PIN_OUTPUT_* flavours.

Signed-off-by: Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>
Acked-by: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
Reviewed-by: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 include/dt-bindings/pinctrl/omap.h |   50 ++++++++++++++++++++++++++++++++++++
 1 files changed, 50 insertions(+), 0 deletions(-)
 create mode 100644 include/dt-bindings/pinctrl/omap.h

diff --git a/include/dt-bindings/pinctrl/omap.h b/include/dt-bindings/pinctrl/omap.h
new file mode 100644
index 0000000..370df3f
--- /dev/null
+++ b/include/dt-bindings/pinctrl/omap.h
@@ -0,0 +1,50 @@
+/*
+ * This header provides constants for OMAP pinctrl bindings.
+ *
+ * Copyright (C) 2009 Nokia
+ * Copyright (C) 2009-2010 Texas Instruments
+ */
+
+/* 34xx mux mode options for each pin. See TRM for options */
+#define MUX_MODE0	0
+#define MUX_MODE1	1
+#define MUX_MODE2	2
+#define MUX_MODE3	3
+#define MUX_MODE4	4
+#define MUX_MODE5	5
+#define MUX_MODE6	6
+#define MUX_MODE7	7
+
+/* 24xx/34xx mux bit defines */
+#define PULL_ENA		(1 << 3)
+#define PULL_UP			(1 << 4)
+#define ALTELECTRICALSEL	(1 << 5)
+
+/* 34xx specific mux bit defines */
+#define INPUT_EN		(1 << 8)
+#define OFF_EN			(1 << 9)
+#define OFFOUT_EN		(1 << 10)
+#define OFFOUT_VAL		(1 << 11)
+#define OFF_PULL_EN		(1 << 12)
+#define OFF_PULL_UP		(1 << 13)
+#define WAKEUP_EN		(1 << 14)
+
+/* 44xx specific mux bit defines */
+#define WAKEUP_EVENT		(1 << 15)
+
+/* Active pin states */
+#define PIN_OUTPUT		0
+#define PIN_OUTPUT_PULLUP	(PIN_OUTPUT | PULL_ENA | PULL_UP)
+#define PIN_OUTPUT_PULLDOWN	(PIN_OUTPUT | PULL_ENA)
+#define PIN_INPUT		INPUT_EN
+#define PIN_INPUT_PULLUP	(PULL_ENA | INPUT_EN | PULL_UP)
+#define PIN_INPUT_PULLDOWN	(PULL_ENA | INPUT_EN)
+
+/* Off mode states */
+#define PIN_OFF_NONE		0
+#define PIN_OFF_OUTPUT_HIGH	(OFF_EN | OFFOUT_EN | OFFOUT_VAL)
+#define PIN_OFF_OUTPUT_LOW	(OFF_EN | OFFOUT_EN)
+#define PIN_OFF_INPUT_PULLUP	(OFF_EN | OFF_PULL_EN | OFF_PULL_UP)
+#define PIN_OFF_INPUT_PULLDOWN	(OFF_EN | OFF_PULL_EN)
+#define PIN_OFF_WAKEUPENABLE	WAKEUP_EN
+
-- 
1.7.5.4
