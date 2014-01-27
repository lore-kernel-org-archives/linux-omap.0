From: Christoph Fritz <chf.fritz@googlemail.com>
Subject: Re: [PATCH v2 4/5] ARM: OMAP2+: Add pdata quirk for sys_clkout2 for
 omap3 DBB056
Date: Mon, 27 Jan 2014 01:01:18 +0100
Message-ID: <20140127000118.GA30378@mars>
References: <1390417460-3134-1-git-send-email-chf.fritz@googlemail.com>
 <1390417460-3134-5-git-send-email-chf.fritz@googlemail.com>
 <52E01D01.2010709@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:33420 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753076AbaA0ABZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 26 Jan 2014 19:01:25 -0500
Content-Disposition: inline
In-Reply-To: <52E01D01.2010709@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Ulf Hansson <ulf.hansson@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Archit Taneja <archit@ti.com>, bcousson@baylibre.com, "Hans J. Koch" <hjk@hansjkoch.de>, Daniel Mack <zonque@gmail.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Tero Kristo <t-kristo@ti.com>

Hi Nishanth,

 thanks for reviewing this patch. Please see my comments below.

On Wed, Jan 22, 2014 at 01:33:21PM -0600, Nishanth Menon wrote:
> On 01/22/2014 01:04 PM, Christoph Fritz wrote:
> > Full device tree support for clock control is not yet accomplished. Until
> > then, configure the 24Mhz of sys_clkout2 to feed an USB-Hub here.
> > 
> > Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
> > ---
> >  arch/arm/mach-omap2/pdata-quirks.c |   37 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 37 insertions(+)
> > 
> > diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
> > index a58590f..9ef7ca8 100644
> > --- a/arch/arm/mach-omap2/pdata-quirks.c
> > +++ b/arch/arm/mach-omap2/pdata-quirks.c
> > @@ -171,6 +171,43 @@ static void __init am3517_evm_legacy_init(void)
> >  }
> >  static void __init omap3_dbb056_legacy_init(void)
> >  {
> > +	struct clk *clkout2;
> > +	struct clk *cm96fck;
> > +
> > +	/* Reparent clkout2 to 96M_FCK */
> > +	pr_info("a83x-quirk: Late Reparent clkout2 to 96M_FCK\n");
> what'd be a83x?

It's the computer-on-module name. Will get changed to __func__.

> > +	clkout2 = clk_get(NULL, "clkout2_src_ck");
> > +	if(clkout2 < 0) {
> > +		pr_err("a83x-quirk: couldn't get clkout2_src_ck\n");
> > +		return;
> > +	}
> > +	cm96fck = clk_get(NULL, "cm_96m_fck");
> > +	if(cm96fck < 0) {
> > +		pr_err("a83x-quirk: couldn't get cm_96m_fck\n");
> > +		return;
> > +	}
> > +	if(clk_set_parent(clkout2, cm96fck) < 0) {
> > +		pr_err("a83x-quirk: couldn't reparent clkout2_src_ck\n");
> > +		return;
> > +	}
> yep - we have bunch of similar code in drivers/clk/ti -> but we'd need
> a generic property to handle this.

This whole quirk of configuring sys_clkout2 in a platform file will
go away. Tero is planning to post some RFC patches to configure this
by DT.

> > +
> > +	/* Set clkout2 to 24MHz for internal usb hub*/
> > +	pr_info("a83x-quirk: Set clkout2 to 24MHz for internal usb hub\n");
> > +	clkout2 = clk_get(NULL, "sys_clkout2");
> > +	if(clkout2 < 0) {
> > +		pr_err("a83x-quirk: couldn't get sys_clkout2\n");
> > +		return;
> > +	}
> > +	if(clk_set_rate(clkout2, 24000000) < 0) {
> same here.
> > +		printk(KERN_ERR "board-omap3evm: couldn't set sys_clkout2 rate\n");
> "board-omap3evm:" copy paste?
> any reason why not pr_err?

will get fixed

> > +		return;
> > +	}
> > +	if(clk_prepare_enable(clkout2) < 0) {
> > +		pr_err("a83x-quirk: couldn't enable sys_clkout2\n");
> > +		return;
> > +	}
> > +
> > +	/* Initialize display */
> >  	omap3_dbb056_display_init_of();
> >  }
> >  #endif /* CONFIG_ARCH_OMAP3 */
> > 
> 
> looking at the coding style, I assume we'd missed running
> checkpatch.pl --strict?

Let me reroll this patch in a new v3 set.

Thanks
  -- Christoph
