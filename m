From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1a/4] mfd: twl4030-power: Add generic reset configuration
Date: Mon, 28 Apr 2014 09:01:09 -0700
Message-ID: <20140428160108.GK20807@atomide.com>
References: <1398300030-7386-1-git-send-email-tony@atomide.com>
 <20140424004955.GG6053@atomide.com>
 <20140428113721.GU21279@lee--X1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:14173 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932792AbaD1QBR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Apr 2014 12:01:17 -0400
Content-Disposition: inline
In-Reply-To: <20140428113721.GU21279@lee--X1>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>, Robert Nelson <robertcnelson@gmail.com>, Peter De Schrijver <pdeschrijver@nvidia.com>, Samuel Ortiz <sameo@linux.intel.com>

* Lee Jones <lee.jones@linaro.org> [140428 04:37]:
> > The twl4030 PMIC needs to be configured properly for things like
> > warm reset and deeper idle states so the PMIC manages the regulators
> > properly based on the hardware triggers from the SoC.
> > 
> > For example, when rebooting an OMAP3530 at 125 MHz, it hangs.
> > With this patch, TWL4030 will be reset when a warm reset occures.
> > This way the OMAP3530 does not hang on reboot.
> > 
> > Let's use this as the default when compatible = "ti,twl4030-power".
> > Other more complicated configurations can be added to the driver
> > based on other compatible flags.
> > 
> > Based on earlier patch by Matthias Brugger <matthias.bgg@gmail.com>:
> > 
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2013-January/144161.html
> > 
> > For more information about twl4030 configuration for the
> > "power scripts" see:
> > 
> > http://www.omappedia.com/wiki/TWL4030_power_scripts
> > 
> > Cc: Matthias Brugger <matthias.bgg@gmail.com>
> > Cc: Robert Nelson <robertcnelson@gmail.com>
> > Cc: Peter De Schrijver <pdeschrijver@nvidia.com>
> > Cc: Samuel Ortiz <sameo@linux.intel.com>
> > Cc: Lee Jones <lee.jones@linaro.org>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > 
> > ---
> > 
> > Sorry this got accidentally left out, should be the first patch
> > in the series.
> > 
> > diff --git a/Documentation/devicetree/bindings/mfd/twl4030-power.txt b/Documentation/devicetree/bindings/mfd/twl4030-power.txt
> > index 8e15ec3..b906116 100644
> > --- a/Documentation/devicetree/bindings/mfd/twl4030-power.txt
> > +++ b/Documentation/devicetree/bindings/mfd/twl4030-power.txt
> > @@ -5,7 +5,12 @@ to control the power resources, including power scripts. For now, the
> >  binding only supports the complete shutdown of the system after poweroff.
> >  
> >  Required properties:
> > -- compatible : must be "ti,twl4030-power"
> > +- compatible : must be one of the following
> > +	"ti,twl4030-power"
> > +	"ti,twl4030-power-reset"
> > +
> 
> I think it'll be sensible to wait for a DT Ack for this kind of
> change.

Sure. This could also be board specific, for example something like
ti,twl4030-power-n900, ti,twl4030-power-panda-es and so on. But
I think we can get away with just a few generic configurations.
 
> > +#ifdef CONFIG_OF
> > +
> > +/* Generic warm reset configuration for omap3 */
> > +
> > +static struct twl4030_ins omap3_wrst_seq[] = {
> > +	{ MSG_SINGULAR(DEV_GRP_NULL, 0x1b, RES_STATE_OFF), 2 },
> > +	{ MSG_SINGULAR(DEV_GRP_P1, 0xf, RES_STATE_WRST), 15 },
> > +	{ MSG_SINGULAR(DEV_GRP_P1, 0x10, RES_STATE_WRST), 15 },
> > +	{ MSG_SINGULAR(DEV_GRP_P1, 0x7, RES_STATE_WRST), 0x60 },
> > +	{ MSG_SINGULAR(DEV_GRP_P1, 0x19, RES_STATE_ACTIVE), 2 },
> > +	{ MSG_SINGULAR(DEV_GRP_NULL, 0x1b, RES_STATE_ACTIVE), 2 },
> > +};
> 
> Nit: I'd prefer the number formatting to be unified here i.e. all in
> the same base, all <0x10 with leading zero.

Thanks will check those.
  
> > +static struct twl4030_script omap3_wrst_script = {
> > +	.script	= omap3_wrst_seq,
> > +	.size	= ARRAY_SIZE(omap3_wrst_seq),
> > +	.flags	= TWL4030_WRST_SCRIPT,
> > +};
> > +
> > +static struct twl4030_script *omap3_reset_scripts[] = {
> > +	&omap3_wrst_script,
> > +};
> > +
> > +static struct twl4030_resconfig omap3_rconfig[] = {
> > +	{ .resource = RES_HFCLKOUT, .devgroup = DEV_GRP_P3, .type = -1,
> > +	  .type2 = -1 },
> > +	{ .resource = RES_VDD1, .devgroup = DEV_GRP_P1, .type = -1,
> > +	  .type2 = -1 },
> > +	{ .resource = RES_VDD2, .devgroup = DEV_GRP_P1, .type = -1,
> > +	  .type2 = -1 },
> > +	{ 0, 0},
> > +};
> 
> Nit: May be just my OCD, but this looks a little messy. Perhaps a
> simple MACRO might tidy things up, although that seems a little
> over-kill for such a small sturct[]. At the very least least please
> even up the brackets in the sentinel.

Yeah I was thinking about that too, but from configuring things
point of view it's essential to see what each entry is doing.
Having a macro with lots of parameters would make it a bit hard
to read the actual configuration. The macro would be something
like for the above:

RCONFIG(RES_HFCLKOUT, DEV_GRP_P3, -1, -1, 0, 0);
RCONFIG(RES_VDD1, DEV_GRP_P1, -1, -1, 0, 0);
RCONFIG(RES_VDD2, DEV_GRP_P1, -1, -1, 0, 0);

and something like this for other entries:

RCONFIG(RES_VAUX1, DEV_GRP_NULL, 0, 0, TWL_REMAP_OFF, TWL_REMAP_SLEEP); 

Personally I think it actually makes it harder to figure out what
is getting configured for the twl4030 as then it does not relate
to the documentation any longer, but I'm fine doing that if people
prefer macros here. Using macros could also be done later without
as it's all private to the driver.
 
> /me goes to organise his soup tins into alphabetical order.

I think using macros is a good comment, I always found the twl4030
configuration confusing. So if anybody has good macro ideas, I'm
open to it for sure. In this it's more like adding custom labels
to soup tins about their list of ingredients instead of sorting
the tins :) And it does not make the contents taste much better..

Regards,

Tony
