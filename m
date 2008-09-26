From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH] watchdog: fix typo in omap_wdt.c
Date: Fri, 26 Sep 2008 23:32:13 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02D5DC95BB@dbde02.ent.ti.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02D5DC959A@dbde02.ent.ti.com>
 <20080926175237.GD9890@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53913 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751922AbYIZSC2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Sep 2008 14:02:28 -0400
In-Reply-To: <20080926175237.GD9890@frodo>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "me@felipebalbi.com" <me@felipebalbi.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>

> -----Original Message-----
> From: Felipe Balbi [mailto:me@felipebalbi.com] 
> Sent: Friday, September 26, 2008 11:23 PM
> To: Gadiyar, Anand
> Cc: linux-omap@vger.kernel.org; felipe.balbi@nokia.com
> Subject: Re: [PATCH] watchdog: fix typo in omap_wdt.c
> 
> On Fri, Sep 26, 2008 at 09:20:14PM +0530, Gadiyar, Anand wrote:
> > From: Anand Gadiyar <gadiyar@ti.com>
> > 
> > Fix typo in omap_wdt.c introduced by a recent change
> > 
> > Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
> > ---
> >  drivers/watchdog/omap_wdt.c |    2 +-
> >  1 files changed, 1 insertion(+), 1 deletion(-)
> > 
> > Index: tony/drivers/watchdog/omap_wdt.c
> > ===================================================================
> > --- tony.orig/drivers/watchdog/omap_wdt.c	2008-09-25 
> 16:45:08.000000000 +0530
> > +++ tony/drivers/watchdog/omap_wdt.c	2008-09-26 
> 21:14:48.059042569 +0530
> > @@ -283,7 +283,7 @@ static int __init omap_wdt_probe(struct 
> >  	}
> >  
> >  	if (omap_wdt_dev) {
> > -		ret - EBUSY;
> > +		ret = -EBUSY;
> >  		goto err_busy;
> >  	}
> 
> Those patches weren't applied to linux-omap yet, so this change should
> be melded into the patch that introduced it. It's better to 
> resend that
> patch then to create a messed up bisect line.
> 
> -- 
> balbi

Of course they were merged. I saw this warning when I compiled linux-omap,
when sending in that pin-muxing patch.

- Anand
