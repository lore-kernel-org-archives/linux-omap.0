From: Paul Walmsley <paul@pwsan.com>
Subject: RE: handling clock nodes with both parent and divider selection
Date: Tue, 1 Feb 2011 09:33:04 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1102010931530.16671@utopia.booyaka.com>
References: <045d24bba9bbbe9fa47f0f8aa9901b7e@mail.gmail.com> <alpine.DEB.2.00.1101311610060.16671@utopia.booyaka.com> <a42717ae46ffbd2f8b30cca9ad559d93@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:32950 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751503Ab1BAQdF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Feb 2011 11:33:05 -0500
In-Reply-To: <a42717ae46ffbd2f8b30cca9ad559d93@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org

On Tue, 1 Feb 2011, Rajendra Nayak wrote:

> > -----Original Message-----
> > From: Paul Walmsley [mailto:paul@pwsan.com]
> > Sent: Tuesday, February 01, 2011 4:43 AM
>
> > At some point in the future, hopefully we'll be able to split all of the
> > multiplexers and dividers into their own struct clks, or struct
> omap_clks,
> > or something, so we don't have to implement these hacks.  As I
> understand
> > it, that would be closer to the actual hardware, anyway.  The right time
> > to do that would be after the clktype conversion...
> 
> Ok, I am not completely sure what clktype conversion means, but will 
> wait for it.

I'd suggest not waiting for it, but implementing something now, similar to 
OMAP3, if it won't be too big of a hack.


- Paul
