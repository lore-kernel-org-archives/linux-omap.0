From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP baseline test results for v3.9-rc3
Date: Tue, 2 Apr 2013 20:25:24 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1304022006360.31045@utopia.booyaka.com>
References: <alpine.DEB.2.00.1303181536230.29332@utopia.booyaka.com>  <51482707.6020501@ti.com> <1363684373.15426.137.camel@sokoban>  <alpine.DEB.2.00.1303261829440.23957@utopia.booyaka.com> <1364375463.3146.9.camel@sokoban>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:50349 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761031Ab3DBUZZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Apr 2013 16:25:25 -0400
In-Reply-To: <1364375463.3146.9.camel@sokoban>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@deeprootsystems.com

Hi

On Wed, 27 Mar 2013, Tero Kristo wrote:

> On Tue, 2013-03-26 at 18:43 +0000, Paul Walmsley wrote:
>
> > So what I'd like you to do is:
> > 
> > 1. Determine what devices are remaining to be reset and idled on OMAP4 
> >    with the bootloader that I use.  As far as I know, there are only four 
> >    that block full-chip idle: M3, DSP, SL2IF, FSUSB
> > 
> > 2. Determine what's needed to reset and idle them.  For the M3 and DSP, 
> >    I'd assume this involves pointing the reset vector for those 
> >    processors at a few lines of code that basically enter WFI or the C64x 
> >    equivalent.
> 
> This is the nasty part. We need firmware support for the blocks to do
> this, and this is imo a complete overkill for the task at hand, as it
> will duplicate the DSP + M3 firmware and drivers at least partially.

Why can't the DSP & M3 go straight from the reset vector to WFI (or the 
C64x equivalent?)  The M3s might need a couple of additional instructions 
to program DEEPSLEEP mode.  What other significant additional code is 
needed for those processors?

> If there was a simple way to do this, don't you think this would have
> been done already a year back when we started to discuss this first
> time? 

No, I don't think it has anything to do with the simplicity of the task.  
My sense is that no one at TI wants to work on it.  I can sympathize, but 
all of us who work on upstream Linux do things that we'd rather not do, 
for a more stable or more maintainable kernel.

So the first thing that should be done is to figure out whether the 
situation is really as bad as was suggested above.  Doesn't it seem 
unlikely that it would be necessary to "duplicate the firmware" -- which 
does much more than just idle the DSP & M3 -- just to put those subsystems 
into idle?

There's also the reset of the FSUSB IP block, which shouldn't need any 
firmware.  Who's going to work on that one?


- Paul
