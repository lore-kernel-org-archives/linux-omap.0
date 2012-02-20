From: Tony Lindgren <tony@atomide.com>
Subject: Re: ARM: OMAP2xxx: PM: remove obsolete timer disable code in the
 suspend path
Date: Mon, 20 Feb 2012 14:08:46 -0800
Message-ID: <20120220220846.GO18185@atomide.com>
References: <alpine.DEB.2.00.1202092007540.17520@utopia.booyaka.com>
 <alpine.DEB.2.00.1202100140430.2553@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:23610 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754577Ab2BTWIt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Feb 2012 17:08:49 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1202100140430.2553@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, robherring2@gmail.com

* Paul Walmsley <paul@pwsan.com> [120210 00:10]:
> On Thu, 9 Feb 2012, Paul Walmsley wrote:
> 
> > 
> > Remove omap_{read,write}l() from the 24xx PM code.  The clocksource
> > code should now handle what this was supposed to do.
> > 
> > Tested on N800 -- but it's hard to say whether this fixes anything.
> > OMAP24xx static suspend path is currently broken, and this patch
> > doesn't change that.
> > 
> > Signed-off-by: Paul Walmsley <paul@pwsan.com>
> > Cc: Kevin Hilman <khilman@ti.com>
> > Cc: Rob Herring <robherring2@gmail.com>
> > Cc: Tony Lindgren <tony@atomide.com>
> 
> Just realized that a stray change made it into the patch that was posted.
> Below is a version with the stray change removed.  It applies on 
> Tony's v3.3-rc3 testing branch, plus the OMAP2420 serial fix patch that 
> was posted earlier.

Thanks I'll apply this into my clean-up branch along with other
io.h changes. I also have fixed omap_read/write for the following
on omap2+:

plat-omap/dma.c
drivers/gpio/gpio-omap.c

Planning to also fix plat-omap/usb.c.

Regards,

Tony
