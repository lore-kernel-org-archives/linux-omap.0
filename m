From: Nick Dyer <nick.dyer@itdev.co.uk>
Subject: Re: atmel_mxt_ts: defaulting irqflags to IRQF_TRIGGER_FALLING
Date: Thu, 03 Jul 2014 15:16:06 +0100
Message-ID: <53B565A6.9020306@itdev.co.uk>
References: <53B284AE.3070302@ti.com>	<5995217832cc40f5bcf132ac5c6c2546@HQMAIL105.nvidia.com>	<53B3E3A8.4070605@ti.com>	<53B3F2F2.90707@itdev.co.uk> <CAKdAkRTueVK8ynFR7AJeeJL7SPK60U0EHESeONqqoBF_vXJQxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <CAKdAkRTueVK8ynFR7AJeeJL7SPK60U0EHESeONqqoBF_vXJQxA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Sekhar Nori <nsekhar@ti.com>, Stephen Warren <swarren@nvidia.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Linux OMAP List <linux-omap@vger.kernel.org>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>
List-Id: linux-omap@vger.kernel.org

On 02/07/14 18:25, Dmitry Torokhov wrote:
> In this case board code should take care of setting up the interrupt
> properly and the driver should simply use 0 as flags in request_irq().
> By the way, doesn't generic DT infrastructure already allow specifying
> interrupt triggers and sets them up properly?

Yes. I've checked and tested this behaviour today. If you don't specify a
trigger type, then when you request the irq it trusts that the platform has
already set it up correctly:
http://lxr.free-electrons.com/source/kernel/irq/manage.c#L1208

Stephen: you should be able to set up the interrupt config in the device
tree. I believe this should be done by putting IRQ_TYPE_LEVEL_LOW or
IRQ_TYPE_EDGE_FALLING in the third field in the "interrupts" definition,
although I haven't a tegra DTS device to test on at the moment.

I've applied the patch below, which is basically what Sekhar had
originally, with a minor extra fix.

I've merged it into the appropriate parts of my for upstream series at
https://github.com/ndyer/linux/commits/for-next

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c
b/drivers/input/touchscree
index dc46100..15efb3b 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -1453,7 +1453,7 @@ static int mxt_check_retrigen(struct mxt_data *data)
        int error;
        int val;

-       if (data->pdata->irqflags & IRQF_TRIGGER_LOW)
+       if (irq_get_trigger_type(data->irq) & IRQF_TRIGGER_LOW)
                return 0;

        if (data->T18_address) {
@@ -3155,9 +3155,6 @@ static struct mxt_platform_data *mxt_parse_dt(struct
i2c_c
        pdata->gpio_reset = of_get_named_gpio_flags(dev->of_node,
                "atmel,reset-gpio", 0, NULL);

-       /* Default to this. Properties can be added to configure it later */
-       pdata->irqflags = IRQF_TRIGGER_FALLING;
-
        of_property_read_string(dev->of_node, "atmel,cfg_name",
                                &pdata->cfg_name);

