From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: [PATCH v2 3/4] ARM: dts: AM33XX: Specific pinctrl header
Date: Mon,  3 Jun 2013 16:12:24 +0200
Message-ID: <1370268745-15860-4-git-send-email-florian.vaussard@epfl.ch>
References: <1370268745-15860-1-git-send-email-florian.vaussard@epfl.ch>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp5.epfl.ch ([128.178.224.8]:58779 "HELO smtp5.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755723Ab3FCOMq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 3 Jun 2013 10:12:46 -0400
In-Reply-To: <1370268745-15860-1-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Vaibhav Hiremath <hvaibhav@ti.com>, Joel A Fernandes <agnel.joel@gmail.com>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Florian Vaussard <florian.vaussard@epfl.ch>

The pinctrl IP inside the AM33XX family differs slightly from
what is found on OMAP2+. Define a specific header to take account
of the differences.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
---
 include/dt-bindings/pinctrl/am33xx.h |   37 ++++++++++++++++++++++++++++++++++
 1 files changed, 37 insertions(+), 0 deletions(-)
 create mode 100644 include/dt-bindings/pinctrl/am33xx.h

diff --git a/include/dt-bindings/pinctrl/am33xx.h b/include/dt-bindings/pinctrl/am33xx.h
new file mode 100644
index 0000000..a3fddd4
--- /dev/null
+++ b/include/dt-bindings/pinctrl/am33xx.h
@@ -0,0 +1,37 @@
+/*
+ * This header provides constants specific to AM33XX pinctrl bindings.
+ */
+
+#include <include/dt-bindings/pinctrl/omap.h>
+
+/* am33xx specific mux bit defines */
+#undef PULL_ENA
+#undef INPUT_EN
+
+#define PULL_DISABLE		(1 << 3)
+#define INPUT_EN		(1 << 5)
+#define SLEWCTRL_FAST		(1 << 6)
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
-- 
1.7.5.4

