From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 2/6] i2c-omap: add mpu wake up latency constraint in i2c
Date: Tue, 11 May 2010 11:35:08 -0700
Message-ID: <20100511183508.15596.31988.stgit@baageli.muru.com>
References: <20100511182854.15596.56293.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100511182854.15596.56293.stgit-XB442sTQ5VIxQTnqJstS8Q@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
Cc: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Kalle Jokiniemi <kalle.jokiniemi-sMOQStClEysAvxtiuMwx3w@public.gmane.org>, Jarkko Nikula <jhnikula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Moiz Sonasath <m-sonasath-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Kalle Jokiniemi <kalle.jokiniemi-sMOQStClEysAvxtiuMwx3w@public.gmane.org>

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

Updates by Kevin as requested by Tony:

- Remove omap_set_i2c_constraint_func() in favor of conditionally
  adding the flag in omap_i2c_add_bus() in order to keep all the OMAP
  conditional checking in a single location.
- Update set_mpu_wkup_lat prototypes to match OMAP PM layer so
  OMAP PM function can be used directly in pdata.

Cc: Moiz Sonasath <m-sonasath-l0cyMroinI0@public.gmane.org>
Cc: Jarkko Nikula <jhnikula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Cc: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Signed-off-by: Kalle Jokiniemi <kalle.jokiniemi-sMOQStClEysAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 arch/arm/plat-omap/i2c.c      |   39 +++++++++++++++++++++++++++------------
 drivers/i2c/busses/i2c-omap.c |   24 ++++++++++++++++++++----
 include/linux/i2c-omap.h      |    9 +++++++++
 3 files changed, 56 insertions(+), 16 deletions(-)
 create mode 100644 include/linux/i2c-omap.h

diff --git a/arch/arm/plat-omap/i2c.c b/arch/arm/plat-omap/i2c.c
index 624e262..f044b59 100644
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
@@ -70,14 +73,14 @@ static struct resource i2c_resources[][2] = {
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
 
@@ -100,10 +103,12 @@ static int __init omap_i2c_nr_ports(void)
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
@@ -123,6 +128,15 @@ static int __init omap_i2c_add_bus(int bus_id)
 	if (cpu_class_is_omap2())
 		omap2_i2c_mux_pins(bus_id);
 
+	/*
+	 * When waiting for completion of a i2c transfer, we need to
+	 * set a wake up latency constraint for the MPU. This is to
+	 * ensure quick enough wakeup from idle, when transfer
+	 * completes.
+	 */
+	if (cpu_is_omap34xx())
+		pd->set_mpu_wkup_lat = omap_pm_set_max_mpu_wakeup_lat;
+
 	return platform_device_register(pdev);
 }
 
@@ -146,8 +160,8 @@ static int __init omap_i2c_bus_setup(char *str)
 	get_options(str, 3, ints);
 	if (ints[0] < 2 || ints[1] < 1 || ints[1] > ports)
 		return 0;
-	i2c_rate[ints[1] - 1] = ints[2];
-	i2c_rate[ints[1] - 1] |= OMAP_I2C_CMDLINE_SETUP;
+	i2c_pdata[ints[1] - 1].clkrate = ints[2];
+	i2c_pdata[ints[1] - 1].clkrate |= OMAP_I2C_CMDLINE_SETUP;
 
 	return 1;
 }
@@ -161,9 +175,9 @@ static int __init omap_register_i2c_bus_cmdline(void)
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
@@ -197,9 +211,10 @@ int __init omap_register_i2c_bus(int bus_id, u32 clkrate,
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
index 46111ff..42c0b91 100644
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
+						    long latency);
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
@@ -1011,6 +1023,10 @@ omap_i2c_probe(struct platform_device *pdev)
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
index 0000000..78ebf50
--- /dev/null
+++ b/include/linux/i2c-omap.h
@@ -0,0 +1,9 @@
+#ifndef __I2C_OMAP_H__
+#define __I2C_OMAP_H__
+
+struct omap_i2c_bus_platform_data {
+	u32		clkrate;
+	void		(*set_mpu_wkup_lat)(struct device *dev, long set);
+};
+
+#endif
