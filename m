From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] i2c: i2c-omap: Fix BUFSTAT_REG reading
Date: Fri, 21 Nov 2008 14:03:48 -0800
Message-ID: <20081121220347.GC4927@atomide.com>
References: <12266521123866-git-send-email-ext-eero.nurkkala@nokia.com> <200811141116.13682.david-b@pacbell.net> <1227096723.27458.9.camel@eenurkka-desktop> <200811190934.14552.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:59465 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753502AbYKUWDu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Nov 2008 17:03:50 -0500
Content-Disposition: inline
In-Reply-To: <200811190934.14552.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: ext-eero.nurkkala@nokia.com, linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [081119 09:34]:
> On Wednesday 19 November 2008, Eero Nurkkala wrote:
> > On Fri, 2008-11-14 at 11:16 -0800, ext David Brownell wrote:
> 
> > > But if the issue is that the 2430 version of the FIFO
> > > support works differently, please say so in the patch
> > > commend and code...
> >
> > I checked against 2420, and there was no such register
> > avaiable at all.  (no 2430 TRM access)
> 
> That code path couldn't be triggered on 2420; just 2430,
> which has the FIFO (as evidently needed for highspeed I2C).
> 
> My default assumption would be that 2430 works just like
> OMAP3 here, but obviously someone should check the 2430
> TRM to see its I2C BUFSTAT_REG really works differently.

Yes, they seem to be the same for 2430 and 34xx. Eero, can you please
update it to use the dev->rev instead? I just pushed Paul's earlier
patches for the dev->rev.

Tony
