From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH 11/11] OMAP3: PM: Disable OTG autoidle when waking up
 from off-mode
Date: Thu, 12 Nov 2009 13:13:56 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030A8C82FA@dbde02.ent.ti.com>
References: <1256313835-2391-1-git-send-email-tero.kristo@nokia.com>
	<1256313835-2391-2-git-send-email-tero.kristo@nokia.com>
	<1256313835-2391-3-git-send-email-tero.kristo@nokia.com>
	<1256313835-2391-4-git-send-email-tero.kristo@nokia.com>
	<1256313835-2391-5-git-send-email-tero.kristo@nokia.com>
	<1256313835-2391-6-git-send-email-tero.kristo@nokia.com>
	<1256313835-2391-7-git-send-email-tero.kristo@nokia.com>
	<1256313835-2391-8-git-send-email-tero.kristo@nokia.com>
	<1256313835-2391-9-git-send-email-tero.kristo@nokia.com>
	<1256313835-2391-10-git-send-email-tero.kristo@nokia.com>
	<1256313835-2391-11-git-send-email-tero.kristo@nokia.com>
	<1256313835-2391-12-git-send-email-tero.kristo@nokia.com>
 <878wecy6g8.fsf@deeprootsystems.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB030A8C829A@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51433 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751362AbZKLHoA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Nov 2009 02:44:00 -0500
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB030A8C829A@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, Tero Kristo <tero.kristo@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

<snip>

> > > @@ -496,6 +497,11 @@ void omap_sram_idle(void)
> > >  			omap3_prcm_restore_context();
> > >  			omap3_sram_restore_context();
> > >  			omap2_sms_restore_context();
> > > +			/*
> > > +			 * Errata 1.164 fix : OTG autoidle can prevent
> > > +			 * sleep
> > > +			 */
> > > +			usb_musb_disable_autoidle();
> > 
> > NAK.  This belongs in the MUSB driver, not in the idle path.
> > 
> 
> Kevin,
> 
> When we exit off-mode, the autoidle will get enabled, and needs
> an explicit disable. If the MUSB driver is not loaded, there will
> be no one to do this.
> 
> - Anand
> 
> > Kevin
> > 
> > >  		}
> > >  		omap_uart_resume_idle(0);
> > >  		omap_uart_resume_idle(1);
> > > diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
> > > index 8dde0b7..f4b86c0 100644
> > > --- a/arch/arm/mach-omap2/usb-musb.c
> > > +++ b/arch/arm/mach-omap2/usb-musb.c
> > > @@ -44,10 +44,11 @@ static struct platform_device dummy_pdev = {
> > >  	},
> > >  };
> > >  
> > > +static void __iomem *otg_base;
> > > +static struct clk *otg_clk;
> > > +
> > >  static void __init usb_musb_pm_init(void)
> > >  {
> > > -	void __iomem *otg_base;
> > > -	struct clk *otg_clk;
> > >  	struct device *dev = &dummy_pdev.dev;
> > >  
> > >  	if (!cpu_is_omap34xx())

Just realized, this probably should read cpu_is_omap3430().

cpu_is_omap34xx is true for 3630 as well, and this chip doesn't need
this workaround.

(Won't hurt much to have this like this for now - until we switch to
the CHIP_HAS_ERRATA way)

- Anand
