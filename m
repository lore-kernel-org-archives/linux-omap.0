From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH V2 14/14] ARM: OMAP4: hwmod data: Clean up the data file
Date: Sat, 8 Jun 2013 09:57:20 -0700
Message-ID: <20130608165719.GT3331@atomide.com>
References: <1370606175-22599-1-git-send-email-r.sricharan@ti.com>
 <alpine.DEB.2.02.1306071230500.5589@utopia.booyaka.com>
 <20130607162927.GA3331@atomide.com>
 <20130607175005.GB3331@atomide.com>
 <51B22303.2000002@ti.com>
 <20130607183748.GF3331@atomide.com>
 <51B22A1D.6020603@ti.com>
 <51B35FCB.5010801@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:38882 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752212Ab3FHQ5X (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 8 Jun 2013 12:57:23 -0400
Content-Disposition: inline
In-Reply-To: <51B35FCB.5010801@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sricharan R <r.sricharan@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rnayak@ti.com, b-cousson@ti.com, t-kristo@ti.com, ambresh@ti.com

* Sricharan R <r.sricharan@ti.com> [130608 09:52]:
> On Saturday 08 June 2013 12:14 AM, Santosh Shilimkar wrote:
> > On Friday 07 June 2013 02:37 PM, Tony Lindgren wrote:
> >>
> >> Looking at the diff output with and without, it seems to be that the
> >> DMA channels won't get configured.
> >>
> > That should work since DMA engine changes are in mainline and the
> > DMA channel information is already in DT.
> >
>  The issue is that mmc, spi drivers try to get the 'dma' request number from
>  get_platform_resource, which fails if hwmod has not populated the data.
> 
>  There are patches  already from Balaji [1] for hsmmc, Matt Porter [2] mcspi
>  for adapting the drivers for Dma engine. Dma engine gets the data from DT.
> 
>       [1] http://comments.gmane.org/gmane.linux.kernel.mmc/20378
>       [2] http://www.spinics.net/lists/linux-omap/msg87634.html
> 
>        [1] is already in  mmc-next for 3.10 branch.
> 
>   Then one more patch for spi [3] is required for completing this. This is similar
>    to the patch done for mmc to skip the get_platform_resource call in case of DT.
> 
>   [3] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg90112.html

OK thanks for looking into that. Once those driver changes hit
mainline, please send a follow-up patch to remove the spi and
mmc entries.

Regards,

Tony
