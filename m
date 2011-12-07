From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC PATCH] arm:omap: cleanup & split omap2/3/4_check_revision
 function
Date: Wed, 7 Dec 2011 15:41:19 -0800
Message-ID: <20111207234119.GQ31337@atomide.com>
References: <1320676991-32152-1-git-send-email-hvaibhav@ti.com>
 <79CD15C6BA57404B839C016229A409A803D9D5@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:37002 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751470Ab1LGXlW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Dec 2011 18:41:22 -0500
Content-Disposition: inline
In-Reply-To: <79CD15C6BA57404B839C016229A409A803D9D5@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Hiremath, Vaibhav <hvaibhav@ti.com> [111122 21:56]:
> > 
> > This patch doesn't change functionality or behavior of the code
> > execution; it barely cleans up the code and splits into SoC
> > specific implementation for ID and feature detection; makes
> > easier to add new SoC (especially for AM devices where we do not have
> > feature register).
...
 
> If there are not review comments, can this be merged?

Sorry for the delay, the idea is good now that we don't need the
revision check super early any longer. Few comments below.
 
> > --- a/arch/arm/mach-omap2/id.c
> > +++ b/arch/arm/mach-omap2/id.c
> > @@ -226,9 +226,9 @@ static void __init omap4_check_features(void)
> >  	}
> >  }
> > 
> > -static void __init ti816x_check_features(void)
> > +static void __init omap3_add_def_features(void)
> >  {
> > -	omap_features = OMAP3_HAS_NEON;
> > +	omap_features = OMAP3_HAS_NEON | OMAP3_HAS_L2CACHE;
> >  }
> > 
> >  static void __init omap3_check_revision(const char **cpu_rev)

Can you please split this patch a bit? First a patch that does not
change the behaviour except adds the SoC specific revision checks.

> > @@ -393,6 +394,7 @@ void __init omap2430_init_early(void)
> >  void __init omap3_init_early(void)
> >  {
> >  	omap2_set_globals_3xxx();
> > +	omap3xxx_check_revision(true);
> >  	omap_common_init_early();
> >  	omap3xxx_voltagedomains_init();
> >  	omap3xxx_powerdomains_init();
> > @@ -425,6 +427,7 @@ void __init am35xx_init_early(void)
> >  void __init ti816x_init_early(void)
> >  {
> >  	omap2_set_globals_ti816x();
> > +	omap3xxx_check_revision(false);
> >  	omap_common_init_early();
> >  	omap3xxx_voltagedomains_init();
> >  	omap3xxx_powerdomains_init();

Maybe just call ti816x_check_features separately?

	omap3xxx_check_revision();
	omap3xxx_check_features();
and
	omap3xxx_check_revision();
	ti816x_check_features();	

Regards,

Tony
