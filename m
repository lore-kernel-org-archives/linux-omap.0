From: "Hald, Ulrik Bech" <ubh@ti.com>
Subject: RE: [PATCH 1/1] OMAP3:Re-introduce omap_type()
Date: Mon, 15 Jun 2009 15:04:38 +0200
Message-ID: <00695C9C8F8B4448856F48142B4AA201BD868097@dnce02.ent.ti.com>
References: <1244840311-11809-1-git-send-email-ubh@ti.com>
 <874oulayou.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52933 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752219AbZFONEr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Jun 2009 09:04:47 -0400
In-Reply-To: <874oulayou.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> Sent: Friday, June 12, 2009 5:13 PM
> To: Hald, Ulrik Bech
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH 1/1] OMAP3:Re-introduce omap_type()
> 
> Ulrik Bech Hald <ubh@ti.com> writes:
> 
> > The functionality of omap_type() is needed for eg. watchdog
> > device registration to distinguish different device types.
> >
> > Signed-off-by: Ulrik Bech Hald <ubh@ti.com>
> 
> Collision. :) I have an add-back of this in my fixes queue which I
> just posted as well.
> 
Ok, well, as long as we get it back in there :)

/Ulrik

> Kevin
> 
> > ---
> >  arch/arm/mach-omap2/id.c |   21 +++++++++++++++++++++
> >  1 files changed, 21 insertions(+), 0 deletions(-)
> >  mode change 100644 => 100755 arch/arm/mach-omap2/id.c
> >
> > diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
> > old mode 100644
> > new mode 100755
> > index 458990e..9fa61b4
> > --- a/arch/arm/mach-omap2/id.c
> > +++ b/arch/arm/mach-omap2/id.c
> > @@ -48,6 +48,27 @@ int omap_chip_is(struct omap_chip_id oci)
> >  }
> >  EXPORT_SYMBOL(omap_chip_is);
> >
> > +int omap_type(void)
> > +{
> > +	u32 val = 0;
> > +
> > +	if (cpu_is_omap24xx()) {
> > +		val = omap_ctrl_readl(OMAP24XX_CONTROL_STATUS);
> > +	} else if (cpu_is_omap34xx()) {
> > +		val = omap_ctrl_readl(OMAP343X_CONTROL_STATUS);
> > +	} else {
> > +		pr_err("Cannot detect omap type!\n");
> > +		goto out;
> > +	}
> > +
> > +	val &= OMAP2_DEVICETYPE_MASK;
> > +	val >>= 8;
> > +
> > +out:
> > +	return val;
> > +}
> > +EXPORT_SYMBOL(omap_type);
> > +
> >  /*---------------------------------------------------------------------
> -------*/
> >
> >  #define OMAP_TAP_IDCODE		0x0204
> > --
> > 1.5.4.3
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html

