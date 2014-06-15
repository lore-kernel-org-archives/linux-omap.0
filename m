From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: DRA7: hwmod: add entry for RTCSS
Date: Sun, 15 Jun 2014 03:47:32 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1406150346050.659@utopia.booyaka.com>
References: <f99196358a3cc28b0bd451459badcfc286533845.1399638849.git.nsekhar@ti.com> <alpine.DEB.2.02.1406131908260.340@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:59429 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751231AbaFODrd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 14 Jun 2014 23:47:33 -0400
In-Reply-To: <alpine.DEB.2.02.1406131908260.340@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>, Lokesh Vutla <lokeshvutla@ti.com>

On Fri, 13 Jun 2014, Paul Walmsley wrote:

> On Fri, 9 May 2014, Sekhar Nori wrote:
> 
> > From: Lokesh Vutla <lokeshvutla@ti.com>
> > 
> > RTCSS on DRA7 provides a precise real-time clock.
> > Add hwmod entry for this IP.
> > 
> > Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> > Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> 
> Sorry for the delay on this patch.  Have been corresponding with TI to 
> figure out what to do about DRA7xx/AM43xx patches.  I don't have boards or 
> public documentation for these devices, so it's impossible for me to 
> meaningfully review the patches.  Looks like boards and/or public docs 
> won't be coming any time soon.
> 
> So for my part, here's what I'll need to merge any hwmod patches that
> involve AM437x or DRA7xx:
> 
> 1. A Reviewed-by: from one of the following folks (which should come from
> a different person than who is submitting the patches):
> 
> Roger Quadros
> Nishanth Menon
> Rajendra Nayak
> Kevin Hilman
> Tony Lindgren
> 
> 2. A Tested-by: from one of the following folks (who can be the same as 
> the person who is the same as the person who is submitting the patches):
> 
> Nishanth Menon
> Rajendra Nayak
> Kevin Hilman 
> Tony Lindgren
> 
> 
> Once these are in place, I'd be happy to queue it for 3.16.

I've tried to refine this a little bit.  More details here:

http://marc.info/?l=linux-omap&m=140280321814330&w=2

- Paul
