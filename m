From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/2] power: supply: cpcap-charger: Update charge current table and add comments
Date: Wed,  3 May 2017 17:26:13 -0700
Message-ID: <20170504002614.11198-2-tony@atomide.com>
References: <20170504002614.11198-1-tony@atomide.com>
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20170504002614.11198-1-tony@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, Marcel Partap <mpartap@gmx.net>, Michael Scott <michael.scott@linaro.org>
List-Id: linux-omap@vger.kernel.org

Turns out a similar battery charger hardware is documented for NXP MC13783
PMIC in "MC13783 Power Management and Audio Circuit Users's Guide" named
MC13783UG.pdf. Looks like the CPCAP charge current table matches that, so
let's start using the nominal values from it.

While at it, let's also add comments to some of the mystery CPCAP charger
registers based on the MC13783UG.pdf documentation.

Note that this patch does not contain any functional changes, the register
values being used stay the same.

Cc: Marcel Partap <mpartap@gmx.net>
Cc: Michael Scott <michael.scott@linaro.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/power/supply/cpcap-charger.c | 59 +++++++++++++++++++++---------------
 1 file changed, 35 insertions(+), 24 deletions(-)

diff --git a/drivers/power/supply/cpcap-charger.c b/drivers/power/supply/cpcap-charger.c
--- a/drivers/power/supply/cpcap-charger.c
+++ b/drivers/power/supply/cpcap-charger.c
@@ -38,20 +38,27 @@
 #include <linux/iio/consumer.h>
 #include <linux/mfd/motorola-cpcap.h>
 
-/* CPCAP_REG_CRM register bits */
+/*
+ * CPCAP_REG_CRM register bits. For documentation of somewhat similar hardware,
+ * see NXP "MC13783 Power Management and Audio Circuit Users's Guide"
+ * MC13783UG.pdf chapter "8.5 Battery Interface Register Summary". The registers
+ * and values for CPCAP are different, but some of the internal components seem
+ * similar. Also see the Motorola Linux kernel cpcap-regbits.h. CPCAP_REG_CHRGR_1
+ * bits that seem to describe the CRM register.
+ */
 #define CPCAP_REG_CRM_UNUSED_641_15	BIT(15)	/* 641 = register number */
 #define CPCAP_REG_CRM_UNUSED_641_14	BIT(14)	/* 641 = register number */
-#define CPCAP_REG_CRM_CHRG_LED_EN	BIT(13)
-#define CPCAP_REG_CRM_RVRSMODE		BIT(12)
-#define CPCAP_REG_CRM_ICHRG_TR1		BIT(11)
+#define CPCAP_REG_CRM_CHRG_LED_EN	BIT(13)	/* Charger LED */
+#define CPCAP_REG_CRM_RVRSMODE		BIT(12)	/* USB VBUS output enable */
+#define CPCAP_REG_CRM_ICHRG_TR1		BIT(11)	/* Trickle charge current */
 #define CPCAP_REG_CRM_ICHRG_TR0		BIT(10)
-#define CPCAP_REG_CRM_FET_OVRD		BIT(9)
-#define CPCAP_REG_CRM_FET_CTRL		BIT(8)
-#define CPCAP_REG_CRM_VCHRG3		BIT(7)
+#define CPCAP_REG_CRM_FET_OVRD		BIT(9)	/* 0 = hardware, 1 = FET_CTRL */
+#define CPCAP_REG_CRM_FET_CTRL		BIT(8)	/* BPFET 1 if FET_OVRD set */
+#define CPCAP_REG_CRM_VCHRG3		BIT(7)	/* Charge voltage bits */
 #define CPCAP_REG_CRM_VCHRG2		BIT(6)
 #define CPCAP_REG_CRM_VCHRG1		BIT(5)
 #define CPCAP_REG_CRM_VCHRG0		BIT(4)
-#define CPCAP_REG_CRM_ICHRG3		BIT(3)
+#define CPCAP_REG_CRM_ICHRG3		BIT(3)	/* Charge current bits */
 #define CPCAP_REG_CRM_ICHRG2		BIT(2)
 #define CPCAP_REG_CRM_ICHRG1		BIT(1)
 #define CPCAP_REG_CRM_ICHRG0		BIT(0)
@@ -82,23 +89,27 @@
 #define CPCAP_REG_CRM_VCHRG_4V42	CPCAP_REG_CRM_VCHRG(0xe)
 #define CPCAP_REG_CRM_VCHRG_4V44	CPCAP_REG_CRM_VCHRG(0xf)
 
-/* CPCAP_REG_CRM charge currents */
+/*
+ * CPCAP_REG_CRM charge currents. These seem to match MC13783UG.pdf
+ * values in "Table 8-3. Charge Path Regulator Current Limit
+ * Characteristics" for the nominal values.
+ */
 #define CPCAP_REG_CRM_ICHRG(val)	(((val) & 0xf) << 0)
 #define CPCAP_REG_CRM_ICHRG_0A000	CPCAP_REG_CRM_ICHRG(0x0)
 #define CPCAP_REG_CRM_ICHRG_0A070	CPCAP_REG_CRM_ICHRG(0x1)
-#define CPCAP_REG_CRM_ICHRG_0A176	CPCAP_REG_CRM_ICHRG(0x2)
-#define CPCAP_REG_CRM_ICHRG_0A264	CPCAP_REG_CRM_ICHRG(0x3)
-#define CPCAP_REG_CRM_ICHRG_0A352	CPCAP_REG_CRM_ICHRG(0x4)
-#define CPCAP_REG_CRM_ICHRG_0A440	CPCAP_REG_CRM_ICHRG(0x5)
-#define CPCAP_REG_CRM_ICHRG_0A528	CPCAP_REG_CRM_ICHRG(0x6)
-#define CPCAP_REG_CRM_ICHRG_0A616	CPCAP_REG_CRM_ICHRG(0x7)
-#define CPCAP_REG_CRM_ICHRG_0A704	CPCAP_REG_CRM_ICHRG(0x8)
-#define CPCAP_REG_CRM_ICHRG_0A792	CPCAP_REG_CRM_ICHRG(0x9)
-#define CPCAP_REG_CRM_ICHRG_0A880	CPCAP_REG_CRM_ICHRG(0xa)
-#define CPCAP_REG_CRM_ICHRG_0A968	CPCAP_REG_CRM_ICHRG(0xb)
-#define CPCAP_REG_CRM_ICHRG_1A056	CPCAP_REG_CRM_ICHRG(0xc)
-#define CPCAP_REG_CRM_ICHRG_1A144	CPCAP_REG_CRM_ICHRG(0xd)
-#define CPCAP_REG_CRM_ICHRG_1A584	CPCAP_REG_CRM_ICHRG(0xe)
+#define CPCAP_REG_CRM_ICHRG_0A177	CPCAP_REG_CRM_ICHRG(0x2)
+#define CPCAP_REG_CRM_ICHRG_0A266	CPCAP_REG_CRM_ICHRG(0x3)
+#define CPCAP_REG_CRM_ICHRG_0A355	CPCAP_REG_CRM_ICHRG(0x4)
+#define CPCAP_REG_CRM_ICHRG_0A443	CPCAP_REG_CRM_ICHRG(0x5)
+#define CPCAP_REG_CRM_ICHRG_0A532	CPCAP_REG_CRM_ICHRG(0x6)
+#define CPCAP_REG_CRM_ICHRG_0A621	CPCAP_REG_CRM_ICHRG(0x7)
+#define CPCAP_REG_CRM_ICHRG_0A709	CPCAP_REG_CRM_ICHRG(0x8)
+#define CPCAP_REG_CRM_ICHRG_0A798	CPCAP_REG_CRM_ICHRG(0x9)
+#define CPCAP_REG_CRM_ICHRG_0A886	CPCAP_REG_CRM_ICHRG(0xa)
+#define CPCAP_REG_CRM_ICHRG_0A975	CPCAP_REG_CRM_ICHRG(0xb)
+#define CPCAP_REG_CRM_ICHRG_1A064	CPCAP_REG_CRM_ICHRG(0xc)
+#define CPCAP_REG_CRM_ICHRG_1A152	CPCAP_REG_CRM_ICHRG(0xd)
+#define CPCAP_REG_CRM_ICHRG_1A596	CPCAP_REG_CRM_ICHRG(0xe)
 #define CPCAP_REG_CRM_ICHRG_NO_LIMIT	CPCAP_REG_CRM_ICHRG(0xf)
 
 enum {
@@ -464,9 +475,9 @@ static void cpcap_usb_detect(struct work_struct *work)
 		int max_current;
 
 		if (cpcap_charger_battery_found(ddata))
-			max_current = CPCAP_REG_CRM_ICHRG_1A584;
+			max_current = CPCAP_REG_CRM_ICHRG_1A596;
 		else
-			max_current = CPCAP_REG_CRM_ICHRG_0A528;
+			max_current = CPCAP_REG_CRM_ICHRG_0A532;
 
 		error = cpcap_charger_set_state(ddata,
 						CPCAP_REG_CRM_VCHRG_4V35,
-- 
2.12.2
