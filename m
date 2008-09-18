From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 4/5] watchdog: cleanup a bit omap_wdt.c
Date: Fri, 19 Sep 2008 02:18:32 +0300
Message-ID: <20080918231831.GL6617@frodo>
References: <1221776622-22906-1-git-send-email-me@felipebalbi.com> <1221776622-22906-2-git-send-email-me@felipebalbi.com> <1221776622-22906-3-git-send-email-me@felipebalbi.com> <1221776622-22906-4-git-send-email-me@felipebalbi.com> <1221776622-22906-5-git-send-email-me@felipebalbi.com> <20080918231021.GH14307@flint.arm.linux.org.uk>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:53093 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755572AbYIRXSr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Sep 2008 19:18:47 -0400
Content-Disposition: inline
In-Reply-To: <20080918231021.GH14307@flint.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Felipe Balbi <me@felipebalbi.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, David Brownell <david-b@pacbell.net>, "George G. Davis" <gdavis@mvista.com>, Wim Van Sebroeck <wim@iguana.be>, Felipe Balbi <felipe.balbi@nokia.com>

On Fri, Sep 19, 2008 at 12:10:21AM +0100, Russell King - ARM Linux wrote:
> On Fri, Sep 19, 2008 at 01:23:41AM +0300, Felipe Balbi wrote:
> > +
> >  	return 0;
> >  }
> > -
> > -#else
> > -#define	omap_wdt_suspend	NULL
> > -#define	omap_wdt_resume		NULL
> >  #endif
> >  
> >  static struct platform_driver omap_wdt_driver = {
> >  	.probe		= omap_wdt_probe,
> >  	.remove		= omap_wdt_remove,
> > +#ifdef	CONFIG_PM
> >  	.shutdown	= omap_wdt_shutdown,
> >  	.suspend	= omap_wdt_suspend,
> > +#endif
> 
> I prefer to see the function names defined to NULL rather than adding
> extra ifdefs into drivers.

Reverted.

-- 
balbi
