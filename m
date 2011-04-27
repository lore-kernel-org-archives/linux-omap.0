From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: Fix bad SP address after relocating kernel
Date: Wed, 27 Apr 2011 00:48:33 -0700
Message-ID: <20110427074833.GD3755@atomide.com>
References: <20110421055945.GB13688@atomide.com>
 <20110421104954.GH13688@atomide.com>
 <alpine.LFD.2.00.1104210919070.24613@xanadu.home>
 <alpine.LFD.2.00.1104211711240.24613@xanadu.home>
 <alpine.LFD.2.00.1104212233170.24613@xanadu.home>
 <20110422062843.GA841@atomide.com>
 <alpine.LFD.2.00.1104220959440.24613@xanadu.home>
 <20110426085700.GJ16892@atomide.com>
 <20110426123746.GC3755@atomide.com>
 <alpine.LFD.2.00.1104261700270.24613@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:55245 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751295Ab1D0Hsm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Apr 2011 03:48:42 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1104261700270.24613@xanadu.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Shawn Guo <shawn.guo@freescale.com>, linux-arm-kernel@lists.infradead.org, patches@linaro.org, Aaro Koskinen <aaro.koskinen@nokia.com>, linux-omap@vger.kernel.org

* Nicolas Pitre <nicolas.pitre@linaro.org> [110426 14:28]:
> On Tue, 26 Apr 2011, Tony Lindgren wrote:
> 
> > Otherwise cache_clean_flush can overwrite some of the relocated
> > area depending on where the kernel image gets loaded. This fixes
> > booting on n900 after commit 6d7d0ae51574943bf571d269da3243257a2d15db
> > (ARM: 6750/1: improvements to compressed/head.S).
> 
> Gaaaah.  Indeed.
> 
> > Thanks to Aaro Koskinen <aaro.koskinen@nokia.com> for debugging
> > the address of the relocated area that gets corrupted, and to
> > Nicolas Pitre <nicolas.pitre@linaro.org> for the other uncompress
> > related fixes.
> > 
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> I think there could be a better fix yet.  Could you test this patch:

Cool that works too and avoids using the stack, so that's a better fix:

Tested-by: Tony Lindgren <tony@atomide.com>
