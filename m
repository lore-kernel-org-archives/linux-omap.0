From: Paul Walmsley <paul@pwsan.com>
Subject: Re: Regressions for older OMAP3503 silicon
Date: Wed, 5 Oct 2011 12:01:03 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1110051157530.4611@utopia.booyaka.com>
References: <CABi1daE-7OdgL5BqaLrB+X64-cf+kQMyXv9eSZOE79bRt+fMPw@mail.gmail.com> <20111005162618.GA6324@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:50794 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935124Ab1JESBE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Oct 2011 14:01:04 -0400
In-Reply-To: <20111005162618.GA6324@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Hylands <dhylands@gmail.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

On Wed, 5 Oct 2011, Tony Lindgren wrote:

> * Dave Hylands <dhylands@gmail.com> [111004 23:41]:
>  
> > I then also had to modify drivers/mmc/card/block.c and initializing
> > disable_multi to 1 in the mmc_blk_issue_rw_rq function to get rid of
> > the following messages for every I/O request.
> > 
> > mmcblk0: retrying using single block read
> > mmcblk0: retrying using single block read
> > mmcblk0: retrying using single block read
> > mmcblk0: retrying using single block read
> > 
> > (since this revision of the silicon doesn't support multi-block MMC reads).
> 
> ..but this one is usually a problem muxing the MMC data lines.
> 
> Are you sure this revision only supports one data line?

Just as a data point, the MMC/SD/SDIO chapter of the OMAP35x TRM rev U 
(SPRUF98U, available from http://www.ti.com/litv/pdf/spruf98u ) mentions 
multiple block transfers quite often, so it seems likely that the IP block 
does support it.  It would be pretty surprising if the OMAP35x chips 
didn't use the same MMC IP block as the OMAP34xx chips.


- Paul
