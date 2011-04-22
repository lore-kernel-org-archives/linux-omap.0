From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: Fix relocation if image end past uncompressed
 kernel end
Date: Thu, 21 Apr 2011 23:28:43 -0700
Message-ID: <20110422062843.GA841@atomide.com>
References: <1303272904-31392-1-git-send-email-nicolas.pitre@linaro.org>
 <20110420072156.GA28679@atomide.com>
 <alpine.LFD.2.00.1104200850030.24613@xanadu.home>
 <20110420165514.GE10402@atomide.com>
 <alpine.LFD.2.00.1104201318040.24613@xanadu.home>
 <20110421055945.GB13688@atomide.com>
 <20110421104954.GH13688@atomide.com>
 <alpine.LFD.2.00.1104210919070.24613@xanadu.home>
 <alpine.LFD.2.00.1104211711240.24613@xanadu.home>
 <alpine.LFD.2.00.1104212233170.24613@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:48901 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751583Ab1DVG2s (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Apr 2011 02:28:48 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1104212233170.24613@xanadu.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Shawn Guo <shawn.guo@freescale.com>, linux-arm-kernel@lists.infradead.org, patches@linaro.org, Aaro Koskinen <aaro.koskinen@nokia.com>, linux-omap@vger.kernel.org

* Nicolas Pitre <nicolas.pitre@linaro.org> [110421 20:20]:
> On Thu, 21 Apr 2011, Nicolas Pitre wrote:
> 
> > On Thu, 21 Apr 2011, Nicolas Pitre wrote:
> > 
> > > On Thu, 21 Apr 2011, Tony Lindgren wrote:
> > > 
> > > > Otherwise we end up overwriting ourselves. This fixes booting
> > > > on n900 after commit 6d7d0ae51574943bf571d269da3243257a2d15db
> > > > (ARM: 6750/1: improvements to compressed/head.S).
> > > > 
> > > > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > > 
> > > I don't understand why this is needed.  The copy loop is explicitly 
> > > copying from the end going backward exactly to cope with this 
> > > possibility.
> > 
> > I think your patch is 1) unneeded (see the copy loop code and the 
> > comment before it), and 2) simply hiding the real bug.

Yes so it seems, but it also seems that there is still something else wrong..

> > I just need to modify the code in compressed/misc.c slightly for the 
> > lzma decompressor to start or stop working randomly.  It seems that this 
> > code might be sensitive to slight displacement in memory caused by 
> > modifications to totally unrelated code.  I'm still trying to track this 
> > down.
> 
> I found the bugger.  The problem was a bad stack alignment.

.. as this patch won't solve the n900 booting problem with zImage.
With LZMA I'm still also getting "LZMA data is corrupt".

Regards,

Tony
