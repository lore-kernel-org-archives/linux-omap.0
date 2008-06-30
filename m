From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [RFC][PATCH] usb: musb: pass configuration specifics via pdata
Date: Mon, 30 Jun 2008 21:37:09 +0300
Message-ID: <20080630183709.GF4877@kedavra.cpe.vivax.com.br>
References: <1214826653-19005-1-git-send-email-felipe.balbi@nokia.com> <E25964AA-D229-4654-B24B-30A48708B056@student.utwente.nl> <20080630181655.GD4877@kedavra.cpe.vivax.com.br> <200806301133.15860.david-b@pacbell.net>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:60355 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763215AbYF3ShZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Jun 2008 14:37:25 -0400
Content-Disposition: inline
In-Reply-To: <200806301133.15860.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: me@felipebalbi.com, Koen Kooi <k.kooi@student.utwente.nl>, Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Anand Gadiyar <gadiyar@ti.com>, Kevin Hilman <khilman@mvista.com>, Bryan Wu <cooloney@kernel.org>

On Mon, Jun 30, 2008 at 11:33:15AM -0700, David Brownell wrote:
> On Monday 30 June 2008, Felipe Balbi wrote:
> > The patch won't probe. But if you just copy what's added in board-omap3430sdp.c
> > should work.
> 
> Better:  that controller data should be provided by SOC glue
> in those cases (omap2430, omap 3*, DaVinci, etc).  If it's
> not board-specific, it doesn't belong in board-specific glue..

Hmm... will do, thanks

-- 
Best Regards,

Felipe Balbi
me@felipebalbi.com
http://blog.felipebalbi.com
