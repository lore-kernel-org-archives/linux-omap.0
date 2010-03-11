From: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Subject: Re: [PATCH v2] [I2C-OMAP] Add support for 16-bit registers
Date: Thu, 11 Mar 2010 08:40:22 -0800
Message-ID: <878w9ydd6x.fsf@deeprootsystems.com>
References: <1260669242-29865-1-git-send-email-darkstar6262@gmail.com>
	<6cb013311001090947m2268833cv3784f469dc8b861d@mail.gmail.com>
	<20100109183321.GH2879@atomide.com>
	<6cb013311001091035x54321b3aqb814f476200980af@mail.gmail.com>
	<20100112012814.GK5055@atomide.com>
	<87k4tkf3ye.fsf@deeprootsystems.com>
	<20100310223000.GT2900@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100310223000.GT2900-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> (Tony Lindgren's message of "Wed\, 10 Mar 2010 14\:30\:00 -0800")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Cory Maccarrone <darkstar6262-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> writes:

> * Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org> [100310 10:01]:
>> Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> writes:
>> 
>> > * Cory Maccarrone <darkstar6262-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [100109 10:34]:
>> >> On Sat, Jan 9, 2010 at 10:33 AM, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:
>> >> >
>> >> > Let's plan on adding this into omap-testing branch next week so
>> >> > we can make sure things are OK for the other platforms.
>> >> >
>> >> > Then assuming no issues, let's ask Ben can queue it.
>> >> >
>> >> 
>> >> Excellent, thank you!
>> >
>> > Applied to omap-testing with the following fix. Can you please merge
>> > it into your original patch?
>> 
>> Unfortunately, Tony's additional fix did not make it into the version
>> that was merged to mainline, which results in a crash during
>> probe when using v2.6.34-rc1.
>> 
>> Ben, can you queue the fix below from Tony for -rc2?
>
> The original patch attached again below.
>
> Oops, did I maybe send a wrong patchwork link earlier to the
> patch?
>
> Anyways, for the future, considering how critical this driver is
> for all omaps.. And considering how badly this driver needs some
> updates done..
>
> How about we pile up the i2c-omap patches for testing into linux-omap
> branch first, then ask Ben to pull it around -rc6 after we've all
> acked and tested the changes?
>
> Ben does that sound OK to you?

Here's another one to add to omap-testing then.

This one has been submitted to linux-i2c a couple times and been in
the OMAP PM branch for a while.

Kevin

>From 639d6ce328663c0e6cb1623bc69bcb5d167db2f9 Mon Sep 17 00:00:00 2001
From: Kalle Jokiniemi <kalle.jokiniemi-sMOQStClEysAvxtiuMwx3w@public.gmane.org>
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

Cc: Moiz Sonasath <m-sonasath-l0cyMroinI0@public.gmane.org>
Cc: Jarkko Nikula <jhnikula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Cc: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Signed-off-by: Kalle Jokiniemi <kalle.jokiniemi-sMOQStClEysAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
---
 arch/arm/plat-omap/i2c.c      |   55 ++++++++++++++++++++++++++++++++---------
 drivers/i2c/busses/i2c-omap.c |   25 +++++++++++++++---
 include/linux/i2c-omap.h      |    9 ++++++
 3 files changed, 73 insertions(+), 16 deletions(-)
 create mode 100644 include/linux/i2c-omap.h

diff --git a/arch/arm/plat-omap/i2c.c b/arch/arm/plat-omap/i2c.c
index 624e262..36011a1 100644
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
@@ -70,19 +73,44 @@ static struct resource i2c_resources[][2] = {
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
+static void __init omap_set_i2c_constraint_func(
+				struct omap_i2c_bus_platform_data *pd)
+{
+	if (cpu_is_omap34xx())
+		pd->set_mpu_wkup_lat = omap_i2c_set_wfc_mpu_wkup_lat;
+	else
+		pd->set_mpu_wkup_lat = NULL;
+}
+
 static int __init omap_i2c_nr_ports(void)
 {
 	int ports = 0;
@@ -146,8 +174,8 @@ static int __init omap_i2c_bus_setup(char *str)
 	get_options(str, 3, ints);
 	if (ints[0] < 2 || ints[1] < 1 || ints[1] > ports)
 		return 0;
-	i2c_rate[ints[1] - 1] = ints[2];
-	i2c_rate[ints[1] - 1] |= OMAP_I2C_CMDLINE_SETUP;
+	i2c_pdata[ints[1] - 1].clkrate = ints[2];
+	i2c_pdata[ints[1] - 1].clkrate |= OMAP_I2C_CMDLINE_SETUP;
 
 	return 1;
 }
@@ -161,9 +189,10 @@ static int __init omap_register_i2c_bus_cmdline(void)
 {
 	int i, err = 0;
 
-	for (i = 0; i < ARRAY_SIZE(i2c_rate); i++)
-		if (i2c_rate[i] & OMAP_I2C_CMDLINE_SETUP) {
-			i2c_rate[i] &= ~OMAP_I2C_CMDLINE_SETUP;
+	for (i = 0; i < ARRAY_SIZE(i2c_pdata); i++)
+		if (i2c_pdata[i].clkrate & OMAP_I2C_CMDLINE_SETUP) {
+			i2c_pdata[i].clkrate &= ~OMAP_I2C_CMDLINE_SETUP;
+			omap_set_i2c_constraint_func(&i2c_pdata[i]);
 			err = omap_i2c_add_bus(i + 1);
 			if (err)
 				goto out;
@@ -197,9 +226,11 @@ int __init omap_register_i2c_bus(int bus_id, u32 clkrate,
 			return err;
 	}
 
-	if (!i2c_rate[bus_id - 1])
-		i2c_rate[bus_id - 1] = clkrate;
-	i2c_rate[bus_id - 1] &= ~OMAP_I2C_CMDLINE_SETUP;
+	if (!i2c_pdata[bus_id - 1].clkrate)
+		i2c_pdata[bus_id - 1].clkrate = clkrate;
+
+	omap_set_i2c_constraint_func(&i2c_pdata[bus_id - 1]);
+	i2c_pdata[bus_id - 1].clkrate &= ~OMAP_I2C_CMDLINE_SETUP;
 
 	return omap_i2c_add_bus(bus_id);
 }
diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index c7c2375..63a4a61 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -37,6 +37,7 @@
 #include <linux/platform_device.h>
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <linux/i2c-omap.h>
 
 /* I2C controller revisions */
 #define OMAP_I2C_REV_2			0x20
@@ -166,6 +167,9 @@ struct omap_i2c_dev {
 	struct clk		*fclk;		/* Functional clock */
 	struct completion	cmd_complete;
 	struct resource		*ioarea;
+	u32			latency;	/* maximum mpu wkup latency */
+	void			(*set_mpu_wkup_lat)(struct device *dev,
+						    int latency);
 	u32			speed;		/* Speed of bus in Khz */
 	u16			cmd_err;
 	u8			*buf;
@@ -538,8 +542,12 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
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
@@ -856,6 +864,7 @@ omap_i2c_probe(struct platform_device *pdev)
 	struct omap_i2c_dev	*dev;
 	struct i2c_adapter	*adap;
 	struct resource		*mem, *irq, *ioarea;
+	struct omap_i2c_bus_platform_data *pdata = pdev->dev.platform_data;
 	irq_handler_t isr;
 	int r;
 	u32 speed = 0;
@@ -885,10 +894,13 @@ omap_i2c_probe(struct platform_device *pdev)
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
@@ -923,6 +935,11 @@ omap_i2c_probe(struct platform_device *pdev)
 		 */
 		dev->fifo_size = (dev->fifo_size / 2);
 		dev->b_hw = 1; /* Enable hardware fixes */
+
+		/* calculate wakeup latency constraint for MPU */
+		if (dev->set_mpu_wkup_lat != NULL)
+			dev->latency = (1000000 * dev->fifo_size) /
+				       (1000 * speed / 8);
 	}
 
 	if (cpu_is_omap7xx())
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
