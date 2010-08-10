From: "Basak, Partha" <p-basak2@ti.com>
Subject: RE: [PATCH 01/13 v5] OMAP: GPIO: Modify init() in preparation for
 platform device implementation
Date: Tue, 10 Aug 2010 17:01:12 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301E80AC3C7@dbde02.ent.ti.com>
References: <1281098065-24177-1-git-send-email-charu@ti.com>
	<1281098065-24177-2-git-send-email-charu@ti.com>
 <878w4fh1hf.fsf@deeprootsystems.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C6553365@dbde02.ent.ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301E80AC12E@dbde02.ent.ti.com>
 <4C612DA9.7070002@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41713 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752252Ab0HJLbT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Aug 2010 07:31:19 -0400
In-Reply-To: <4C612DA9.7070002@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Varadarajan, Charulatha" <charu@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Syed Mohammed, Khasim" <khasim@ti.com>



> -----Original Message-----
> From: Cousson, Benoit
> Sent: Tuesday, August 10, 2010 4:15 PM
> To: Basak, Partha
> Cc: Varadarajan, Charulatha; Kevin Hilman; linux-omap@vger.kernel.org;
> paul@pwsan.com; Nayak, Rajendra; Syed Mohammed, Khasim
> Subject: Re: [PATCH 01/13 v5] OMAP: GPIO: Modify init() in preparation for
> platform device implementation
> 
> On 8/10/2010 9:20 AM, Basak, Partha wrote:
> >
> >> From: Varadarajan, Charulatha
> >> Sent: Tuesday, August 10, 2010 10:49 AM
> >>
> >>> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> >>> Sent: Tuesday, August 10, 2010 3:51 AM
> >>>
> >>> Charulatha V<charu@ti.com>  writes:
> >>>
> >>>> This is in prepartion for implementing GPIO as a platform device.
> >>>> gpio bank's base addresses are moved from gpio.c to plat/gpio.h.
> >>>>
> >>>> This patch also modifies omap_gpio_init() to make use of
> >>>> omap_gpio_chip_init() and omap_gpio_mod_init(). omap_gpio_mod_init()
> >>> does
> >>>> the module init by clearing the status register and initializing the
> >>>> GPIO control register. omap_gpio_chip_init() initializes the chip
> >>> request,
> >>>> free, get, set and other function pointers and sets the gpio irq
> >> handler.
> >>>>
> >>>> Signed-off-by: Charulatha V<charu@ti.com>
> >>>> Signed-off-by: Basak, Partha<p-basak2@ti.com>
> >>>
> >>> [...]
> >>>
> >>>> +static void omap_gpio_mod_init(struct gpio_bank *bank, int id)
> >>>> +{
> >>>> +	if (cpu_class_is_omap2()) {
> >>>> +		if (cpu_is_omap44xx()) {
> >>>> +			__raw_writel(0xffffffff, bank->base +
> >>>> +					OMAP4_GPIO_IRQSTATUSCLR0);
> >>>> +			__raw_writel(0x00000000, bank->base +
> >>>> +					 OMAP4_GPIO_DEBOUNCENABLE);
> >>>> +			/* Initialize interface clk ungated, module
> enabled */
> >>>> +			__raw_writel(0, bank->base + OMAP4_GPIO_CTRL);
> >>>> +		} else if (cpu_is_omap34xx()) {
> >>>> +			__raw_writel(0x00000000, bank->base +
> >>>> +					OMAP24XX_GPIO_IRQENABLE1);
> >>>> +			__raw_writel(0xffffffff, bank->base +
> >>>> +					OMAP24XX_GPIO_IRQSTATUS1);
> >>>> +			__raw_writel(0x00000000, bank->base +
> >>>> +					OMAP24XX_GPIO_DEBOUNCE_EN);
> >>>> +
> >>>> +			/* Initialize interface clk ungated, module
> enabled */
> >>>> +			__raw_writel(0, bank->base + OMAP24XX_GPIO_CTRL);
> >>>> +			/* Enable autoidle for the OCP interface */
> >>>> +			omap_writel(1<<  0, 0x48306814);
> >>>
> >>> This autoidle stuff should be removed in this series as setting this
> is
> >>> handled by the hwmod layer.
> >>
> >> Okay.
> >
> > This code is incorrectly setting the PRCM_SYSCONFIG(0x48306814) register
> inside GPIO module which is incorrect. Ideally it should be moved to
> generic code like prcm_setup_regs() inside PM44xx.c/PM34xx.c. Having said
> that, the reset value of PRCM_SYSCONFIG is 0x01, so it would be safe just
> to remove this.
> 
> That's weird, do you know where it come from? Maybe it is re-enable
> because someone disable it at some point?
> It is indeed a dirty hack, but it will be good to understand the
> rational, if any?
> 
> The code is from that commit: 5492fb1a ARM: OMAP: Add 3430 gpio support
> from Khasim Syed Mohammed (Added in Cc).
> 
> It seems to be a bad copy paste of the 2420 code (omap_writel(1<<  0,
> 0x48019010)). That one is indeed changing the GPIO SYSCONFIG.
> 
> 
> > Now, coming to setting of AutoIdle (in CM_AUTOIDLE_XXX registers), even
> though prcm_reg_ids are being populated, hwmod framework is not setting
> these anywhere, all CM_AutoIdle settings are being done one-time in side
> prcm_setup_regs().
> 
> In this case, Kevin was referring to the SYSCONFIG autoidle setting not
> the PRCM one. But the following point is still valid.
> 
> > Kevin, as you pointed out this needs to be done in the framework.
> 
> Yep, good point, it was indeed already suggested by the comment:
> 
> 	/*
> 	 * Enable interface clock autoidle for all modules.
> 	 * Note that in the long run this should be done by clockfw
> 	 */
> 
> Except that doing that in hwmod make more sense now. hwmod probably
> didn't exist at that time.
> 
> Everything is in place in the hwmod prcm struct to set this setting from
> the hwmod core code.
> 
> > Can we do it as part of enabling the slave clocks? How does the
> following look?
> >
> > static int _enable_clocks(struct omap_hwmod *oh)
> > {
> > 	int i;
> >
> > 	pr_debug("omap_hwmod: %s: enabling clocks\n", oh->name);
> >
> > 	if (oh->_clk)
> > 		clk_enable(oh->_clk);
> >
> > 	if (oh->slaves_cnt>  0) {
> > 		for (i = 0; i<  oh->slaves_cnt; i++) {
> > 			struct omap_hwmod_ocp_if *os = oh->slaves[i];
> > 			struct clk *c = os->_clk;
> >
> > 			if (c&&  (os->flags&  OCPIF_SWSUP_IDLE))
> > 				clk_enable(c);
> > 			else
> > 				/*TODO: Set CM_AutoIdle here*/
> > 		}
> > 	}
> >
> > 	/* The opt clocks are controlled by the device driver. */
> >
> > 	return 0;
> > }
> 
> It should be done only once, so it is better to do that at _setup time
> instead.
> Please note that this is an OMAP2&3 setting only. That bit does not
> exist anymore in OMAP4.
> 

We will put this as part of _setup. Also, we will remove this hard-coded setting from GPIO code. Aligned.

> Regards,
> Benoit
