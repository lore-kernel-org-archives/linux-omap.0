From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: RE: [PATCH 2/8] OMAP3:GPIO:Add support for early platform gpio
 device
Date: Thu, 1 Apr 2010 16:20:17 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C4C32941@dbde02.ent.ti.com>
References: <20100401093109.GG31200@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49328 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755148Ab0DAKuW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Apr 2010 06:50:22 -0400
In-Reply-To: <20100401093109.GG31200@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Nayak, Rajendra" <rnayak@ti.com>, "paul@pwsan.com" <paul@pwsan.com>



> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Thursday, April 01, 2010 3:01 PM
> To: Varadarajan, Charulatha
> Cc: linux-omap@vger.kernel.org; Nayak, Rajendra; paul@pwsan.com
> Subject: Re: [PATCH 2/8] OMAP3:GPIO:Add support for early platform gpio device
> 
> * Charulatha V <charu@ti.com> [100331 05:15]:
> > +
> > +int __init omap3_early_init_gpio(struct platform_device ***pdev)
> > +{
> > +	*pdev = omap3_gpio_early_dev;
> > +	return OMAP34XX_NR_GPIOS;
> > +}
> 
> ...
> 
> > +int __init omap3_gpio_dev_reg(void)
> > +{
> > +	if (cpu_is_omap34xx()) {
> > +		platform_device_register(&omap3_gpio1);
> > +		platform_device_register(&omap3_gpio2);
> > +		platform_device_register(&omap3_gpio3);
> > +		platform_device_register(&omap3_gpio4);
> > +		platform_device_register(&omap3_gpio5);
> > +		platform_device_register(&omap3_gpio6);
> > +	}
> > +	return 0;
> > +}
> > +arch_initcall(omap3_gpio_dev_reg);
> 
> Just call omap_gpio_init for each platform data.

I miss something here. Please provide more info.

> 
> Tony
