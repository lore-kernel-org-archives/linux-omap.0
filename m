From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3] OMAP3: introduce OMAP3630
Date: Fri, 9 Oct 2009 10:53:15 -0700
Message-ID: <20091009175314.GI25892@atomide.com>
References: <1255045627-23405-1-git-send-email-nm@ti.com> <A24693684029E5489D1D202277BE89444CC6C59E@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:63380 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760531AbZJIRyB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Oct 2009 13:54:01 -0400
Content-Disposition: inline
In-Reply-To: <A24693684029E5489D1D202277BE89444CC6C59E@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Cc: "Menon, Nishanth" <nm@ti.com>, linux-omap <linux-omap@vger.kernel.org>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, "Pandita, Vikram" <vikram.pandita@ti.com>, "Pais, Allen" <allen.pais@ti.com>, "Gadiyar, Anand" <gadiyar@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Felipe Balbi <felipe.balbi@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Premi, Sanjeev" <premi@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>

* Aguirre Rodriguez, Sergio Alberto <saaguirre@ti.com> [091009 06:55]:
> Nishanth, 
> 
> From: Menon, Nishanth 
> Sent: Thursday, October 08, 2009 6:47 PM
> 
> <snip>
> 
> > diff --git a/arch/arm/plat-omap/include/mach/cpu.h 
> > b/arch/arm/plat-omap/include/mach/cpu.h
> > index 431fec4..af1080f 100644
> > --- a/arch/arm/plat-omap/include/mach/cpu.h
> > +++ b/arch/arm/plat-omap/include/mach/cpu.h
> > @@ -383,6 +383,12 @@ IS_OMAP_TYPE(3430, 0x3430)
> >  #define OMAP3430_REV_ES2_1	0x34302034
> >  #define OMAP3430_REV_ES3_0	0x34303034
> >  #define OMAP3430_REV_ES3_1	0x34304034
> > +/* NOTE: Add 36xx series below
> > + * If additional 34xx series are added, OMAP3430_REV_ESXXXX can be
> > + * added above the 3630 defines and series renumbered to ensure
> > + * rev() > checks to work
> > + */
> > +#define OMAP3630_REV_ES1_0	0x34305034
> 
> Just for the sake of curiosity...
> 
> Why not defining 3630 like this?
> 
> #define OMAP3630_REV_ES1_0	0x36301034
> 
> Sorry if i'm asking something dumb.

Because it's still considered 34xx class chip with
some extra features. It compiles with the same settings,
and uses the same kernel code. So from kernel point of
view we can treat it as 34xx.

Regards,

Tony

