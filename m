From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH-V3 2/3] ARM: OMAP3+: clockdomain33xx: Add clockdomain
 data and respective operations
Date: Tue, 24 Apr 2012 18:22:26 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204241725430.24864@utopia.booyaka.com>
References: <1333458578-23073-1-git-send-email-hvaibhav@ti.com> <1333458578-23073-3-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47386 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752744Ab2DYAW1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Apr 2012 20:22:27 -0400
In-Reply-To: <1333458578-23073-3-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>, Afzal Mohammed <afzal@ti.com>, Vaibhav Bedia <vaibhav.bedia@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, khilman@ti.com, rnayak@ti.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org

Hello Vaibhav, Afzal, Vaibhav,

A few questions while reviewing this patch:

On Tue, 3 Apr 2012, Vaibhav Hiremath wrote:

> AM33XX PRCM module consist of, various clockdomains, in all
> total we have 18 clockdomains available, with following
> controlling options,
>    - NO Sleep: sleep transition can not be initiated,
>    - SW Sleep: sw forced sleep transition,
>    - SW Wakeup: sw forced wakeup transition,
>    - HW Auto: transitions are based upon hw conditions.
> 
> This patch adds all available clockdomain data, respective
> clockdomain operations for AM33XX family of device, and also
> integrates it into existing OMAP framework.
> 
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> Signed-off-by: Afzal Mohammed <afzal@ti.com>
> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>

...

> +static struct clockdomain l4ls_am33xx_clkdm = {
> +	.name		= "l4ls_clkdm",
> +	.pwrdm		= { .name = "per_pwrdm" },
> +	.cm_inst	= AM33XX_CM_PER_MOD,
> +	.clkdm_offs	= AM33XX_CM_PER_L4LS_CLKSTCTRL_OFFSET,
> +	.clktrctrl_mask	= AM33XX_CLKTRCTRL_MASK,
> +	.flags		= (CLKDM_CAN_SWSUP | CLKDM_NO_AUTODEPS),

It looks to me like we don't need the .clktrctrl_mask field, since 
according to the clockdomains code, the CLKTRCTRL field is at the same bit 
shift for each clockdomain.

Also, since we're not defining any autodeps for the AM335x platform, we 
shouldn't need the CLKDM_NO_AUTODEPS flag either?  Since no autodeps are 
defined, the default will be to not set any autodeps.

Another question is about the CLKTRCTRL bitfields.  According to
_AM335x ARM Cortex-A8 Microprocessors (MPUs) Technical Reference
Manual_ Rev. D (SPRUH73D), most of the clockdomains support NO_SLEEP mode 
(i.e., CLKTRCTRL = 0x0).  That means that technically, we should also set 
the CLKDM_CAN_DISABLE_AUTO flag.  Unless the documentation is incorrect 
here?  In another section (Table 8-9 "Clock Transition Mode Settings"), 
it claims that CLKTRCTRL = 0 is not supported...

Also, a question about the L4_WKUP clockdomain:

> +static struct clockdomain l4_wkup_am33xx_clkdm = {
> +	.name		= "l4_wkup_clkdm",
> +	.pwrdm		= { .name = "wkup_pwrdm" },
> +	.cm_inst	= AM33XX_CM_WKUP_MOD,
> +	.clkdm_offs	= AM33XX_CM_WKUP_CLKSTCTRL_OFFSET,
> +	.clktrctrl_mask	= AM33XX_CLKTRCTRL_MASK,
> +	.flags		= (CLKDM_CAN_SWSUP | CLKDM_NO_AUTODEPS),
> +};

Table 8-89 "CM_WKUP_CLKSTCTRL Register Field Descriptions" of SPRUH73D 
claims that this clockdomain supports hardware-supervised automatic 
clockdomain transitions.  Again this conflicts with Table 8-9.  Is this a 
documentation bug, or should we update the patch?


- Paul
