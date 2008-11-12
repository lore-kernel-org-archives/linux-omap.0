From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.28-rc3-omap 3/4] twl4030: create regulator devices
Date: Tue, 11 Nov 2008 18:02:30 -0800
Message-ID: <200811111802.30146.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp109.sbc.mail.mud.yahoo.com ([68.142.198.208]:48675 "HELO
	smtp109.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751507AbYKLCKY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Nov 2008 21:10:24 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Initial code to create twl4030 voltage regulator devices, using
the new regulator framework.  Note that this now starts to care
what name is used to declare the TWL chip:

 - TWL4030 is the "old" chip; all newer ones have a bigger variety
   of VAUX2 voltages.  (Boards using the newer chip include at least
   Overo and Pandora; udpated here to report they're using catalog
   versions of the TWL5030.)

 - The tps65930 and tps65920 are cost-reduced catalog versions of
   the TWL5030 parts ... they don't have as many regulators, have
   no battery charger, and trim audio corners too.  (Beagle rev C
   is rumored to use the '30 part.)

Code that could ("should"?) leverage the regulator stuff include 
twl4030 USB transceiver support and MMC glue, and LCD support for
3430SDP and Labrador boards.  Setup will need more work, some of
it board-specific.

---
 arch/arm/mach-omap2/board-omap3pandora.c |    2 
 arch/arm/mach-omap2/board-overo.c        |    2 
 drivers/mfd/twl4030-core.c               |  188 +++++++++++++++++++++++++++--
 include/linux/i2c/twl4030.h              |   12 +
 4 files changed, 192 insertions(+), 12 deletions(-)

--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -162,7 +162,7 @@ static struct twl4030_platform_data omap
 
 static struct i2c_board_info __initdata omap3pandora_i2c_boardinfo[] = {
 	{
-		I2C_BOARD_INFO("twl4030", 0x48),
+		I2C_BOARD_INFO("tps65950", 0x48),
 		.flags = I2C_CLIENT_WAKE,
 		.irq = INT_34XX_SYS_NIRQ,
 		.platform_data = &omap3pandora_twldata,
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -167,7 +167,7 @@ static struct twl4030_platform_data over
 
 static struct i2c_board_info __initdata overo_i2c_boardinfo[] = {
 	{
-		I2C_BOARD_INFO("twl4030", 0x48),
+		I2C_BOARD_INFO("tps65950", 0x48),
 		.flags = I2C_CLIENT_WAKE,
 		.irq = INT_34XX_SYS_NIRQ,
 		.platform_data = &overo_twldata,
--- a/drivers/mfd/twl4030-core.c
+++ b/drivers/mfd/twl4030-core.c
@@ -33,6 +33,8 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 
+#include <linux/regulator/machine.h>
+
 #include <linux/i2c.h>
 #include <linux/i2c/twl4030.h>
 
@@ -71,6 +73,13 @@
 #define twl_has_gpio()	false
 #endif
 
+#if defined(CONFIG_REGULATOR_TWL4030) \
+	|| defined(CONFIG_REGULATOR_TWL4030_MODULE)
+#define twl_has_regulator()	true
+#else
+#define twl_has_regulator()	false
+#endif
+
 #if defined(CONFIG_TWL4030_MADC) || defined(CONFIG_TWL4030_MADC_MODULE)
 #define twl_has_madc()	true
 #else
@@ -155,6 +164,10 @@
 #define HIGH_PERF_SQ			(1 << 3)
 
 
+/* chip-specific feature flags, for i2c_device_id.driver_data */
+#define TWL4030_VAUX2		BIT(0)	/* pre-5030 voltage ranges */
+#define TPS_SUBSET		BIT(1)	/* tps659[23]0 have fewer LDOs */
+
 /*----------------------------------------------------------------------*/
 
 /* is driver active, bound to a chip? */
@@ -360,7 +373,8 @@ EXPORT_SYMBOL(twl4030_i2c_read_u8);
 
 /*----------------------------------------------------------------------*/
 
-static struct device *add_child(unsigned chip, const char *name,
+static struct device *
+add_numbered_child(unsigned chip, const char *name, int num,
 		void *pdata, unsigned pdata_len,
 		bool can_wakeup, int irq0, int irq1)
 {
@@ -368,7 +382,7 @@ static struct device *add_child(unsigned
 	struct twl4030_client	*twl = &twl4030_modules[chip];
 	int			status;
 
-	pdev = platform_device_alloc(name, -1);
+	pdev = platform_device_alloc(name, num);
 	if (!pdev) {
 		dev_dbg(&twl->client->dev, "can't alloc dev\n");
 		status = -ENOMEM;
@@ -410,17 +424,57 @@ err:
 	return &pdev->dev;
 }
 
+static inline struct device *add_child(unsigned chip, const char *name,
+		void *pdata, unsigned pdata_len,
+		bool can_wakeup, int irq0, int irq1)
+{
+	return add_numbered_child(chip, name, -1, pdata, pdata_len,
+		can_wakeup, irq0, irq1);
+}
+
+static struct device *
+add_regulator_linked(int num, struct regulator_init_data *pdata,
+		struct regulator_consumer_supply *consumers,
+		unsigned num_consumers)
+{
+	/* REVISIT:  name "twl4030_regulator.12" gets truncated
+	 * to "twl4030_regulator.1", BIG LOSE ... so hack around
+	 * it by removing "ulator".
+	 */
+
+	/* regulator framework demands init_data ... */
+	if (!pdata)
+		return NULL;
+
+	if (consumers && !pdata->consumer_supplies) {
+		pdata->consumer_supplies = consumers;
+		pdata->num_consumer_supplies = num_consumers;
+	}
+
+	/* NOTE:  we currently ignore regulator IRQs, e.g. for short circuits */
+	return add_numbered_child(3, "twl4030_reg", num,
+		pdata, sizeof(*pdata), false, 0, 0);
+}
+
+static struct device *
+add_regulator(int num, struct regulator_init_data *pdata)
+{
+	return add_regulator_linked(num, pdata, NULL, 0);
+}
+
 /*
  * NOTE:  We know the first 8 IRQs after pdata->base_irq are
  * for the PIH, and the next are for the PWR_INT SIH, since
  * that's how twl_init_irq() sets things up.
  */
 
-static int add_children(struct twl4030_platform_data *pdata)
+static int
+add_children(struct twl4030_platform_data *pdata, unsigned long features)
 {
 	struct device	*child;
+	struct device	*usb_transceiver = NULL;
 
-	if (twl_has_bci() && pdata->bci) {
+	if (twl_has_bci() && pdata->bci && !(features & TPS_SUBSET)) {
 		child = add_child(3, "twl4030_bci",
 				pdata->bci, sizeof(*pdata->bci),
 				false,
@@ -480,6 +534,120 @@ static int add_children(struct twl4030_p
 				pdata->irq_base + 8 + 2, pdata->irq_base + 4);
 		if (IS_ERR(child))
 			return PTR_ERR(child);
+
+		/* we need to connect regulators to this transceiver */
+		usb_transceiver = child;
+	}
+
+	/*
+	 * FIXME we'll often want to link supplies to devices that aren't
+	 * associated with the twl chip ... like VMMC1 to an MMC controller
+	 * (probably MMC1), VAUX3 to an LCD, etc.  When the device has been
+	 * created before this code runs, that might be handled by passing
+	 * a struct regulator_consumer_supply.
+	 */
+
+	if (twl_has_regulator()) {
+		/*
+		child = add_regulator(TWL4030_REG_VPLL1, pdata->vpll1);
+		if (IS_ERR(child))
+			return PTR_ERR(child);
+		*/
+
+		child = add_regulator(TWL4030_REG_VMMC1, pdata->vmmc1);
+		if (IS_ERR(child))
+			return PTR_ERR(child);
+
+		child = add_regulator(TWL4030_REG_VDAC, pdata->vdac);
+		if (IS_ERR(child))
+			return PTR_ERR(child);
+
+		child = add_regulator((features & TWL4030_VAUX2)
+					? TWL4030_REG_VAUX2_4030
+					: TWL4030_REG_VAUX2,
+				pdata->vaux2);
+		if (IS_ERR(child))
+			return PTR_ERR(child);
+	}
+
+	if (twl_has_regulator() && usb_transceiver) {
+		static struct regulator_consumer_supply usb1v5 = {
+			.supply =	"usb1v5",
+		};
+		static struct regulator_consumer_supply usb1v8 = {
+			.supply =	"usb1v8",
+		};
+		static struct regulator_consumer_supply usb3v1 = {
+			.supply =	"usb3v1",
+		};
+		static struct regulator_consumer_supply usbcp = {
+			.supply =	"usbcp",
+		};
+
+		/* this is a template that gets copied */
+		struct regulator_init_data usb_fixed = {
+			.constraints.valid_modes_mask =
+				  REGULATOR_MODE_NORMAL
+				| REGULATOR_MODE_STANDBY
+				| REGULATOR_MODE_OFF,
+			.constraints.valid_ops_mask =
+				  REGULATOR_CHANGE_MODE
+				| REGULATOR_CHANGE_STATUS,
+		};
+
+		usb1v5.dev = usb_transceiver;
+		usb1v8.dev = usb_transceiver;
+		usb3v1.dev = usb_transceiver;
+		usbcp.dev = usb_transceiver;
+
+		child = add_regulator_linked(TWL4030_REG_VUSB1V5, &usb_fixed,
+				&usb1v5, 1);
+		if (IS_ERR(child))
+			return PTR_ERR(child);
+
+		child = add_regulator_linked(TWL4030_REG_VUSB1V8, &usb_fixed,
+				&usb1v8, 1);
+		if (IS_ERR(child))
+			return PTR_ERR(child);
+
+		child = add_regulator_linked(TWL4030_REG_VUSB3V1, &usb_fixed,
+				&usb3v1, 1);
+		if (IS_ERR(child))
+			return PTR_ERR(child);
+
+		child = add_regulator_linked(TWL4030_REG_VUSBCP, &usb_fixed,
+				&usbcp, 1);
+		if (IS_ERR(child))
+			return PTR_ERR(child);
+	}
+
+	/* maybe add LDOs that are omitted on cost-reduced parts */
+	if (twl_has_regulator() && !(features & TPS_SUBSET)) {
+		/*
+		child = add_regulator(TWL4030_REG_VPLL2, pdata->vpll2);
+		if (IS_ERR(child))
+			return PTR_ERR(child);
+		*/
+
+		child = add_regulator(TWL4030_REG_VMMC2, pdata->vmmc2);
+		if (IS_ERR(child))
+			return PTR_ERR(child);
+
+		child = add_regulator(TWL4030_REG_VSIM, pdata->vsim);
+		if (IS_ERR(child))
+			return PTR_ERR(child);
+
+		child = add_regulator(TWL4030_REG_VAUX1, pdata->vaux1);
+		if (IS_ERR(child))
+			return PTR_ERR(child);
+
+		child = add_regulator(TWL4030_REG_VAUX3, pdata->vaux3);
+		if (IS_ERR(child))
+			return PTR_ERR(child);
+
+		child = add_regulator(TWL4030_REG_VAUX4, pdata->vaux4);
+		if (IS_ERR(child))
+			return PTR_ERR(child);
 	}
 
 	return 0;
@@ -643,7 +811,7 @@ twl4030_probe(struct i2c_client *client,
 			goto fail;
 	}
 
-	status = add_children(pdata);
+	status = add_children(pdata, id->driver_data);
 fail:
 	if (status < 0)
 		twl4030_remove(client);
@@ -651,11 +819,11 @@ fail:
 }
 
 static const struct i2c_device_id twl4030_ids[] = {
-	{ "twl4030", 0 },	/* "Triton 2" */
-	{ "tps65950", 0 },	/* catalog version of twl4030 */
-	{ "tps65930", 0 },	/* fewer LDOs and DACs; no charger */
-	{ "tps65920", 0 },	/* fewer LDOs; no codec or charger */
-	{ "twl5030", 0 },	/* T2 updated */
+	{ "twl4030", TWL4030_VAUX2 },	/* "Triton 2" */
+	{ "twl5030", 0 },		/* T2 updated */
+	{ "tps65950", 0 },		/* catalog version of twl5030 */
+	{ "tps65930", TPS_SUBSET },	/* fewer LDOs and DACs; no charger */
+	{ "tps65920", TPS_SUBSET },	/* fewer LDOs; no codec or charger */
 	{ /* end of list */ },
 };
 MODULE_DEVICE_TABLE(i2c, twl4030_ids);
--- a/include/linux/i2c/twl4030.h
+++ b/include/linux/i2c/twl4030.h
@@ -345,6 +345,18 @@ struct twl4030_platform_data {
 	struct twl4030_usb_data			*usb;
 	struct twl4030_power_data		*power;
 
+	/* LDO regulators */
+	struct regulator_init_data		*vdac;
+	struct regulator_init_data		*vpll1;
+	struct regulator_init_data		*vpll2;
+	struct regulator_init_data		*vmmc1;
+	struct regulator_init_data		*vmmc2;
+	struct regulator_init_data		*vsim;
+	struct regulator_init_data		*vaux1;
+	struct regulator_init_data		*vaux2;
+	struct regulator_init_data		*vaux3;
+	struct regulator_init_data		*vaux4;
+
 	/* REVISIT more to come ... _nothing_ should be hard-wired */
 };
 
