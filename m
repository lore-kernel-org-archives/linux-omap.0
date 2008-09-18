From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 2/5] watchdog: another ioremap() fix
Date: Fri, 19 Sep 2008 02:12:56 +0300
Message-ID: <20080918231255.GJ6617@frodo>
References: <1221776622-22906-1-git-send-email-me@felipebalbi.com> <1221776622-22906-2-git-send-email-me@felipebalbi.com> <1221776622-22906-3-git-send-email-me@felipebalbi.com> <20080918230653.GG14307@flint.arm.linux.org.uk>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:39075 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755527AbYIRXNG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Sep 2008 19:13:06 -0400
Content-Disposition: inline
In-Reply-To: <20080918230653.GG14307@flint.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Felipe Balbi <me@felipebalbi.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, David Brownell <david-b@pacbell.net>, "George G. Davis" <gdavis@mvista.com>, Wim Van Sebroeck <wim@iguana.be>, Felipe Balbi <felipe.balbi@nokia.com>

On Fri, Sep 19, 2008 at 12:06:53AM +0100, Russell King - ARM Linux wrote:
> On Fri, Sep 19, 2008 at 01:23:39AM +0300, Felipe Balbi wrote:
> > @@ -359,6 +364,8 @@ fail:
> >  			clk_put(wdev->mpu_wdt_ick);
> >  		if (wdev->mpu_wdt_fck)
> >  			clk_put(wdev->mpu_wdt_fck);
> > +		if (wdev->base)
> > +			iounmap(wdev->base);
> >  		kfree(wdev);
> >  	}
> >  	if (mem) {
> > @@ -396,6 +403,9 @@ static int omap_wdt_remove(struct platform_device *pdev)
> >  		clk_put(wdev->mpu_wdt_fck);
> >  		wdev->mpu_wdt_fck = NULL;
> >  	}
> > +	if (wdev->base)
> > +		iounmap(wdev->base);
> > +
> 
> For both of these... iounmap on NULL pointers is allowed, so the
> test is redundant.

Good to know. Thanks

-- 
balbi
