From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP2+: Fix populating the hwmod data from device
 tree
Date: Fri, 6 Dec 2013 00:07:50 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1312060006510.26450@utopia.booyaka.com>
References: <20131120025620.GF10317@atomide.com> <20131120181255.GG10317@atomide.com> <20131120192209.GI10317@atomide.com> <alpine.DEB.2.02.1311202148160.30143@utopia.booyaka.com> <20131121000533.GJ10317@atomide.com> <20131121014555.GL10317@atomide.com>
 <20131121204814.GC10023@atomide.com> <20131205172909.GB26766@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:45469 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751181Ab3LFAHv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Dec 2013 19:07:51 -0500
In-Reply-To: <20131205172909.GB26766@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, =?ISO-8859-15?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>

On Thu, 5 Dec 2013, Tony Lindgren wrote:

> * Tony Lindgren <tony@atomide.com> [131121 12:49]:
> > * Tony Lindgren <tony@atomide.com> [131120 17:46]:
> > > * Tony Lindgren <tony@atomide.com> [131120 16:06]:
> > > > 
> > > > They at least had interrupts listed looking at commit 3b9b10. Probably
> > > > the thing to do for now is to revert those changes, and see if we can
> > > > just remove the L3 entries from the .dtsi files.
> > > 
> > > Actually the patch I posted should be able to handle also the
> > > ti,hwmods = "l3_main_1", "l3_main_2", "l3_main_3" property in omap4.dtsi,
> > > but we're not currently parsing that as we only look at the children
> > > and not the properties of the OCP bus. Should be fixable, will take a look
> > > tomorrow if this approach makes sense to you.
> > 
> > OK this one seems to do the right thing for me.
> 
> No comments? I'll queue the patch below to the fixes, please yell
> if you see any issues with that.

Looks reasonable to me based on a quick glance:

Acked-by: Paul Walmsley <paul@pwsan.com>

Have not tested it though.

I like the warning message for the bad data.


- Paul
