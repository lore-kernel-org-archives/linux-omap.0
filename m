From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH 2/3 v4] musb: add musb support for AM35x
Date: Wed, 29 Sep 2010 18:00:13 +0200
Message-ID: <4CA3628D.20407@compulab.co.il>
References: <1285764321-13934-1-git-send-email-ajay.gupta@ti.com> <1285764321-13934-2-git-send-email-ajay.gupta@ti.com> <4CA35B3A.4090707@compulab.co.il> <19F8576C6E063C45BE387C64729E739404A9D8AB99@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:46790 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753049Ab0I2QAW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Sep 2010 12:00:22 -0400
In-Reply-To: <19F8576C6E063C45BE387C64729E739404A9D8AB99@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Balbi, Felipe" <balbi@ti.com>

 Hi,

Already replied to Sergei on the comments below,
so please see the answer in my reply to Sergei.

On 09/29/10 17:46, Gupta, Ajay Kumar wrote:
> Hi,
>
> [...]
>>> +	devconf2 &= ~CONF2_OTGMODE;
>>> +	switch (musb_mode) {
>>> +#ifdef	CONFIG_USB_MUSB_OTG
>>> +	case MUSB_OTG:		/* Don't override the VBUS/ID comparators */
>>> +		devconf2 |= CONF2_NO_OVERRIDE;
>> This does nothing, can be removed...
> Yes, but it's good to have it from code readability perspective.
>
> I can remove it but let's get Felipe's opinion on this.
>
> [...] 
>>> +	if (musb->set_clock)
>>> +		musb->set_clock(musb->clock, 0);
>>> +	else
>>> +		clk_disable(musb->clock);
>>> +
>>> +	otg_fck = clk_get(musb->controller, "fck");
>>> +	if (IS_ERR(otg_fck)) {
>>> +		DBG(2, "clk_get() failed for otg_fck.\n");
>>> +	} else {
>>> +		clk_put(otg_fck);
>>> +		clk_put(otg_fck);
>>> +		clk_disable(otg_fck);
>> I think the order should be:
>> clk_disable(...);
>> clk_put(...);
> Again I would wait for Felipe's opinion on this ordering. BTW there
> Are codes on musb_core.c where clk_put is done before clk_disable().
>
>>> And of course, it should be put only once... ;)
> No. clk_put() needs to be done twice as clk_get() is called two times;
> one in musb_platform_init() and other in current function musb_platform_exit.
>
> Other solution could be to save otg_fck in some static variable as
> Sergei suggested.
>
> Thanks,
> Ajay
> [...]
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

-- 
Regards,
Igor.

