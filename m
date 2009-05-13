From: Tony Lindgren <tony@atomide.com>
Subject: Re: Query: Num GPIO lines
Date: Wed, 13 May 2009 10:31:23 -0700
Message-ID: <20090513173123.GC5593@atomide.com>
References: <63374.207.214.87.58.1239059885.squirrel@webmail.xs4all.nl> <FCCFB4CDC6E5564B9182F639FC35608702EA9675F9@dbde02.ent.ti.com> <FCCFB4CDC6E5564B9182F639FC35608702F4C296B6@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:60589 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752128AbZEMRbZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 May 2009 13:31:25 -0400
Content-Disposition: inline
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608702F4C296B6@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Pandita, Vikram <vikram.pandita@ti.com> [090422 18:17]:
> 
> Ping. Any inputs on number of gpio's wrongly defined for OMAP34xx?

Sounds like a good bug fix! I'll add it to omap-fixes queue.

Tony
 
> 
> >-----Original Message-----
> >From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of
> >Pandita, Vikram
> >Sent: Monday, April 06, 2009 6:40 PM
> >To: linux-omap@vger.kernel.org
> >Subject: Query: Num GPIO lines
> >
> >
> >Why for OMAP34xx is number of GPIO's 160?
> >As per 3430 TRM, there are 6 banks [0 to 191]
> >
> >Signed-off-by: Tom Rix <Tom.Rix@windriver.com>
> >Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
> >---
> >diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
> >index 17d7afe..ee0b21f 100644
> >--- a/arch/arm/plat-omap/gpio.c
> >+++ b/arch/arm/plat-omap/gpio.c
> >@@ -307,7 +307,7 @@ static inline int gpio_valid(int gpio)
> > 		return 0;
> > 	if (cpu_is_omap24xx() && gpio < 128)
> > 		return 0;
> >-	if (cpu_is_omap34xx() && gpio < 160)
> >+	if (cpu_is_omap34xx() && gpio < 192)
> > 		return 0;
> > 	return -1;
> > }
> >--
> >To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
