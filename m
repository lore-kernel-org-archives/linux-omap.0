From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH-V3 2/3] ARM: OMAP3+: clockdomain33xx: Add clockdomain
 data and respective operations
Date: Wed, 25 Apr 2012 07:30:50 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83E9FD30E@DBDE01.ent.ti.com>
References: <1333458578-23073-1-git-send-email-hvaibhav@ti.com>
 <1333458578-23073-3-git-send-email-hvaibhav@ti.com>
 <alpine.DEB.2.00.1204241725430.24864@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33092 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751739Ab2DYHa5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Apr 2012 03:30:57 -0400
In-Reply-To: <alpine.DEB.2.00.1204241725430.24864@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, "Mohammed, Afzal" <afzal@ti.com>, "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Wed, Apr 25, 2012 at 05:52:26, Paul Walmsley wrote:
> Hello Vaibhav, Afzal, Vaibhav,
> 
> A few questions while reviewing this patch:
> 
> On Tue, 3 Apr 2012, Vaibhav Hiremath wrote:
> 
> > AM33XX PRCM module consist of, various clockdomains, in all
> > total we have 18 clockdomains available, with following
> > controlling options,
> >    - NO Sleep: sleep transition can not be initiated,
> >    - SW Sleep: sw forced sleep transition,
> >    - SW Wakeup: sw forced wakeup transition,
> >    - HW Auto: transitions are based upon hw conditions.
> > 
> > This patch adds all available clockdomain data, respective
> > clockdomain operations for AM33XX family of device, and also
> > integrates it into existing OMAP framework.
> > 
> > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> > Signed-off-by: Afzal Mohammed <afzal@ti.com>
> > Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> 
> ...
> 
> > +static struct clockdomain l4ls_am33xx_clkdm = {
> > +	.name		= "l4ls_clkdm",
> > +	.pwrdm		= { .name = "per_pwrdm" },
> > +	.cm_inst	= AM33XX_CM_PER_MOD,
> > +	.clkdm_offs	= AM33XX_CM_PER_L4LS_CLKSTCTRL_OFFSET,
> > +	.clktrctrl_mask	= AM33XX_CLKTRCTRL_MASK,
> > +	.flags		= (CLKDM_CAN_SWSUP | CLKDM_NO_AUTODEPS),
> 
> It looks to me like we don't need the .clktrctrl_mask field, since 
> according to the clockdomains code, the CLKTRCTRL field is at the same bit 
> shift for each clockdomain.
> 

Yeah, we actually don't need it, probably I added for completeness.
I will remove it in next version.


> Also, since we're not defining any autodeps for the AM335x platform, we 
> shouldn't need the CLKDM_NO_AUTODEPS flag either?  Since no autodeps are 
> defined, the default will be to not set any autodeps.
> 

This is required to avoid few "pr_debug", if you don't provide it.
For example, without this flag set, you will get,

pr_debug("clockdomain: hardware cannot set/clear sleep "
		"dependency affecting %s from %s\n", clkdm1->name,
             clkdm2->name);

Refer to the file omap_hwmod.c, function, _enable(), the call sequence is,

_enable() => _add_initiator_dep() => clkdm_add_sleepdep() =>leads to warning



> Another question is about the CLKTRCTRL bitfields.  According to
> _AM335x ARM Cortex-A8 Microprocessors (MPUs) Technical Reference
> Manual_ Rev. D (SPRUH73D), most of the clockdomains support NO_SLEEP mode 
> (i.e., CLKTRCTRL = 0x0).  That means that technically, we should also set 
> the CLKDM_CAN_DISABLE_AUTO flag.  Unless the documentation is incorrect 
> here?  In another section (Table 8-9 "Clock Transition Mode Settings"), 
> it claims that CLKTRCTRL = 0 is not supported...
> 

It is not supported, and should be considered as documentation issue.

> Also, a question about the L4_WKUP clockdomain:
> 
> > +static struct clockdomain l4_wkup_am33xx_clkdm = {
> > +	.name		= "l4_wkup_clkdm",
> > +	.pwrdm		= { .name = "wkup_pwrdm" },
> > +	.cm_inst	= AM33XX_CM_WKUP_MOD,
> > +	.clkdm_offs	= AM33XX_CM_WKUP_CLKSTCTRL_OFFSET,
> > +	.clktrctrl_mask	= AM33XX_CLKTRCTRL_MASK,
> > +	.flags		= (CLKDM_CAN_SWSUP | CLKDM_NO_AUTODEPS),
> > +};
> 
> Table 8-89 "CM_WKUP_CLKSTCTRL Register Field Descriptions" of SPRUH73D 
> claims that this clockdomain supports hardware-supervised automatic 
> clockdomain transitions.  Again this conflicts with Table 8-9.  Is this a 
> documentation bug, or should we update the patch?
> 

Ditto, should be considered as doc issue. I have already raised all this 
documentation issues, and should get fixed.

Thanks,
Vaibhav
> 
> - Paul
> 

