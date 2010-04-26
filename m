From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 1/1] i2c-omap: add mpu wake up latency constraint in i2c
Date: Mon, 26 Apr 2010 16:02:06 -0700
Message-ID: <8739yhu8b5.fsf@deeprootsystems.com>
References: <1271876654-13613-1-git-send-email-khilman@deeprootsystems.com>
	<1271876654-13613-2-git-send-email-khilman@deeprootsystems.com>
	<20100426225851.GR7225@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:50232 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752742Ab0DZXCK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Apr 2010 19:02:10 -0400
Received: by pvg2 with SMTP id 2so780607pvg.19
        for <linux-omap@vger.kernel.org>; Mon, 26 Apr 2010 16:02:09 -0700 (PDT)
In-Reply-To: <20100426225851.GR7225@atomide.com> (Tony Lindgren's message of "Mon\, 26 Apr 2010 15\:58\:51 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

Tony Lindgren <tony@atomide.com> writes:

> * Kevin Hilman <khilman@deeprootsystems.com> [100421 11:59]:
>> From: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
>> 
>> While waiting for completion of the i2c transfer, the
>> MPU could hit OFF mode and cause several msecs of
>> delay that made i2c transfers fail more often. The
>> extra delays and subsequent re-trys cause i2c clocks
>> to be active more often. This has also an negative
>> effect on power consumption.
>> 
>> Created a mechanism for passing and using the
>> constraint setting function in driver code. The used
>> mpu wake up latency constraints are now set individually
>> per bus, and they are calculated based on clock rate
>> and fifo size.
>> 
>> Thanks to Jarkko Nikula, Moiz Sonasath, Paul Walmsley,
>> and Nishanth Menon for tuning out the details of
>> this patch.
>

[...]

>>  
>> -	if (!i2c_rate[bus_id - 1])
>> -		i2c_rate[bus_id - 1] = clkrate;
>> -	i2c_rate[bus_id - 1] &= ~OMAP_I2C_CMDLINE_SETUP;
>> +	if (!i2c_pdata[bus_id - 1].clkrate)
>> +		i2c_pdata[bus_id - 1].clkrate = clkrate;
>> +
>> +	omap_set_i2c_constraint_func(&i2c_pdata[bus_id - 1]);
>> +	i2c_pdata[bus_id - 1].clkrate &= ~OMAP_I2C_CMDLINE_SETUP;
>>  
>>  	return omap_i2c_add_bus(bus_id);
>>  }
>
> Looks like this all could be done in omap_i2c_add_bus a bit simpler.
>

OK, here's updated version.

>From 319b439fac05d973dc5800fd061892b70f961708 Mon Sep 17 00:00:00 2001
From: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
Date: Wed, 21 Oct 2009 14:51:21 +0300
Subject: [PATCH] i2c-omap: add mpu wake up latency constraint in i2c

While waiting for completion of the i2c transfer, the
MPU could hit OFF mode and cause several msecs of
delay that made i2c transfers fail more often. The
extra delays and subsequent re-trys cause i2c clocks
to be active more often. This has also an negative
effect on power consumption.

Created a mechanism for passing and using the
constraint setting function in driver code. The used
mpu wake up latency constraints are now set individually
per bus, and they are calculated based on clock rate
and fifo size.

Thanks to Jarkko Nikula, Moiz Sonasath, Paul Walmsley,
and Nishanth Menon for tuning out the details of
this patch.

Cc: Moiz Sonasath <m-sonasath@ti.com>
Cc: Jarkko Nikula <jhnikula@gmail.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Nishanth Menon <nm@ti.com>
Signed-off-by: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
Based on current omap-testing branch.

Changes from previous version, as requested by Tony:

Remove omap_set_i2c_constraint_func() in favor of conditionally
adding the flag in omap_i2c_add_bus() in order to keep all the
OMAP conditional checking in a single location.

 arch/arm/plat-omap/i2c.c      |   48 ++++++++++++++++++++++++++++++----------
 drivers/i2c/busses/i2c-omap.c |   24 +++++++++++++++++---
 include/linux/i2c-omap.h      |    9 +++++++
 3 files changed, 65 insertions(+), 16 deletions(-)
 create mode 100644 include/linux/i2c-omap.h

diff --git a/arch/arm/plat-omap/i2c.c b/arch/arm/plat-omap/i2c.c
index 624e262..9ceeca8 100644
--- a/arch/arm/plat-omap/i2c.c
+++ b/arch/arm/plat-omap/i2c.c
@@ -26,9 +26,12 @@
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
 #include <linux/i2c.h>
+#include <linux/i2c-omap.h>
+
 #include <mach/irqs.h>
 #include <plat/mux.h>
 #include <plat/i2c.h>
+#include <plat/omap-pm.h>
 
 #define OMAP_I2C_SIZE		0x3f
 #define OMAP1_I2C_BASE		0xfffb3800
@@ -70,19 +73,35 @@ static struct resource i2c_resources[][2] = {
 		},					\
 	}
 
-static u32 i2c_rate[ARRAY_SIZE(i2c_resources)];
+static struct omap_i2c_bus_platform_data i2c_pdata[ARRAY_SIZE(i2c_resources)];
 static struct platform_device omap_i2c_devices[] = {
-	I2C_DEV_BUILDER(1, i2c_resources[0], &i2c_rate[0]),
+	I2C_DEV_BUILDER(1, i2c_resources[0], &i2c_pdata[0]),
 #if	defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
-	I2C_DEV_BUILDER(2, i2c_resources[1], &i2c_rate[1]),
+	I2C_DEV_BUILDER(2, i2c_resources[1], &i2c_pdata[1]),
 #endif
 #if	defined(CONFIG_ARCH_OMAP3)
-	I2C_DEV_BUILDER(3, i2c_resources[2], &i2c_rate[2]),
+	I2C_DEV_BUILDER(3, i2c_resources[2], &i2c_pdata[2]),
 #endif
 };
 
 #define OMAP_I2C_CMDLINE_SETUP	(BIT(31))
 
+#ifdef CONFIG_ARCH_OMAP3
+/*
+ * omap_i2c_set_wfc_mpu_wkup_lat - sets mpu wake up constraint
+ * @dev:	i2c bus device pointer
+ * @val:	latency constraint to set, -1 to disable constraint
+ *
+ * When waiting for completion of a i2c transfer, we need to set a wake up
+ * latency constraint for the MPU. This is to ensure quick enough wakeup from
+ * idle, when transfer completes.
+ */
+static void omap_i2c_set_wfc_mpu_wkup_lat(struct device *dev, int val)
+{
+	omap_pm_set_max_mpu_wakeup_lat(dev, val);
+}
+#endif
+
 static int __init omap_i2c_nr_ports(void)
 {
 	int ports = 0;
@@ -100,10 +119,12 @@ static int __init omap_i2c_nr_ports(void)
 static int __init omap_i2c_add_bus(int bus_id)
 {
 	struct platform_device *pdev;
+	struct omap_i2c_bus_platform_data *pd;
 	struct resource *res;
 	resource_size_t base, irq;
 
 	pdev = &omap_i2c_devices[bus_id - 1];
+	pd = pdev->dev.platform_data;
 	if (bus_id == 1) {
 		res = pdev->resource;
 		if (cpu_class_is_omap1()) {
@@ -122,6 +143,8 @@ static int __init omap_i2c_add_bus(int bus_id)
 		omap1_i2c_mux_pins(bus_id);
 	if (cpu_class_is_omap2())
 		omap2_i2c_mux_pins(bus_id);
+	if (cpu_is_omap34xx())
+		pd->set_mpu_wkup_lat = omap_i2c_set_wfc_mpu_wkup_lat;
 
 	return platform_device_register(pdev);
 }
@@ -146,8 +169,8 @@ static int __init omap_i2c_bus_setup(char *str)
 	get_options(str, 3, ints);
 	if (ints[0] < 2 || ints[1] < 1 || ints[1] > ports)
 		return 0;
-	i2c_rate[ints[1] - 1] = ints[2];
-	i2c_rate[ints[1] - 1] |= OMAP_I2C_CMDLINE_SETUP;
+	i2c_pdata[ints[1] - 1].clkrate = ints[2];
+	i2c_pdata[ints[1] - 1].clkrate |= OMAP_I2C_CMDLINE_SETUP;
 
 	return 1;
 }
@@ -161,9 +184,9 @@ static int __init omap_register_i2c_bus_cmdline(void)
 {
 	int i, err = 0;
 
-	for (i = 0; i < ARRAY_SIZE(i2c_rate); i++)
-		if (i2c_rate[i] & OMAP_I2C_CMDLINE_SETUP) {
-			i2c_rate[i] &= ~OMAP_I2C_CMDLINE_SETUP;
+	for (i = 0; i < ARRAY_SIZE(i2c_pdata); i++)
+		if (i2c_pdata[i].clkrate & OMAP_I2C_CMDLINE_SETUP) {
+			i2c_pdata[i].clkrate &= ~OMAP_I2C_CMDLINE_SETUP;
 			err = omap_i2c_add_bus(i + 1);
 			if (err)
 				goto out;
@@ -197,9 +220,10 @@ int __init omap_register_i2c_bus(int bus_id, u32 clkrate,
 			return err;
 	}
 
-	if (!i2c_rate[bus_id - 1])
-		i2c_rate[bus_id - 1] = clkrate;
-	i2c_rate[bus_id - 1] &= ~OMAP_I2C_CMDLINE_SETUP;
+	if (!i2c_pdata[bus_id - 1].clkrate)
+		i2c_pdata[bus_id - 1].clkrate = clkrate;
+
+	i2c_pdata[bus_id - 1].clkrate &= ~OMAP_I2C_CMDLINE_SETUP;
 
 	return omap_i2c_add_bus(bus_id);
 }
diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index b81484d..f0d241f 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -38,6 +38,7 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/slab.h>
+#include <linux/i2c-omap.h>
 
 /* I2C controller revisions */
 #define OMAP_I2C_REV_2			0x20
@@ -175,6 +176,9 @@ struct omap_i2c_dev {
 	struct clk		*fclk;		/* Functional clock */
 	struct completion	cmd_complete;
 	struct resource		*ioarea;
+	u32			latency;	/* maximum mpu wkup latency */
+	void			(*set_mpu_wkup_lat)(struct device *dev,
+						    int latency);
 	u32			speed;		/* Speed of bus in Khz */
 	u16			cmd_err;
 	u8			*buf;
@@ -603,8 +607,12 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
 	 * REVISIT: We should abort the transfer on signals, but the bus goes
 	 * into arbitration and we're currently unable to recover from it.
 	 */
+	if (dev->set_mpu_wkup_lat != NULL)
+		dev->set_mpu_wkup_lat(dev->dev, dev->latency);
 	r = wait_for_completion_timeout(&dev->cmd_complete,
 					OMAP_I2C_TIMEOUT);
+	if (dev->set_mpu_wkup_lat != NULL)
+		dev->set_mpu_wkup_lat(dev->dev, -1);
 	dev->buf_len = 0;
 	if (r < 0)
 		return r;
@@ -927,6 +935,7 @@ omap_i2c_probe(struct platform_device *pdev)
 	struct omap_i2c_dev	*dev;
 	struct i2c_adapter	*adap;
 	struct resource		*mem, *irq, *ioarea;
+	struct omap_i2c_bus_platform_data *pdata = pdev->dev.platform_data;
 	irq_handler_t isr;
 	int r;
 	u32 speed = 0;
@@ -956,10 +965,13 @@ omap_i2c_probe(struct platform_device *pdev)
 		goto err_release_region;
 	}
 
-	if (pdev->dev.platform_data != NULL)
-		speed = *(u32 *)pdev->dev.platform_data;
-	else
-		speed = 100;	/* Defualt speed */
+	if (pdata != NULL) {
+		speed = pdata->clkrate;
+		dev->set_mpu_wkup_lat = pdata->set_mpu_wkup_lat;
+	} else {
+		speed = 100;	/* Default speed */
+		dev->set_mpu_wkup_lat = NULL;
+	}
 
 	dev->speed = speed;
 	dev->idle = 1;
@@ -1012,6 +1024,10 @@ omap_i2c_probe(struct platform_device *pdev)
 			dev->fifo_size = (dev->fifo_size / 2);
 			dev->b_hw = 1; /* Enable hardware fixes */
 		}
+		/* calculate wakeup latency constraint for MPU */
+		if (dev->set_mpu_wkup_lat != NULL)
+			dev->latency = (1000000 * dev->fifo_size) /
+				       (1000 * speed / 8);
 	}
 
 	/* reset ASAP, clearing any IRQs */
diff --git a/include/linux/i2c-omap.h b/include/linux/i2c-omap.h
new file mode 100644
index 0000000..1362fba
--- /dev/null
+++ b/include/linux/i2c-omap.h
@@ -0,0 +1,9 @@
+#ifndef __I2C_OMAP_H__
+#define __I2C_OMAP_H__
+
+struct omap_i2c_bus_platform_data {
+	u32		clkrate;
+	void		(*set_mpu_wkup_lat)(struct device *dev, int set);
+};
+
+#endif
-- 
1.7.0.2

