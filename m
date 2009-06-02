From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [RFC][PATCH] OMAP3: add support for 2 SDRAM chip selects (was:
 Re: Beagleboard rev C memory timings & suspend/resume)
Date: Tue, 2 Jun 2009 17:40:13 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0906021724490.31531@utopia.booyaka.com>
References: <200904291553.49378.jpihet@mvista.com> <200905112110.34589.jpihet@mvista.com> <alpine.DEB.2.00.0905111416350.17514@utopia.booyaka.com> <200905261527.16648.jpihet@mvista.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:41627 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751343AbZFBXkM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Jun 2009 19:40:12 -0400
In-Reply-To: <200905261527.16648.jpihet@mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jpihet@mvista.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-omap <linux-omap@vger.kernel.org>

Hi Jean,

a minor request: it is easier to comment on these patches if they are 
included inline in the E-mail message, rather than attached.  That way 
code comments can be inlined in the reply.

On Tue, 26 May 2009, Jean Pihet wrote:

> Here is a patch for the SDRC 2nd CS support. It applies on top of the current 
> pm branch.

Thanks for doing this work.

> I have some questions:
> - Is it OK to copy the micron sdram params file to a new file with the 2 CSes 
> params? One could use a unique file with #ifdef SDRC_SUPPORT_2_CSES.

Is it possible for the SDRAM parameter files to remain unchanged, and to 
simply pass two struct omap_sdrc_params * to omap2_init_common_hw() and 
then to omap2_sdrc_init()?  Boards with only CS0 in use should pass NULL 
for the second omap_sdrc_params *.

So something like this (I realize the PM branch has additional parameters 
here also):

void __init omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
                                 struct omap_sdrc_params *sdrc_cs1)

Then:

void __init omap2_sdrc_init(struct omap_sdrc_params *sdrc_cs0,
                            struct omap_sdrc_params *sdrc_cs1)

I would prefer that approach.

It would also be good to avoid changing the SDRC CS1 parameters in the 
SRAM code if the board does not use CS1.  Maybe pass in a flag that 
indicates whether CS1 is in use, and if not, avoid programming those 
registers?  The (admittedly minor) overhead of loading the CS1 registers 
off the stack would be nice to avoid also.

> - Does the RX51 board have 2 sdram parts? If so I need to update the board 
> file as well.

Probably best if someone from Nokia handles this.


- Paul
