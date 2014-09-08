From: Mugunthan V N <mugunthanvnm@ti.com>
Subject: [resend PATCH 1/3] pinctrl: dra7: dt-bindings: add pin off modes for dra7 SoC
Date: Tue, 9 Sep 2014 00:49:56 +0530
Message-ID: <1410203998-8700-2-git-send-email-mugunthanvnm@ti.com>
References: <1410203998-8700-1-git-send-email-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1410203998-8700-1-git-send-email-mugunthanvnm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: bcousson@baylibre.com, tony@atomide.com
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Mugunthan V N <mugunthanvnm@ti.com>
List-Id: linux-omap@vger.kernel.org

Add pin off modes for dra7 SoC so that during module disable or suspend
state it can help saving power

Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>
---
 include/dt-bindings/pinctrl/dra.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/dt-bindings/pinctrl/dra.h b/include/dt-bindings/pinctrl/dra.h
index 002a285..a0ff2d0 100644
--- a/include/dt-bindings/pinctrl/dra.h
+++ b/include/dt-bindings/pinctrl/dra.h
@@ -46,5 +46,13 @@
 #define PIN_INPUT_PULLUP	(PULL_ENA | INPUT_EN | PULL_UP)
 #define PIN_INPUT_PULLDOWN	(PULL_ENA | INPUT_EN)
 
+/* Off mode states */
+#define PIN_OFF_NONE		0
+#define PIN_OFF_OUTPUT_HIGH	(OFF_EN | OFFOUT_EN | OFFOUT_VAL)
+#define PIN_OFF_OUTPUT_LOW	(OFF_EN | OFFOUT_EN)
+#define PIN_OFF_INPUT_PULLUP	(OFF_EN | OFF_PULL_EN | OFF_PULL_UP)
+#define PIN_OFF_INPUT_PULLDOWN	(OFF_EN | OFF_PULL_EN)
+#define PIN_OFF_WAKEUPENABLE	WAKEUP_EN
+
 #endif
 
-- 
2.1.0
