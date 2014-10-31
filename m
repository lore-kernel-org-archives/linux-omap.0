From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH] pinctrl: dra: dt-bindings: Fix output pull up/down
Date: Fri, 31 Oct 2014 12:52:25 +0200
Message-ID: <1414752745-13696-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42804 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756393AbaJaKwc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 31 Oct 2014 06:52:32 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: nm@ti.com, balbi@ti.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Roger Quadros <rogerq@ti.com>

For PIN_OUTPUT_PULLUP and PIN_OUTPUT_PULLDOWN we must not set the
PULL_DIS bit which disables the PULLs.

While at that get rid for the PULL_ENA defination. It is misleading
as there is no PULL enable bit in the register. And a zero bit defination
makes no sense.

Fixes: 23d9cec07c58 (:pinctrl: dra: dt-bindings: Fix pull enable/disable")

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 include/dt-bindings/pinctrl/dra.h | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/include/dt-bindings/pinctrl/dra.h b/include/dt-bindings/pinctrl/dra.h
index 3d33794..71098e4 100644
--- a/include/dt-bindings/pinctrl/dra.h
+++ b/include/dt-bindings/pinctrl/dra.h
@@ -30,7 +30,6 @@
 #define MUX_MODE14	0xe
 #define MUX_MODE15	0xf
 
-#define PULL_ENA		(0 << 16)
 #define PULL_DIS		(1 << 16)
 #define PULL_UP			(1 << 17)
 #define INPUT_EN		(1 << 18)
@@ -40,12 +39,12 @@
 
 /* Active pin states */
 #define PIN_OUTPUT		(0 | PULL_DIS)
-#define PIN_OUTPUT_PULLUP	(PIN_OUTPUT | PULL_ENA | PULL_UP)
-#define PIN_OUTPUT_PULLDOWN	(PIN_OUTPUT | PULL_ENA)
+#define PIN_OUTPUT_PULLUP	(PULL_UP)
+#define PIN_OUTPUT_PULLDOWN	(0)
 #define PIN_INPUT		(INPUT_EN | PULL_DIS)
 #define PIN_INPUT_SLEW		(INPUT_EN | SLEWCONTROL)
-#define PIN_INPUT_PULLUP	(PULL_ENA | INPUT_EN | PULL_UP)
-#define PIN_INPUT_PULLDOWN	(PULL_ENA | INPUT_EN)
+#define PIN_INPUT_PULLUP	(INPUT_EN | PULL_UP)
+#define PIN_INPUT_PULLDOWN	(INPUT_EN)
 
 #endif
 
-- 
1.8.3.2

