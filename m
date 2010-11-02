From: "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>
Subject: RE: [PATCH] McBSP: Fix the free variable update at remove.
Date: Tue, 2 Nov 2010 16:00:49 +0530
Message-ID: <0680EC522D0CC943BC586913CF3768C003FF767E41@dbde02.ent.ti.com>
References: <1288340367-29956-1-git-send-email-shubhrajyoti@ti.com>
 <FCCFB4CDC6E5564B9182F639FC356087034BE1DF32@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60509 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750880Ab0KBKaz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Nov 2010 06:30:55 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id oA2AUqKq018793
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 2 Nov 2010 05:30:54 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id oA2AUpZg003093
	for <linux-omap@vger.kernel.org>; Tue, 2 Nov 2010 16:00:51 +0530 (IST)
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC356087034BE1DF32@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>, "ABRAHAM, KISHON VIJAY" <kishon@ti.com>

Hi Vishwa,
Thanks for your review

> -----Original Message-----
> From: Sripathy, Vishwanath
> Sent: Saturday, October 30, 2010 12:35 AM
> To: Datta, Shubhrajyoti; linux-omap@vger.kernel.org
> Cc: Pandita, Vikram; ABRAHAM, KISHON VIJAY
> Subject: RE: [PATCH] McBSP: Fix the free variable update at remove.
> 
> Shubro,
> 
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > owner@vger.kernel.org] On Behalf Of Datta, Shubhrajyoti
> > Sent: Friday, October 29, 2010 4:19 AM
> > To: linux-omap@vger.kernel.org
> > Cc: Pandita, Vikram; Datta, Shubhrajyoti; ABRAHAM, KISHON VIJAY
> > Subject: [PATCH] McBSP: Fix the free variable update at remove.
> >
> > From: Shubhrajyoti D <shubhrajyoti@ti.com>
> >
> > At remove the free variable is wrongly updated.Attempting to solve the
> > same.
> >
> >
> > Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> > Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> > Reported-by: Vikram Pandita <vikram.pandita@ti.com>
> > ---
> >  arch/arm/plat-omap/mcbsp.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
> > index eac4b97..6802ed1 100644
> > --- a/arch/arm/plat-omap/mcbsp.c
> > +++ b/arch/arm/plat-omap/mcbsp.c
> > @@ -1845,7 +1845,7 @@ static int __devexit
> > omap_mcbsp_remove(struct platform_device *pdev)
> >
> >  		mcbsp->fclk = NULL;
> >  		mcbsp->iclk = NULL;
> > -		mcbsp->free = 0;
> > +		mcbsp->free = 1;
> Isn't it better to use TRUE/FALSE instead of 1/0 if it's a Boolean
> variable?
Addressed it in the v2. Thanks.
> 
> Vishwa
> 
> >  		mcbsp->dev = NULL;
> >  	}
> >
> > --
> > 1.7.0.4
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
