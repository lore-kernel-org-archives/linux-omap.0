From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 14/16] ARM: omap: fix wrapped error messages in
 omap_hwmod.c
Date: Wed, 8 Feb 2012 10:54:08 -0800
Message-ID: <20120208185407.GN29796@atomide.com>
References: <20120208163546.GA15849@n2100.arm.linux.org.uk>
 <E1RvAZK-0006Hi-Vm@rmk-PC.arm.linux.org.uk>
 <alpine.DEB.2.00.1202081039590.26892@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:15585 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756942Ab2BHSyN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Feb 2012 13:54:13 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1202081039590.26892@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, =?utf-8?Q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>, linux-arm-kernel@lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [120208 09:09]:
> On Wed, 8 Feb 2012, Russell King - ARM Linux wrote:
> 
> > While trying to debug my OMAP platforms, they emitted this message:
> > 
> > omap_hwmod: %s: enabled state can only be entered from initialized, idle, or disabled state
> > 
> > The following backtrace said it was from a function called '_enable',
> > which didn't provide much clue.  Grepping didn't find it either.
> > 
> > The message is wrapped, so unwrap the message so grep can find it.  Do
> > the same for three other messages in this file.
> > 
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> Thanks, I'll queue this for 3.4.

Looks like Russell is willing to take potential flamage and argue
this should go into -rc because of the hard to find message.

Care to ack instead, or do you have objections to this being
merged during the -rc?

Regards,

Tony
