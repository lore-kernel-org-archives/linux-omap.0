From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: [PATCH 1/1] OMAP: I2C: Add mpu wake up latency constraint in i2c
Date: Mon, 5 Oct 2009 22:38:24 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702F9F49663@dbde02.ent.ti.com>
References: <> <1253204923-21916-1-git-send-email-kalle.jokiniemi@digia.com>
 <1253204923-21916-2-git-send-email-kalle.jokiniemi@digia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52983 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753052AbZJERJN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Oct 2009 13:09:13 -0400
In-Reply-To: <1253204923-21916-2-git-send-email-kalle.jokiniemi@digia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kalle Jokiniemi <kalle.jokiniemi@digia.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "Sonasath, Moiz" <m-sonasath@ti.com>
Cc: "jhnikula@gmail.com" <jhnikula@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Jokiniemi

>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Kalle
>Jokiniemi
>Sent: Thursday, September 17, 2009 11:29 AM
>To: khilman@deeprootsystems.com
>Cc: jhnikula@gmail.com; linux-omap@vger.kernel.org; Kalle Jokiniemi
>Subject: [PATCH 1/1] OMAP: I2C: Add mpu wake up latency constraint in i2c
>
>While waiting for completion of the i2c transfer, the
>MPU could hit OFF mode and cause several msecs of
>delay that made i2c transfers fail more often. The

How many bytes i2c read were you doing, that failed?

What OPP are you in when you observe these failures? 
VDD1:OPP?

>extra delays and subsequent re-trys cause i2c clocks
>to be active more often. This has also an negative
>effect on power consumption.
>
>Added a constraint that allows MPU to wake up in few
>hundred usecs, which is roughly the average i2c wait
>period.

How did you arrive at the number 500us for the wakeup latency? 

On Zoom2 with Synaptic touch screen controller on I2C-2,
at vdd1:opp1 we need to put a wakeup latency of 400us else we see data corruption.

Our case is doing a write of 1 byte followed by read of 16 bytes.

>
>The constraint function is passed as platform data from
>plat-omap/i2c.c and applied only on OMAP34XX devices.
>
>Signed-off-by: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
>---
> arch/arm/plat-omap/i2c.c      |   49 +++++++++++++++++++++++++++++++----------
> drivers/i2c/busses/i2c-omap.c |   17 +++++++++++---
> include/linux/i2c-omap.h      |    9 +++++++
> 3 files changed, 59 insertions(+), 16 deletions(-)
> create mode 100644 include/linux/i2c-omap.h
>
>diff --git a/arch/arm/plat-omap/i2c.c b/arch/arm/plat-omap/i2c.c
>index 8b84839..d43d0ad 100644
>--- a/arch/arm/plat-omap/i2c.c
>+++ b/arch/arm/plat-omap/i2c.c
>@@ -26,8 +26,10 @@
> #include <linux/kernel.h>
> #include <linux/platform_device.h>
> #include <linux/i2c.h>
>+#include <linux/i2c-omap.h>
> #include <mach/irqs.h>
> #include <mach/mux.h>
>+#include <mach/omap-pm.h>
>
> #define OMAP_I2C_SIZE		0x3f
> #define OMAP1_I2C_BASE		0xfffb3800
>@@ -69,14 +71,14 @@ static struct resource i2c_resources[][2] = {
> 		},					\
> 	}
>
>-static u32 i2c_rate[ARRAY_SIZE(i2c_resources)];
>+static struct omap_i2c_bus_platform_data i2c_pdata[ARRAY_SIZE(i2c_resources)];
> static struct platform_device omap_i2c_devices[] = {
>-	I2C_DEV_BUILDER(1, i2c_resources[0], &i2c_rate[0]),
>+	I2C_DEV_BUILDER(1, i2c_resources[0], &i2c_pdata[0]),
> #if	defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
>-	I2C_DEV_BUILDER(2, i2c_resources[1], &i2c_rate[1]),
>+	I2C_DEV_BUILDER(2, i2c_resources[1], &i2c_pdata[1]),
> #endif
> #if	defined(CONFIG_ARCH_OMAP34XX)
>-	I2C_DEV_BUILDER(3, i2c_resources[2], &i2c_rate[2]),
>+	I2C_DEV_BUILDER(3, i2c_resources[2], &i2c_pdata[2]),
> #endif
> };
>
>@@ -100,6 +102,25 @@ static const int omap34xx_pins[][2] = {};
>
> #define OMAP_I2C_CMDLINE_SETUP	(BIT(31))
>
>+/**
>+ * omap_i2c_set_wfc_mpu_wkup_lat - sets mpu wake up constraint
>+ * @dev:	i2c bus device pointer
>+ * @set:	set or clear constraints
>+ *
>+ * When waiting for completion of a i2c transfer, we need to set a wake up
>+ * latency constraint for the MPU. This is to ensure quick enough wakeup
>+ * from idle, when transfer completes.
>+ */
>+#ifdef CONFIG_ARCH_OMAP34XX
>+static void omap_i2c_set_wfc_mpu_wkup_lat(struct device *dev, int set)
>+{
>+	omap_pm_set_max_mpu_wakeup_lat(dev, set ? 500 : -1);
>+}
>+#else
>+static inline void omap_i2c_set_wfc_mpu_wkup_lat(struct device *dev, int set)
>+{; }
>+#endif
>+
> static void __init omap_i2c_mux_pins(int bus)
> {
> 	int scl, sda;
>@@ -180,8 +201,8 @@ static int __init omap_i2c_bus_setup(char *str)
> 	get_options(str, 3, ints);
> 	if (ints[0] < 2 || ints[1] < 1 || ints[1] > ports)
> 		return 0;
>-	i2c_rate[ints[1] - 1] = ints[2];
>-	i2c_rate[ints[1] - 1] |= OMAP_I2C_CMDLINE_SETUP;
>+	i2c_pdata[ints[1] - 1].clkrate = ints[2];
>+	i2c_pdata[ints[1] - 1].clkrate |= OMAP_I2C_CMDLINE_SETUP;
>
> 	return 1;
> }
>@@ -195,9 +216,11 @@ static int __init omap_register_i2c_bus_cmdline(void)
> {
> 	int i, err = 0;
>
>-	for (i = 0; i < ARRAY_SIZE(i2c_rate); i++)
>-		if (i2c_rate[i] & OMAP_I2C_CMDLINE_SETUP) {
>-			i2c_rate[i] &= ~OMAP_I2C_CMDLINE_SETUP;
>+	for (i = 0; i < ARRAY_SIZE(i2c_pdata); i++)
>+		if (i2c_pdata[i].clkrate & OMAP_I2C_CMDLINE_SETUP) {
>+			i2c_pdata[i].clkrate &= ~OMAP_I2C_CMDLINE_SETUP;
>+			i2c_pdata[i].set_mpu_wkup_lat =
>+						omap_i2c_set_wfc_mpu_wkup_lat;
> 			err = omap_i2c_add_bus(i + 1);
> 			if (err)
> 				goto out;
>@@ -231,9 +254,11 @@ int __init omap_register_i2c_bus(int bus_id, u32 clkrate,
> 			return err;
> 	}
>
>-	if (!i2c_rate[bus_id - 1])
>-		i2c_rate[bus_id - 1] = clkrate;
>-	i2c_rate[bus_id - 1] &= ~OMAP_I2C_CMDLINE_SETUP;
>+	if (!i2c_pdata[bus_id - 1].clkrate)
>+		i2c_pdata[bus_id - 1].clkrate = clkrate;
>+
>+	i2c_pdata[bus_id - 1].set_mpu_wkup_lat = omap_i2c_set_wfc_mpu_wkup_lat;
>+	i2c_pdata[bus_id - 1].clkrate &= ~OMAP_I2C_CMDLINE_SETUP;
>
> 	return omap_i2c_add_bus(bus_id);
> }
>diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
>index 75bf3ad..da6d276 100644
>--- a/drivers/i2c/busses/i2c-omap.c
>+++ b/drivers/i2c/busses/i2c-omap.c
>@@ -37,6 +37,7 @@
> #include <linux/platform_device.h>
> #include <linux/clk.h>
> #include <linux/io.h>
>+#include <linux/i2c-omap.h>
>
> /* I2C controller revisions */
> #define OMAP_I2C_REV_2			0x20
>@@ -165,6 +166,8 @@ struct omap_i2c_dev {
> 	struct clk		*fclk;		/* Functional clock */
> 	struct completion	cmd_complete;
> 	struct resource		*ioarea;
>+	void			(*set_mpu_wkup_lat)(struct device *dev,
>+						    int set);
> 	u32			speed;		/* Speed of bus in Khz */
> 	u16			cmd_err;
> 	u8			*buf;
>@@ -526,8 +529,10 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
> 	 * REVISIT: We should abort the transfer on signals, but the bus goes
> 	 * into arbitration and we're currently unable to recover from it.
> 	 */
>+	dev->set_mpu_wkup_lat(dev->dev, 1);
> 	r = wait_for_completion_timeout(&dev->cmd_complete,
> 					OMAP_I2C_TIMEOUT);
>+	dev->set_mpu_wkup_lat(dev->dev, 0);
> 	dev->buf_len = 0;
> 	if (r < 0)
> 		return r;
>@@ -844,6 +849,7 @@ omap_i2c_probe(struct platform_device *pdev)
> 	struct omap_i2c_dev	*dev;
> 	struct i2c_adapter	*adap;
> 	struct resource		*mem, *irq, *ioarea;
>+	struct omap_i2c_bus_platform_data *pdata = pdev->dev.platform_data;
> 	irq_handler_t isr;
> 	int r;
> 	u32 speed = 0;
>@@ -873,10 +879,13 @@ omap_i2c_probe(struct platform_device *pdev)
> 		goto err_release_region;
> 	}
>
>-	if (pdev->dev.platform_data != NULL)
>-		speed = *(u32 *)pdev->dev.platform_data;
>-	else
>-		speed = 100;	/* Defualt speed */
>+	if (pdata != NULL) {
>+		speed = pdata->clkrate;
>+		dev->set_mpu_wkup_lat = pdata->set_mpu_wkup_lat;
>+	} else {
>+		speed = 100;	/* Default speed */
>+		dev->set_mpu_wkup_lat = NULL;
>+	}
>
> 	dev->speed = speed;
> 	dev->idle = 1;
>diff --git a/include/linux/i2c-omap.h b/include/linux/i2c-omap.h
>new file mode 100644
>index 0000000..1362fba
>--- /dev/null
>+++ b/include/linux/i2c-omap.h
>@@ -0,0 +1,9 @@
>+#ifndef __I2C_OMAP_H__
>+#define __I2C_OMAP_H__
>+
>+struct omap_i2c_bus_platform_data {
>+	u32		clkrate;
>+	void		(*set_mpu_wkup_lat)(struct device *dev, int set);
>+};
>+
>+#endif
>--
>1.5.4.3
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

