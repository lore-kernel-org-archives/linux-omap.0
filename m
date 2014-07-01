From: Sekhar Nori <nsekhar@ti.com>
Subject: atmel_mxt_ts: defaulting irqflags to IRQF_TRIGGER_FALLING
Date: Tue, 1 Jul 2014 15:21:42 +0530
Message-ID: <53B284AE.3070302@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Sender: linux-input-owner@vger.kernel.org
To: Nick Dyer <nick.dyer@itdev.co.uk>
Cc: Stephen Warren <swarren@nvidia.com>, linux-input@vger.kernel.org, Linux OMAP List <linux-omap@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
List-Id: linux-omap@vger.kernel.org

Nick,

I have been using your for-next branch to base my development of 
touchscreen support on TI's DRA7x EVM. With the recent updates,
it has worked out great and once I got the configuration right,
it was just a question of adding DT data for the platform.

Now, there is one problem with Stephen's patch defaulting the irqflags 
to IRQF_TRIGGER_FALLING. The interrupt controller I am using (ARM GIC) 
does not seem to support that and the device fails to probe:

[    1.932798] genirq: Setting trigger mode 2 for irq 151 failed (gic_set_type+0x0/0xf0)
[    1.941340] atmel_mxt_ts 0-004a: Failed to register interrupt
[    1.947452] atmel_mxt_ts: probe of 0-004a failed with error -22

Attached patch does the trick for me:

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 71154c2..f2d3f72 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -3155,9 +3155,6 @@ static struct mxt_platform_data *mxt_parse_dt(struct i2c_client *client)
 	pdata->gpio_reset = of_get_named_gpio_flags(dev->of_node,
 		"atmel,reset-gpio", 0, NULL);
 
-	/* Default to this. Properties can be added to configure it later */
-	pdata->irqflags = IRQF_TRIGGER_FALLING;
-
 	of_property_read_string(dev->of_node, "atmel,cfg_name",
 				&pdata->cfg_name); 

Can you switch to leaving the platform to specify flags (at least for the DT case)?

Thanks,
Sekhar
