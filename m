From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH] Fix compile error in usb-musb.c
Date: Fri, 16 Jan 2009 21:08:57 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02E6815EED@dbde02.ent.ti.com>
References: <20090116153523.GD32481@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56068 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751834AbZAPPjN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Jan 2009 10:39:13 -0500
In-Reply-To: <20090116153523.GD32481@frodo>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "me@felipebalbi.com" <me@felipebalbi.com>, Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, David Brownell <david-b@pacbell.net>

> On Fri, Jan 16, 2009 at 09:37:38AM +0200, Tony Lindgren wrote:
> > * Tony Lindgren <tony@atomide.com> [090116 09:29]:
> > > * Gadiyar, Anand <gadiyar@ti.com> [090115 20:48]:
> > > > From: Anand Gadiyar <gadiyar@ti.com>
> > > > 
> > > > Fix this compile error
> > > 
> > > This one should go via the usb list too.
> > 
> > Uh, looks like my usb filter is set too sensitive :)
> > 
> > This is the platform code part, I'll apply this and queue it up
> > in omap-fixes.
> > 
> 
> I think it's time to send this via greg so we can get musb working on
> beagle. No otg though due to missing CONFIG_PM for omap3. Any plans to
> get that upstream ??
> 
> Maybe it's better to get PM there first and avoid compile issues without
> CONFIG_PM=y

I still don't get it. Why Greg?

It's a one-line compile fix for God's sake - nothing even remotely related
to a change in USB - it's platform code that got broken for some reason.

And Tony's already going to queue it up.

