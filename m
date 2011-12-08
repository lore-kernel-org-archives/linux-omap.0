From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [RFC PATCH] arm:omap: cleanup & split omap2/3/4_check_revision
 function
Date: Thu, 8 Dec 2011 13:40:04 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A8050F45@DBDE01.ent.ti.com>
References: <1320676991-32152-1-git-send-email-hvaibhav@ti.com>
 <79CD15C6BA57404B839C016229A409A803D9D5@DBDE01.ent.ti.com>
 <20111207234119.GQ31337@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45396 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750796Ab1LHNkL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Dec 2011 08:40:11 -0500
In-Reply-To: <20111207234119.GQ31337@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Thursday, December 08, 2011 5:11 AM
> To: Hiremath, Vaibhav
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [RFC PATCH] arm:omap: cleanup & split
> omap2/3/4_check_revision function
> 
> * Hiremath, Vaibhav <hvaibhav@ti.com> [111122 21:56]:
> > >
> > > This patch doesn't change functionality or behavior of the code
> > > execution; it barely cleans up the code and splits into SoC
> > > specific implementation for ID and feature detection; makes
> > > easier to add new SoC (especially for AM devices where we do not have
> > > feature register).
> ...
> 
> > If there are not review comments, can this be merged?
> 
> Sorry for the delay, the idea is good now that we don't need the
> revision check super early any longer. Few comments below.
> 

Thanks for the comment, response in-lined below -

> > > --- a/arch/arm/mach-omap2/id.c
> > > +++ b/arch/arm/mach-omap2/id.c
> > > @@ -226,9 +226,9 @@ static void __init omap4_check_features(void)
> > >  	}
> > >  }
> > >
> > > -static void __init ti816x_check_features(void)
> > > +static void __init omap3_add_def_features(void)
> > >  {
> > > -	omap_features = OMAP3_HAS_NEON;
> > > +	omap_features = OMAP3_HAS_NEON | OMAP3_HAS_L2CACHE;
> > >  }
> > >
> > >  static void __init omap3_check_revision(const char **cpu_rev)
> 
> Can you please split this patch a bit? First a patch that does not
> change the behaviour except adds the SoC specific revision checks.
> 
> > > @@ -393,6 +394,7 @@ void __init omap2430_init_early(void)
> > >  void __init omap3_init_early(void)
> > >  {
> > >  	omap2_set_globals_3xxx();
> > > +	omap3xxx_check_revision(true);
> > >  	omap_common_init_early();
> > >  	omap3xxx_voltagedomains_init();
> > >  	omap3xxx_powerdomains_init();
> > > @@ -425,6 +427,7 @@ void __init am35xx_init_early(void)
> > >  void __init ti816x_init_early(void)
> > >  {
> > >  	omap2_set_globals_ti816x();
> > > +	omap3xxx_check_revision(false);
> > >  	omap_common_init_early();
> > >  	omap3xxx_voltagedomains_init();
> > >  	omap3xxx_powerdomains_init();
> 
> Maybe just call ti816x_check_features separately?
> 
> 	omap3xxx_check_revision();
> 	omap3xxx_check_features();
> and
> 	omap3xxx_check_revision();
> 	ti816x_check_features();
> 
The reason why I did not do this is,

In case of omap3_check_revision, 

Void __init omap3xxx_check_revision()
{
	const char *cpu_rev;

	omap3_check_revision(&cpu_rev);
	omap3_check_features();
	omap3_cpuinfo(cpu_rev);
}


If I separate, omap3_check_revision() and omap3_check_features(), then I 
have to maintain cpu_rev in the parent function. Also, I can not break the 
sequence due to this dependency on cpu_rev. and I wanted to retain the void
function calls in omap3_init_early().
So I came up with this optimized and clean way of using "has_feature_reg" 
Flag, and set to default features for AM family of devices.

OR
As you suggested, I have to maintain cpu_rev into function 
omap3_init_early() and call the above 3 function in the sequence
(alone for omap3).


I am ok with any approach...

Thanks,
Vaibhav

> Regards,
> 
> Tony
