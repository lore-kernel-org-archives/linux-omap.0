From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/2] power: supply: cpcap-charger: Fix charger voltages based on ADC values
Date: Wed,  3 May 2017 17:26:14 -0700
Message-ID: <20170504002614.11198-3-tony@atomide.com>
References: <20170504002614.11198-1-tony@atomide.com>
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20170504002614.11198-1-tony@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, Marcel Partap <mpartap@gmx.net>, Michael Scott <michael.scott@linaro.org>
List-Id: linux-omap@vger.kernel.org

With the ADC driver working, we can now fix the voltage table based on
the values read from the ADC.

Note that unlike the ICHRG registers, the VCHRG register bits don't
match the MC13783UG.pdf.

Cc: Marcel Partap <mpartap@gmx.net>
Cc: Michael Scott <michael.scott@linaro.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/power/supply/cpcap-charger.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/power/supply/cpcap-charger.c b/drivers/power/supply/cpcap-charger.c
--- a/drivers/power/supply/cpcap-charger.c
+++ b/drivers/power/supply/cpcap-charger.c
@@ -70,19 +70,23 @@
 #define CPCAP_REG_CRM_TR_0A48		CPCAP_REG_CRM_TR(0x2)
 #define CPCAP_REG_CRM_TR_0A72		CPCAP_REG_CRM_TR(0x4)
 
-/* CPCAP_REG_CRM charge voltages */
+/*
+ * CPCAP_REG_CRM charge voltages based on the ADC channel 1 values.
+ * Note that these register bits don't match MC13783UG.pdf VCHRG
+ * register bits.
+ */
 #define CPCAP_REG_CRM_VCHRG(val)	(((val) & 0xf) << 4)
 #define CPCAP_REG_CRM_VCHRG_3V80	CPCAP_REG_CRM_VCHRG(0x0)
 #define CPCAP_REG_CRM_VCHRG_4V10	CPCAP_REG_CRM_VCHRG(0x1)
-#define CPCAP_REG_CRM_VCHRG_4V15	CPCAP_REG_CRM_VCHRG(0x2)
-#define CPCAP_REG_CRM_VCHRG_4V20	CPCAP_REG_CRM_VCHRG(0x3)
-#define CPCAP_REG_CRM_VCHRG_4V22	CPCAP_REG_CRM_VCHRG(0x4)
-#define CPCAP_REG_CRM_VCHRG_4V24	CPCAP_REG_CRM_VCHRG(0x5)
-#define CPCAP_REG_CRM_VCHRG_4V26	CPCAP_REG_CRM_VCHRG(0x6)
-#define CPCAP_REG_CRM_VCHRG_4V28	CPCAP_REG_CRM_VCHRG(0x7)
-#define CPCAP_REG_CRM_VCHRG_4V30	CPCAP_REG_CRM_VCHRG(0x8)
-#define CPCAP_REG_CRM_VCHRG_4V32	CPCAP_REG_CRM_VCHRG(0x9)
-#define CPCAP_REG_CRM_VCHRG_4V34	CPCAP_REG_CRM_VCHRG(0xa)
+#define CPCAP_REG_CRM_VCHRG_4V12	CPCAP_REG_CRM_VCHRG(0x2)
+#define CPCAP_REG_CRM_VCHRG_4V15	CPCAP_REG_CRM_VCHRG(0x3)
+#define CPCAP_REG_CRM_VCHRG_4V17	CPCAP_REG_CRM_VCHRG(0x4)
+#define CPCAP_REG_CRM_VCHRG_4V20	CPCAP_REG_CRM_VCHRG(0x5)
+#define CPCAP_REG_CRM_VCHRG_4V23	CPCAP_REG_CRM_VCHRG(0x6)
+#define CPCAP_REG_CRM_VCHRG_4V25	CPCAP_REG_CRM_VCHRG(0x7)
+#define CPCAP_REG_CRM_VCHRG_4V27	CPCAP_REG_CRM_VCHRG(0x8)
+#define CPCAP_REG_CRM_VCHRG_4V30	CPCAP_REG_CRM_VCHRG(0x9)
+#define CPCAP_REG_CRM_VCHRG_4V33	CPCAP_REG_CRM_VCHRG(0xa)
 #define CPCAP_REG_CRM_VCHRG_4V35	CPCAP_REG_CRM_VCHRG(0xb)
 #define CPCAP_REG_CRM_VCHRG_4V38	CPCAP_REG_CRM_VCHRG(0xc)
 #define CPCAP_REG_CRM_VCHRG_4V40	CPCAP_REG_CRM_VCHRG(0xd)
-- 
2.12.2
