From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 0/2] ARM: OMAP2+: PM: code consolidation for 3.4
Date: Thu, 2 Feb 2012 11:40:48 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1202021140060.586@utopia.booyaka.com>
References: <20120202093600.12509.35052.stgit@dusk> <87ty39cc7s.fsf@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:55941 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756406Ab2BBSkt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Feb 2012 13:40:49 -0500
In-Reply-To: <87ty39cc7s.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com, rnayak@ti.com

On Thu, 2 Feb 2012, Kevin Hilman wrote:

> Paul Walmsley <paul@pwsan.com> writes:
> 
> > Suspend + UART wakeup was tested on OMAP44xx BeagleBoard.  
> 
> I assume you meant Panda board?

Yep

> > On the OMAP35xx Beagleboard here, v3.3-rc2 doesn't seem to wake up
> > from suspend correctly with or without these patches, so I've only
> > boot-tested them on that platform.
> 
> I also tested idle & suspend + UART wakeup on 3430/n900, 3530/Overo.
> 
> Will add these to my cleanup queue for v3.4[1] after adding a Tested-by
> from Santosh.

Great.  Do you know what the deal is with suspend on 34xx?  I enabled 
ttyO2 wakeup and entered suspend, but serial traffic doesn't bring it out?


- Paul
