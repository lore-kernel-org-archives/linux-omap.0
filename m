From: Darren Etheridge <detheridge@ti.com>
Subject: Re: [PATCH] ARM: dts: am335x-evm: fix comments for lcd pins
Date: Fri, 9 May 2014 12:38:20 -0500
Message-ID: <20140509173820.GL2626@ti.com>
References: <1399648580-14487-1-git-send-email-wsa@the-dreams.de>
 <20140509155929.GJ2626@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35554 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750775AbaEIRjb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 May 2014 13:39:31 -0400
Content-Disposition: inline
In-Reply-To: <20140509155929.GJ2626@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-arm-kernel@lists.infradead.org, Wolfram Sang <wsa@sang-engineering.com>, Benoit Parrot <bparrot@ti.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

Darren Etheridge <detheridge@ti.com> wrote on Fri [2014-May-09 10:59:30 -0500]:
> Wolfram,
> 
> Wolfram Sang <wsa@the-dreams.de> wrote on Fri [2014-May-09 17:15:50 +0200]:
> > From: Wolfram Sang <wsa@sang-engineering.com>
> > 
> > In the comments, LCD pins 16-23 were numbered in the wrong order.
> > Fix this and use proper pinmux constants for all entries while we are
> > 
> Looks like you are absolutely correct - I just confirmed this from both
> the AM335x-EVM schematic and the AM335x pinmux utility.
> 
> The same mistake is also in my EVMSK LCD enabling patch that is floating
> around on this list at the moment.  I will fix that and resend it.
> BeagleBone Black only uses the first 16 LCD pins so the dts for that is
> correct.
> 
> Thanks for finding and fixing it.
> 

In the process of fixing up my EVMSK patch I applied this patch and tested it
on a 3.15-rc4 kernel running on an AM335x-EVM.  Worked great - so your
pinmux constant conversion appears to be correct.

Tested-by: Darren Etheridge <detheridge@ti.com>
