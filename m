From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH] Fix compile error in usb-musb.c
Date: Fri, 16 Jan 2009 17:35:23 +0200
Message-ID: <20090116153523.GD32481@frodo>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02E6815B88@dbde02.ent.ti.com> <20090116072904.GN4128@atomide.com> <20090116073736.GO4128@atomide.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:40462 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932723AbZAPPfb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Jan 2009 10:35:31 -0500
Content-Disposition: inline
In-Reply-To: <20090116073736.GO4128@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Gadiyar, Anand" <gadiyar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, David Brownell <david-b@pacbell.net>

On Fri, Jan 16, 2009 at 09:37:38AM +0200, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [090116 09:29]:
> > * Gadiyar, Anand <gadiyar@ti.com> [090115 20:48]:
> > > From: Anand Gadiyar <gadiyar@ti.com>
> > > 
> > > Fix this compile error
> > 
> > This one should go via the usb list too.
> 
> Uh, looks like my usb filter is set too sensitive :)
> 
> This is the platform code part, I'll apply this and queue it up
> in omap-fixes.
> 

I think it's time to send this via greg so we can get musb working on
beagle. No otg though due to missing CONFIG_PM for omap3. Any plans to
get that upstream ??

Maybe it's better to get PM there first and avoid compile issues without
CONFIG_PM=y

-- 
balbi
