From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH] Fix compile error in usb-musb.c
Date: Fri, 16 Jan 2009 17:49:22 +0200
Message-ID: <20090116154922.GF32481@frodo>
References: <20090116153523.GD32481@frodo> <5A47E75E594F054BAF48C5E4FC4B92AB02E6815EED@dbde02.ent.ti.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:39622 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755573AbZAPPta (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Jan 2009 10:49:30 -0500
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02E6815EED@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: "me@felipebalbi.com" <me@felipebalbi.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, David Brownell <david-b@pacbell.net>

On Fri, Jan 16, 2009 at 09:08:57PM +0530, Gadiyar, Anand wrote:
> I still don't get it. Why Greg?
> 
> It's a one-line compile fix for God's sake - nothing even remotely related
> to a change in USB - it's platform code that got broken for some reason.
> 
> And Tony's already going to queue it up.

I'm talking about pushing the whole file via musb patches ;-)

-- 
balbi
