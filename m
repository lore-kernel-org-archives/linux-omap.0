From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: Fix relocation if image end past uncompressed
 kernel end
Date: Fri, 22 Apr 2011 09:09:41 +0300
Message-ID: <20110422060940.GA16892@atomide.com>
References: <1303272904-31392-1-git-send-email-nicolas.pitre@linaro.org>
 <20110420072156.GA28679@atomide.com>
 <alpine.LFD.2.00.1104200850030.24613@xanadu.home>
 <20110420165514.GE10402@atomide.com>
 <alpine.LFD.2.00.1104201318040.24613@xanadu.home>
 <20110421055945.GB13688@atomide.com>
 <20110421104954.GH13688@atomide.com>
 <alpine.LFD.2.00.1104210919070.24613@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:35040 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751569Ab1DVGJt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Apr 2011 02:09:49 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1104210919070.24613@xanadu.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Shawn Guo <shawn.guo@freescale.com>, linux-arm-kernel@lists.infradead.org, patches@linaro.org, Aaro Koskinen <aaro.koskinen@nokia.com>, linux-omap@vger.kernel.org

* Nicolas Pitre <nicolas.pitre@linaro.org> [110421 16:18]:
> On Thu, 21 Apr 2011, Tony Lindgren wrote:
> 
> > Otherwise we end up overwriting ourselves. This fixes booting
> > on n900 after commit 6d7d0ae51574943bf571d269da3243257a2d15db
> > (ARM: 6750/1: improvements to compressed/head.S).
> > 
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> I don't understand why this is needed.  The copy loop is explicitly 
> copying from the end going backward exactly to cope with this 
> possibility.
> 
> Hmmm...

Yeah that's what I'm wondering too.. This is probably not the
right fix.. I'm also wondering that it should be possible to
make uImage also not work by setting loadaddr just before the
uncompressed kernel end.

You would assume that only the running code would not survive
relocation if some of it gets overwritten. But that should be
only the beginning, no idea why the need to relocate all the
way after the whole image?

If stack was overlapping the zImage, I could see it corrupt
the zImage but there not much happening between relocating
and restarting of the bootloader.

Tony
