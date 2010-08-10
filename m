From: "Basak, Partha" <p-basak2@ti.com>
Subject: RE: [PATCH 10/13 v5] OMAP: GPIO: Implement GPIO as a platform device
Date: Tue, 10 Aug 2010 17:23:39 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301E80AC400@dbde02.ent.ti.com>
References: <1281098065-24177-1-git-send-email-charu@ti.com>
	<1281098065-24177-2-git-send-email-charu@ti.com>
	<1281098065-24177-3-git-send-email-charu@ti.com>
	<1281098065-24177-4-git-send-email-charu@ti.com>
	<1281098065-24177-5-git-send-email-charu@ti.com>
	<1281098065-24177-6-git-send-email-charu@ti.com>
	<1281098065-24177-7-git-send-email-charu@ti.com>
	<1281098065-24177-8-git-send-email-charu@ti.com>
	<1281098065-24177-9-git-send-email-charu@ti.com>
	<1281098065-24177-10-git-send-email-charu@ti.com>
	<1281098065-24177-11-git-send-email-charu@ti.com>
 <878w4ffkth.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33654 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756686Ab0HJLxr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Aug 2010 07:53:47 -0400
In-Reply-To: <878w4ffkth.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, "Varadarajan, Charulatha" <charu@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>



> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> Sent: Tuesday, August 10, 2010 4:36 AM
> To: Varadarajan, Charulatha
> Cc: linux-omap@vger.kernel.org; paul@pwsan.com; Cousson, Benoit; Nayak,
> Rajendra; Basak, Partha
> Subject: Re: [PATCH 10/13 v5] OMAP: GPIO: Implement GPIO as a platform
> device
> 
> Charulatha V <charu@ti.com> writes:
> 
> > @@ -650,21 +511,28 @@ static void _set_gpio_debounce(struct gpio_bank
> *bank, unsigned gpio,
> >  	__raw_writel(debounce, reg);
> >
> >  	reg = bank->base;
> > -	if (cpu_is_omap44xx())
> > +	if (bank->method == METHOD_GPIO_44XX)
> >  		reg += OMAP4_GPIO_DEBOUNCENABLE;
> >  	else
> >  		reg += OMAP24XX_GPIO_DEBOUNCE_EN;
> >
> >  	val = __raw_readl(reg);
> >
> > +	if (!bank->dbck) {
> > +		struct platform_device *pdev = to_platform_device(bank->dev);
> > +		struct omap_device *odev = to_omap_device(pdev);
> 
> insert empty line
> 
> > +		if (odev->hwmods[0]->opt_clks->_clk)
> > +			bank->dbck = odev->hwmods[0]->opt_clks->_clk;


This is not correct always as opt_clks points to an array of optional clocks 
which can have more than one element.
The correct approach would be to scan through the list of optional clocks and pick up the one with role === "dbclk".
> 
> As was discussed in Bangalore, drivers should have no knowledge of hwmod
> internals.
> 
> Instead, please propose an API to hwmod for getting the optional
> clock(s), or possibly cleaner, an API to directly enable/disable
> optional clocks for an omap_device.

As per our discussion with Paul & you during workshop, I believe, optional clock control should be done using clock APIs. So, I would go by your suggestion 1 of exposing an API to expose the optional clocks in the hwmod, something like:
struct omap_hwmod_opt_clk	* omap_hwmod_get_opt_clks(struct omap_hwmod *oh);
If agreed, Charu will send updated patch.

> 
> Kevin
> 
> > +		if (IS_ERR(bank->dbck))
> > +			dev_err(bank->dev, "Could not get gpio dbck\n");
> > +	}
> > +
