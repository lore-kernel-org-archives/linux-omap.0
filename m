From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RESUBMIT][PATCH 4/7] OMAP4: Update common omap platform common
	sources.
Date: Mon, 18 May 2009 08:50:54 -0700
Message-ID: <20090518155054.GQ19742@atomide.com>
References: <1241677756-28756-1-git-send-email-santosh.shilimkar@ti.com> <1241677756-28756-2-git-send-email-santosh.shilimkar@ti.com> <1241677756-28756-3-git-send-email-santosh.shilimkar@ti.com> <1241677756-28756-4-git-send-email-santosh.shilimkar@ti.com> <20090516095332.GH15328@n2100.arm.linux.org.uk> <EAF47CD23C76F840A9E7FCE10091EFAB02B49042A1@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:50253 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751101AbZERPvF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 May 2009 11:51:05 -0400
Content-Disposition: inline
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02B49042A1@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Shilimkar, Santosh <santosh.shilimkar@ti.com> [090516 13:04]:
> Thanks Russell for scanning all the patches minutely !!
> 
> > -----Original Message-----
> > From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk] 
> > Sent: Saturday, May 16, 2009 3:24 PM
> > To: Shilimkar, Santosh
> > Cc: linux-arm-kernel@lists.arm.linux.org.uk; 
> > linux-omap@vger.kernel.org
> > Subject: Re: [RESUBMIT][PATCH 4/7] OMAP4: Update common omap 
> > platform common sources.
> > 
> > On Thu, May 07, 2009 at 11:59:13AM +0530, Santosh Shilimkar wrote:
> > > @@ -309,3 +313,26 @@ void __init omap2_set_globals_343x(void)
> > >  }
> > >  #endif
> > >  
> > > +#if defined(CONFIG_ARCH_OMAP4)
> > > +static struct omap_globals *omap4_globals;
> > > +
> > > +static void __init __omap4_set_globals(void)
> > > +{
> > > +	omap2_set_globals_tap(omap4_globals);
> > > +	omap2_set_globals_control(omap4_globals);
> > > +}
> > > +static struct omap_globals omap443x_globals = {
> > > +	.class	= OMAP443X_CLASS,
> > > +	.tap	= OMAP2_IO_ADDRESS(0x4830A000),
> > > +	.ctrl	= OMAP2_IO_ADDRESS(OMAP443X_CTRL_BASE),
> > > +	.prm	= OMAP2_IO_ADDRESS(OMAP4430_PRM_BASE),
> > > +	.cm	= OMAP2_IO_ADDRESS(OMAP4430_CM_BASE),
> > > +};
> > > +
> > > +void __init omap2_set_globals_443x(void)
> > > +{
> > > +	omap4_globals = &omap443x_globals;
> > > +	__omap4_set_globals();
> > 
> > Hmm, confused.  omap4_globals is a static variable, and 
> > __omap4_set_globals
> > is a static function.  The only user of omap4_globals is 
> > __omap4_set_globals.
> > It looks to me like the only purpose of omap4_globals is to pass a
> > structure to __omap4_set_globals.  Why not use a function 
> > argument instead?
> Indeed. Actually I just more or less followed what is done for OMAP2/OMAP3 here. I will clean this for OMAP4.
> 
> Tony,
> We may want to clean up this for OMAP2/OMAP3 as well. Can we add this to the clean up patches planned if any. I can create the patch.

Sure, please post that patch for review.

Regards,

Tony
