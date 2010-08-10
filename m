From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: RE: [PATCH 01/13 v5] OMAP: GPIO: Modify init() in preparation for
 platform device implementation
Date: Tue, 10 Aug 2010 10:48:48 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C6553365@dbde02.ent.ti.com>
References: <1281098065-24177-1-git-send-email-charu@ti.com>
	<1281098065-24177-2-git-send-email-charu@ti.com>
 <878w4fh1hf.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55316 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751537Ab0HJFS4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Aug 2010 01:18:56 -0400
In-Reply-To: <878w4fh1hf.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Basak, Partha" <p-basak2@ti.com>



> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> Sent: Tuesday, August 10, 2010 3:51 AM
> To: Varadarajan, Charulatha
> Cc: linux-omap@vger.kernel.org; paul@pwsan.com; Cousson, Benoit; Nayak,
> Rajendra; Basak, Partha
> Subject: Re: [PATCH 01/13 v5] OMAP: GPIO: Modify init() in preparation for
> platform device implementation
> 
> Charulatha V <charu@ti.com> writes:
> 
> > This is in prepartion for implementing GPIO as a platform device.
> > gpio bank's base addresses are moved from gpio.c to plat/gpio.h.
> >
> > This patch also modifies omap_gpio_init() to make use of
> > omap_gpio_chip_init() and omap_gpio_mod_init(). omap_gpio_mod_init()
> does
> > the module init by clearing the status register and initializing the
> > GPIO control register. omap_gpio_chip_init() initializes the chip
> request,
> > free, get, set and other function pointers and sets the gpio irq handler.
> >
> > Signed-off-by: Charulatha V <charu@ti.com>
> > Signed-off-by: Basak, Partha <p-basak2@ti.com>
> 
> [...]
> 
> > +static void omap_gpio_mod_init(struct gpio_bank *bank, int id)
> > +{
> > +	if (cpu_class_is_omap2()) {
> > +		if (cpu_is_omap44xx()) {
> > +			__raw_writel(0xffffffff, bank->base +
> > +					OMAP4_GPIO_IRQSTATUSCLR0);
> > +			__raw_writel(0x00000000, bank->base +
> > +					 OMAP4_GPIO_DEBOUNCENABLE);
> > +			/* Initialize interface clk ungated, module enabled */
> > +			__raw_writel(0, bank->base + OMAP4_GPIO_CTRL);
> > +		} else if (cpu_is_omap34xx()) {
> > +			__raw_writel(0x00000000, bank->base +
> > +					OMAP24XX_GPIO_IRQENABLE1);
> > +			__raw_writel(0xffffffff, bank->base +
> > +					OMAP24XX_GPIO_IRQSTATUS1);
> > +			__raw_writel(0x00000000, bank->base +
> > +					OMAP24XX_GPIO_DEBOUNCE_EN);
> > +
> > +			/* Initialize interface clk ungated, module enabled */
> > +			__raw_writel(0, bank->base + OMAP24XX_GPIO_CTRL);
> > +			/* Enable autoidle for the OCP interface */
> > +			omap_writel(1 << 0, 0x48306814);
> 
> This autoidle stuff should be removed in this series as setting this is
> handled by the hwmod layer.

Okay. 

> 
> > +		} else if (cpu_is_omap24xx()) {
> > +			static const u32 non_wakeup_gpios[] = {
> > +				0xe203ffc0, 0x08700040
> > +			};
> > +			if (id < ARRAY_SIZE(non_wakeup_gpios))
> > +				bank->non_wakeup_gpios = non_wakeup_gpios[id];
> > +
> > +			/* Enable autoidle for the OCP interface */
> > +			omap_writel(1 << 0, 0x48019010);
> 
> ditto

Okay.

> 
> > +		}
> 
> Kevin
