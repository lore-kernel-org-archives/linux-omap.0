From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: Re: [PATCH 5/8] board-rx51-peripherals: split vaux3 and vmmc2
 supplies
Date: Fri, 9 Oct 2009 09:45:29 +0300
Message-ID: <20091009064529.GD6616@esdhcp037198.research.nokia.com>
References: <1255003137-1034-1-git-send-email-eduardo.valentin@nokia.com>
 <1255003137-1034-6-git-send-email-eduardo.valentin@nokia.com>
 <20091008132109.GD29176@rakim.wolfsonmicro.main>
Reply-To: eduardo.valentin@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:50500 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752917AbZJIGrF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Oct 2009 02:47:05 -0400
Content-Disposition: inline
In-Reply-To: <20091008132109.GD29176@rakim.wolfsonmicro.main>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, ext Tony Lindgren <tony@atomide.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, Jarkko Nikula <jhnikula@gmail.com>, Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>

On Thu, Oct 08, 2009 at 03:21:10PM +0200, Mark Brown wrote:
> On Thu, Oct 08, 2009 at 02:58:54PM +0300, Eduardo Valentin wrote:
> > From: Eduardo Valentin <eduardo.valentin@nokia.com>
> 
> > Use separated supplies for vaux3 and vmmc2.
> 
> > Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
> 
> > +static struct regulator_consumer_supply rx51_vaux3_supply = {
> > +	.supply			= "vmmc",
> > +};
> > +
> 
> I'd expect all these supplies to have devices associated with them (see
> below)...
> 
> >  static struct regulator_consumer_supply rx51_vmmc2_supply = {
> >  	.supply			= "vmmc",
> >  };
> > @@ -184,7 +188,7 @@ static struct regulator_init_data rx51_vaux3_mmc = {
> >  					| REGULATOR_CHANGE_STATUS,
> >  	},
> >  	.num_consumer_supplies	= 1,
> > -	.consumer_supplies	= &rx51_vmmc2_supply,
> > +	.consumer_supplies	= &rx51_vaux3_supply,
> >  };
> 
> I may have missed it but I don't see rx51_vmmc2_supply added back
> anywhere in the patch?

yes. That's because this patch is just to split then. As you can see
in current code, this structure, rx51_vmmc2_supply, is actually used
by rx51_vaux3_mmc and rx51_vmmc2. So the idea is to have separated
supplies for each one. This patch just splits then. Patch 0006 of this
series adds usage of rx51_vmmc2_supply.

> 
> >  static struct regulator_init_data rx51_vaux4 = {
> > @@ -266,7 +270,7 @@ static int rx51_twlgpio_setup(struct device *dev, unsigned gpio, unsigned n)
> >  	/* set up MMC adapters, linking their regulators to them */
> >  	twl4030_mmc_init(mmc);
> >  	rx51_vmmc1_supply.dev = mmc[0].dev;
> > -	rx51_vmmc2_supply.dev = mmc[1].dev;
> > +	rx51_vaux3_supply.dev = mmc[1].dev;
> 
> ...using dev_name rather than dev should avoid the need to do this at
> runtime.


I see your point. As mentioned above, this patch is just a split.
I just added rx51_vaux3_supply to be owned by rx51_vaux3_mmc. And
let the code behavior as it was before.

Maybe your proposal must be sent into a separated patch/patch series (?).

-- 
Eduardo Valentin
