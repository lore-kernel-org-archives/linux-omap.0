From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: RE: [PATCH 09/11] OMAP: GPIO: Introduce support for OMAP2PLUS chip
 GPIO init
Date: Wed, 19 May 2010 12:56:05 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C5666369@dbde02.ent.ti.com>
References: <1274194260-16401-1-git-send-email-charu@ti.com>
 <1274194260-16401-2-git-send-email-charu@ti.com>
 <1274194260-16401-3-git-send-email-charu@ti.com>
 <1274194260-16401-4-git-send-email-charu@ti.com>
 <1274194260-16401-5-git-send-email-charu@ti.com>
 <1274194260-16401-6-git-send-email-charu@ti.com>
 <1274194260-16401-7-git-send-email-charu@ti.com>
 <1274194260-16401-8-git-send-email-charu@ti.com>
 <1274194260-16401-9-git-send-email-charu@ti.com>
 <1274194260-16401-10-git-send-email-charu@ti.com>
 <20100518234649.GW5818@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44495 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753650Ab0ESH0M convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 May 2010 03:26:12 -0400
In-Reply-To: <20100518234649.GW5818@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Nayak, Rajendra" <rnayak@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>



> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Wednesday, May 19, 2010 5:17 AM
> To: Varadarajan, Charulatha
> Cc: linux-omap@vger.kernel.org; Nayak, Rajendra; paul@pwsan.com;
> khilman@deeprootsystems.com
> Subject: Re: [PATCH 09/11] OMAP: GPIO: Introduce support for OMAP2PLUS chip GPIO
> init
> 
> * Charulatha V <charu@ti.com> [100518 07:44]:
> > This patch adds support for handling GPIO as a HWMOD FW adapted
> > platform device for OMAP2PLUS chips.
> >
> > Signed-off-by: Charulatha V <charu@ti.com>

> > +
> > +/*
> > + * gpio_init needs to be done before
> > + * machine_init functions access gpio APIs.
> > + * Hence gpio_init is a postcore_initcall.
> > + */

Need for postcore_initcall is mentioned here as a common comment
for all SoCs in the beginning of the file

> > +#ifdef CONFIG_ARCH_OMAP2
> > +static int __init omap242x_gpio_init(void)
> > +{	if (!cpu_is_omap2420())
> > +		return -EINVAL;
> > +
> > +	return gpio_init(METHOD_GPIO_24XX);
> > +}
> > +postcore_initcall(omap242x_gpio_init);
> > +
> > +static int __init omap243x_gpio_init(void)
> > +{
> > +	if (!cpu_is_omap2430())
> > +		return -EINVAL;
> > +
> > +	return gpio_init(METHOD_GPIO_24XX);
> > +}
> > +postcore_initcall(omap243x_gpio_init);
> > +#endif
> > +
> > +#ifdef CONFIG_ARCH_OMAP3
> > +static int __init omap3xxx_gpio_init(void)
> > +{
> > +	if (!cpu_is_omap34xx())
> > +		return -EINVAL;
> > +
> > +	return gpio_init(METHOD_GPIO_24XX);
> > +}
> > +postcore_initcall(omap3xxx_gpio_init);
> > +#endif
> > +
> > +#ifdef CONFIG_ARCH_OMAP4
> > +static int __init omap44xx_gpio_init(void)
> > +{
> > +	if (!cpu_is_omap44xx())
> > +		return -EINVAL;
> > +
> > +	return gpio_init(METHOD_GPIO_44XX);
> > +}
> > +postcore_initcall(omap44xx_gpio_init);
> > +#endif
> 
> What was the reason again for using postcore_initcall? You mentioned
> it somewhere, but I forgot already.. Maybe put that into the patch
> description too?

Okay. I will add it in this patch description too.

> 
> Regards,
> 
> Tony
