From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 3/5] gpio/omap: Add DT support to GPIO driver
Date: Wed, 27 Feb 2013 17:16:09 -0600
Message-ID: <512E93B9.8020806@ti.com>
References: <1329321854-24490-1-git-send-email-b-cousson@ti.com> <1329321854-24490-4-git-send-email-b-cousson@ti.com> <4F44FA56.7020000@gmail.com> <4F44FC37.2000701@ti.com> <4F452484.5080503@gmail.com> <74CDBE0F657A3D45AFBB94109FB122FF17BD8BC6C1@HQMAIL01.nvidia.com> <4F47AD08.4030504@ti.com> <CAAwP0s0cB368R2mtbJpTZJreR-5GSRLfxC+8DJLo5nw3_OwBuA@mail.gmail.com> <512D39DA.7020306@ti.com> <512D3AB1.1080202@wwwdotorg.org> <512D3EC2.6050408@ti.com> <512D3FE6.1010300@wwwdotorg.org> <512D490B.70900@ti.com> <512D4FC4.2060505@wwwdotorg.org> <512D5C58.4090500@ti.com> <CAAwP0s3rbExrSf-W325uCPfMO=Zk9LefRP0VD4JC1tg_sxS_gQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60512 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758468Ab3B0XQT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Feb 2013 18:16:19 -0500
In-Reply-To: <CAAwP0s3rbExrSf-W325uCPfMO=Zk9LefRP0VD4JC1tg_sxS_gQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <martinez.javier@gmail.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Stephen Warren <swarren@nvidia.com>, Kevin Hilman <khilman@deeprootsystems.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linus Walleij <linus.walleij@linaro.org>, Grant Likely <grant.likely@secretlab.ca>


On 02/26/2013 09:57 PM, Javier Martinez Canillas wrote:

[snip]

> Something like that would definitely solve the GPIO request issue but
> we still have the issue that the current OMAP GPIO controller binding
> does not support #interrupt-cells = <2>.
> 
> So, we can't pass the trigger type and level flags for an IRQ-GPIO
> when using an GPIO controller as the interrupt-parent for a device
> node.
> 
> Do you have any comments on that issue?

Can you elaborate a bit more on why you say this is not supported?

I have been playing with this today on an omap board and if I set the
#interrupt-cells = <2>, then I do see that irq_domain_xlate_onetwocell()
is called and the irq number and flags read as expected. Following which
I then see it will call the omap_irq_type() to set type. So AFAICT it works.

Please note I do see that when the SMC driver calls request_irq() in
smc_drv_probe() it is also settings the trigger type to
IRQ_TYPE_EDGE_RISING (default). So if you are setting to low-level
sensitive in DT, then this is being overwritten. We could fix this by
setting SMC_IRQ_FLAGS to -1 for OMAP.

In general we do need to fix the gpio binding for omap to default to
#interrupt-cell = <2>, as this should work. However, before we can do
that we need to fix the issue of ensuring the gpio module is enabled if
being used as an interrupt source without having to call gpio_request()
first.

We should probably add the following patch as well to avoid any hangs if
the bank is not enabled, when omap_irq_type is called.

commit 5e298de564e09f5ca4148a9bc0ed5d16b4742f14
Author: Jon Hunter <jon-hunter@ti.com>
Date:   Wed Feb 27 17:14:11 2013 -0600

    gpio/omap: warn if gpio bank is not enabled on setting irq type

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index f1fbedb2..cbdc796 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -421,6 +421,9 @@ static int gpio_irq_type(struct irq_data *d,
unsigned type)
        int retval;
        unsigned long flags;

+       if (WARN_ON(!bank->mod_usage))
+               return -EINVAL;
+
 #ifdef CONFIG_ARCH_OMAP1
        if (d->irq > IH_MPUIO_BASE)
                gpio = OMAP_MPUIO(d->irq - IH_MPUIO_BASE);


Cheers
Jon


