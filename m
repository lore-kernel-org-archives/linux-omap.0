From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: Fix populating the hwmod data from device
 tree
Date: Thu, 5 Dec 2013 16:25:48 -0800
Message-ID: <20131206002547.GK26766@atomide.com>
References: <20131120025620.GF10317@atomide.com>
 <20131120181255.GG10317@atomide.com>
 <20131120192209.GI10317@atomide.com>
 <alpine.DEB.2.02.1311202148160.30143@utopia.booyaka.com>
 <20131121000533.GJ10317@atomide.com>
 <20131121014555.GL10317@atomide.com>
 <20131121204814.GC10023@atomide.com>
 <20131205172909.GB26766@atomide.com>
 <alpine.DEB.2.02.1312060006510.26450@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:49921 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757063Ab3LFAZx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Dec 2013 19:25:53 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1312060006510.26450@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>

* Paul Walmsley <paul@pwsan.com> [131205 16:09]:
> On Thu, 5 Dec 2013, Tony Lindgren wrote:
> 
> > * Tony Lindgren <tony@atomide.com> [131121 12:49]:
> > > * Tony Lindgren <tony@atomide.com> [131120 17:46]:
> > > > * Tony Lindgren <tony@atomide.com> [131120 16:06]:
> > > > > 
> > > > > They at least had interrupts listed looking at commit 3b9b10. Probably
> > > > > the thing to do for now is to revert those changes, and see if we can
> > > > > just remove the L3 entries from the .dtsi files.
> > > > 
> > > > Actually the patch I posted should be able to handle also the
> > > > ti,hwmods = "l3_main_1", "l3_main_2", "l3_main_3" property in omap4.dtsi,
> > > > but we're not currently parsing that as we only look at the children
> > > > and not the properties of the OCP bus. Should be fixable, will take a look
> > > > tomorrow if this approach makes sense to you.
> > > 
> > > OK this one seems to do the right thing for me.
> > 
> > No comments? I'll queue the patch below to the fixes, please yell
> > if you see any issues with that.
> 
> Looks reasonable to me based on a quick glance:
> 
> Acked-by: Paul Walmsley <paul@pwsan.com>
> 
> Have not tested it though.

OK thanks for looking. I've used it with my mach-omap2 DT patches for past
few weeks on various boards without issues.
 
> I like the warning message for the bad data.

:)

Tony
