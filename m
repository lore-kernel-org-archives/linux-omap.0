From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCH v4 REPOST 13/20] gpio/omap: cleanup omap_gpio_mod_init
 function
Date: Wed, 20 Jul 2011 12:37:15 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB037C0C4CBE@dbde02.ent.ti.com>
References: <1310804152-9243-1-git-send-email-tarun.kanti@ti.com>
 <1310804152-9243-14-git-send-email-tarun.kanti@ti.com>
 <20110716182649.GA990@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46994 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750826Ab1GTHHo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Jul 2011 03:07:44 -0400
In-Reply-To: <20110716182649.GA990@google.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Todd Poynor <toddpoynor@google.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "tony@atomide.com" <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Varadarajan, Charulatha" <charu@ti.com>

[...]
> >  static int __init omap16xx_gpio_init(void)
> >  {
> >  	int i;
> > +	void __iomem *base;
> > +	struct resource *res;
> > +	struct platform_device *pdev;
> > +	struct omap_gpio_platform_data *pdata;
> >
> >  	if (!cpu_is_omap16xx())
> >  		return -EINVAL;
> >
> > -	for (i = 0; i < ARRAY_SIZE(omap16xx_gpio_dev); i++)
> > +	for (i = 0; i < ARRAY_SIZE(omap16xx_gpio_dev); i++) {
> > +		pdev = omap16xx_gpio_dev[i];
> > +		pdata = pdev->dev.platform_data;
> > +
> > +		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +		if (unlikely(!res)) {
> > +			dev_err(&pdev->dev, "Invalid mem resource.\n");
> > +			return -ENODEV;
> > +		}
> > +
> > +		base = ioremap(res->start, resource_size(res));
> > +		if (unlikely(!base)) {
> > +			dev_err(&pdev->dev, "ioremap failed.\n");
> > +			return -ENOMEM;
> > +		}
> 
> The value of base isn't saved anywhere, and the memory is not
> unmapped, looks like a virtual memory leak.  If the purpose of the
> ioremap is to perform the single write below then iounmap when done?
This is one time write only.
I will iounmap(base) after use. Thanks.

> The previous code to perform that write used a
> struct gpio_bank *bank->base ioremapped by omap_gpio_probe, but
> apparently omap16xx_gpio_init isn't called in that path.
Right.

> 
> > +
> > +		__raw_writel(0x0014, base + OMAP1610_GPIO_SYSCONFIG);
> 
> Suggest a symbol for the 0x14 value, or add a comment describing what
> this does.  (I realize the existing code has many naked constants.)
Sure.
--
Tarun
> 
> 
> 
> Todd

