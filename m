From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 14/16] ARM: omap: fix wrapped error messages in
 omap_hwmod.c
Date: Wed, 8 Feb 2012 12:25:42 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1202081225070.19286@utopia.booyaka.com>
References: <20120208163546.GA15849@n2100.arm.linux.org.uk> <E1RvAZK-0006Hi-Vm@rmk-PC.arm.linux.org.uk> <alpine.DEB.2.00.1202081039590.26892@utopia.booyaka.com> <20120208185407.GN29796@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:41386 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755715Ab2BHTZm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Feb 2012 14:25:42 -0500
In-Reply-To: <20120208185407.GN29796@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, =?ISO-8859-15?Q?Beno=EEt_Cousson?= <b-cousson@ti.com>, linux-arm-kernel@lists.infradead.org

On Wed, 8 Feb 2012, Tony Lindgren wrote:

> * Paul Walmsley <paul@pwsan.com> [120208 09:09]:
> > On Wed, 8 Feb 2012, Russell King - ARM Linux wrote:
> > 
> > > While trying to debug my OMAP platforms, they emitted this message:
> > > 
> > > omap_hwmod: %s: enabled state can only be entered from initialized, idle, or disabled state
> > > 
> > > The following backtrace said it was from a function called '_enable',
> > > which didn't provide much clue.  Grepping didn't find it either.
> > > 
> > > The message is wrapped, so unwrap the message so grep can find it.  Do
> > > the same for three other messages in this file.
> > > 
> > > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > 
> > Thanks, I'll queue this for 3.4.
> 
> Looks like Russell is willing to take potential flamage and argue
> this should go into -rc because of the hard to find message.
> 
> Care to ack instead, or do you have objections to this being
> merged during the -rc?

No objections.

Acked-by: Paul Walmsley <paul@pwsan.com>


- Paul
