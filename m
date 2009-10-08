From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [RFC][PATCH] OMAP3: introduce OMAP3630
Date: Thu, 8 Oct 2009 19:53:08 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DDD75DAE@dbde02.ent.ti.com>
References: <[PATCH][RFC] OMAP3630: Create architecture macros and config>
 <1254977223-4236-1-git-send-email-nm@ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02BB13D1EF@dbde02.ent.ti.com>
 <FCCFB4CDC6E5564B9182F639FC35608702FA02389D@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37167 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932212AbZJHOXw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Oct 2009 10:23:52 -0400
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608702FA02389D@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Menon, Nishanth" <nm@ti.com>, linux-omap <linux-omap@vger.kernel.org>
Cc: "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, "Pais, Allen" <allen.pais@ti.com>, "Gadiyar, Anand" <gadiyar@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>, Tony Lindgren <tony@atomide.com>

> -----Original Message-----
> From: Pandita, Vikram 
> Sent: Thursday, October 08, 2009 7:01 PM
> To: Shilimkar, Santosh; Menon, Nishanth; linux-omap
> Cc: Chikkature Rajashekar, Madhusudhan; Pais, Allen; Gadiyar, 
> Anand; Cousson, Benoit; Kevin Hilman; Premi, Sanjeev; Aguirre 
> Rodriguez, Sergio Alberto; Tony Lindgren
> Subject: RE: [RFC][PATCH] OMAP3: introduce OMAP3630
> 
> 
> 
> >-----Original Message-----
> >From: Shilimkar, Santosh
> >>
> >> diff --git a/arch/arm/plat-omap/include/mach/cpu.h b/arch/arm/plat-
> >> omap/include/mach/cpu.h
> >> index 431fec4..af1080f 100644
> >> --- a/arch/arm/plat-omap/include/mach/cpu.h
> >> +++ b/arch/arm/plat-omap/include/mach/cpu.h
> >> @@ -383,6 +383,12 @@ IS_OMAP_TYPE(3430, 0x3430)
> >>  #define OMAP3430_REV_ES2_1	0x34302034
> >>  #define OMAP3430_REV_ES3_0	0x34303034
> >>  #define OMAP3430_REV_ES3_1	0x34304034
> >> +/* NOTE: Add 36xx series below
> >> + * If additional 34xx series are added, OMAP3430_REV_ESXXXX can be
> >> + * added above the 3630 defines and series renumbered to ensure
> >> + * rev() > checks to work
> >> + */
> >> +#define OMAP3630_REV_ES1_0	0x34305034
> >>
> >>  #define OMAP443X_CLASS		0x44300034
> >Was expecting that this patch will add "cpu_is_omap36xx()" in cpu.h
> >apart from above. Is this handled in another patch ?
> 
> Idea is to re-use all 34xx code for 36xx, as per the mail 
> thread on list, and given in reference.
> Hence at run time, the check could be:
> 
> if (omap_rev() == OMAP3630_REV_ES1_0)
> 	xxxxx
> 
> cpu_is_omap34xx() will be true for 36xx as well.

[sp] This case seems quite similar to the OMAP35x.
     Can you look at this thread:

     http://marc.info/?l=linux-omap&m=125372581804902&w=2

     It applies equally well here as well...
     I will be submitting updated patch tomorrow.

Best regards,
Sanjeev

> 
> >
> >
> >Regards,
> >Santosh
> 