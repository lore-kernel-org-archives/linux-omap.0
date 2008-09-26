From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH] watchdog: fix typo in omap_wdt.c
Date: Fri, 26 Sep 2008 22:27:47 +0300
Message-ID: <20080926192746.GG9890@frodo>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02D5DC959A@dbde02.ent.ti.com> <20080926175237.GD9890@frodo> <5A47E75E594F054BAF48C5E4FC4B92AB02D5DC95BB@dbde02.ent.ti.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:57239 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752316AbYIZT15 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Sep 2008 15:27:57 -0400
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02D5DC95BB@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: "me@felipebalbi.com" <me@felipebalbi.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>

On Fri, Sep 26, 2008 at 11:32:13PM +0530, Gadiyar, Anand wrote:
> > -----Original Message-----
> > From: Felipe Balbi [mailto:me@felipebalbi.com] 
> > Sent: Friday, September 26, 2008 11:23 PM
> > To: Gadiyar, Anand
> > Cc: linux-omap@vger.kernel.org; felipe.balbi@nokia.com
> > Subject: Re: [PATCH] watchdog: fix typo in omap_wdt.c
> > 
> > On Fri, Sep 26, 2008 at 09:20:14PM +0530, Gadiyar, Anand wrote:
> > > From: Anand Gadiyar <gadiyar@ti.com>
> > > 
> > > Fix typo in omap_wdt.c introduced by a recent change
> > > 
> > > Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
> > > ---
> > >  drivers/watchdog/omap_wdt.c |    2 +-
> > >  1 files changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > Index: tony/drivers/watchdog/omap_wdt.c
> > > ===================================================================
> > > --- tony.orig/drivers/watchdog/omap_wdt.c	2008-09-25 
> > 16:45:08.000000000 +0530
> > > +++ tony/drivers/watchdog/omap_wdt.c	2008-09-26 
> > 21:14:48.059042569 +0530
> > > @@ -283,7 +283,7 @@ static int __init omap_wdt_probe(struct 
> > >  	}
> > >  
> > >  	if (omap_wdt_dev) {
> > > -		ret - EBUSY;
> > > +		ret = -EBUSY;
> > >  		goto err_busy;
> > >  	}
> > 
> > Those patches weren't applied to linux-omap yet, so this change should
> > be melded into the patch that introduced it. It's better to 
> > resend that
> > patch then to create a messed up bisect line.
> > 
> > -- 
> > balbi
> 
> Of course they were merged. I saw this warning when I compiled linux-omap,
> when sending in that pin-muxing patch.

You're right, at first look I thought this was for omap_hdq.c :-p

Anyways, this patch should go also to Wim. Please send a copy of this
patch to him so he can apply to his tree as well, btw, here's his mail:

Wim Van Sebroeck <wim@iguana.be>

-- 
balbi
