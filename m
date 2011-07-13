From: Tony Lindgren <tony@atomide.com>
Subject: Re: Remaining omap pull requests
Date: Tue, 12 Jul 2011 23:16:34 -0700
Message-ID: <20110713061634.GG5783@atomide.com>
References: <20110711114736.GX5783@atomide.com>
 <201107120016.12366.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:14076 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S964930Ab1GMGQj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jul 2011 02:16:39 -0400
Content-Disposition: inline
In-Reply-To: <201107120016.12366.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>, Thomas Gleixner <tglx@linutronix.de>

* Arnd Bergmann <arnd@arndb.de> [110711 15:11]:
> On Monday 11 July 2011, Tony Lindgren wrote:
> > Hi Arnd,
> > 
> > Below is a summary of the pending omap pull requests as there are still
> > few branches pending.
> > 
> > Can you please take a look and see what you can take of these for v3.1
> > merge window?
> > 
> > There's still quite a bit more code shrinkage, and the new code for 4460
> > and PRCM related changes are badly needed.
> 
> I've pulled everything now, please check if it looks ok to you.

Thanks looks good to me.
 
> I haven't really looked at the patches much, I hope that I have time
> to at least do some test builds and take a very rough look at the
> contents tomorrow.

OK thanks.
 
> Thanks for the detailed descriptions, and for splitting it
> into good-sized series.

Looks like I forgot the i2c driver changes that also should be
merged by us. Those are acked by Ben Dooks, Kevin's pull request
for that is at:

http://marc.info/?l=linux-omap&m=131014213007667&w=2

Regards,

Tony
