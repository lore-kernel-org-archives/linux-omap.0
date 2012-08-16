From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 04/14] ARM: OMAP5: Add minimal support for OMAP5430
 SOC
Date: Thu, 16 Aug 2012 01:39:24 -0700
Message-ID: <20120816083923.GK11011@atomide.com>
References: <1341566515-22665-1-git-send-email-santosh.shilimkar@ti.com>
 <1341566515-22665-5-git-send-email-santosh.shilimkar@ti.com>
 <4FFA9B61.8030808@ti.com>
 <20120709131156.GH1122@atomide.com>
 <alpine.DEB.2.00.1208151618590.1731@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:45944 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752955Ab2HPIj2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Aug 2012 04:39:28 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1208151618590.1731@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Vaibhav Hiremath <hvaibhav@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, R Sricharan <r.sricharan@ti.com>

* Paul Walmsley <paul@pwsan.com> [120815 15:27]:
> Hi
> 
> On Mon, 9 Jul 2012, Tony Lindgren wrote:
> 
> > Below (untested) is what could be done in the short term.
> 
> That's fine with me.  Do you want to queue it or do you want me to queue 
> it?

Probably best for you to take it along with other related patches.
 
> > Heh these CK_XXXX defines are now running out of the u16 cpu_mask.
> > 
> > They really should be replaced with SoC specific lists of clocks
> > rather than bloating the cpu_mask and repeating it for every clock
> > that's compiled in for 800+ times.
> 
> Frankly, an extra 1.6KB -- uncompressed -- is pretty low on my list of 
> bloat concerns for multi-OMAP kernels.  If it were up to me, I'd just 
> change it to a u32 and be done with the problem for the foreseeable 
> future.

And then we're wasting that 1.6KB..
 
> > I wonder if we could #define CK_OMAP_DUMMY 0 that's always set
> > for non-shared clocks if they only get set in some *_data.c
> > file in a unique way?
> > 
> > Paul got any better ideas?
> 
> Aside from using u32?  Not really.  As we've discussed in the past, at 
> some point we should convert the clock initialization to using some kind 
> of per-SoC list.  But it doesn't seem worth spending too much time on that 
> while the common clock framework conversion is higher priority.

Right, let's do the ifdef else thing then.

Regards,

Tony
