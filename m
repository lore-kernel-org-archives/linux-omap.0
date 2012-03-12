From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv5 0/6] ARM: OMAP3+: IO daisy chain support fixes
Date: Mon, 12 Mar 2012 12:00:27 +0200
Message-ID: <1331546427.2116.264.camel@sokoban>
References: <1331046702-2472-1-git-send-email-t-kristo@ti.com>
	 <alpine.DEB.2.00.1203092102450.30879@utopia.booyaka.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58490 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751389Ab2CLKAm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Mar 2012 06:00:42 -0400
In-Reply-To: <alpine.DEB.2.00.1203092102450.30879@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: rnayak@ti.com, linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org

On Fri, 2012-03-09 at 21:05 -0700, Paul Walmsley wrote:
> Hi
> 
> On Tue, 6 Mar 2012, Tero Kristo wrote:
> 
> > Changes compared to previous version:
> > 
> > - patch2:
> >   * fixed the timeout for waiting for ST_IO_CHAIN == 1
> >   * added clear for ST_IO_CHAIN bit (as per spec + implementation in patch 1)
> >   * replaced the timeout at the end of function with a simple register
> >     readback (timing out on a register value that we are clearing does
> >     not make that much sense, the bit is cleared the very first time CPU
> >     manages to read it)
> > - patch5:
> >   * added spinlock for protecting io_chain_trigger operation
> > 
> > Tested on omap3 beagle + omap4 blaze. Also did measurements for the
> > cost of IO chain trigger operation with ARM performance counters:
> > 
> > - omap3 approx 7...8us
> > - omap4 approx 2...4us
> 
> Thanks for the changes.  So as you probably already saw, a few changes 
> have been made.  The updated series is in the branch 
> 'io_chain_devel_3.4' on git://git.pwsan.com/linux-2.6.
> 
> The main outstanding question is whether the OMAP4 WUCLKOUT poll should be 
> removed to match the v5 changes to the OMAP3 function.  Please let me 
> know.   Any other testing or comments are of course welcome.

Just tested your branch with omap3 beagle + omap4 blaze (with my omap4
cswr set on top), and it works on both.

For the WUCLK poll bit I added detailed comments on patch 2 thread, but
my current understanding is that the implementation now on omap3 / omap4
is what they should be due to IP differences (except maybe the small
optimization for omap3 part you commented about.)

-Tero

