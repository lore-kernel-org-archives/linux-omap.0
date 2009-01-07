From: Tony Lindgren <tony@atomide.com>
Subject: Re: Revert "OMAP: HSMMC: Implement scatter-gather emulation"
Date: Wed, 7 Jan 2009 16:02:02 +0200
Message-ID: <20090107140200.GO27566@atomide.com>
References: <20081212020021.GH10664@atomide.com> <20081230094731.GA15520@angel.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:49696 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756695AbZAGOCG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Jan 2009 09:02:06 -0500
Content-Disposition: inline
In-Reply-To: <20081230094731.GA15520@angel.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Lavinen <jarkko.lavinen@nokia.com>
Cc: Juha Yrjola <juha.yrjola@solidboot.com>, Adrian Hunter <ext-adrian.hunter@nokia.com>, linux-omap@vger.kernel.org

* Jarkko Lavinen <jarkko.lavinen@nokia.com> [081230 11:47]:
> On Thu, Dec 11, 2008 at 06:00:23PM -0800, ext Tony Lindgren wrote:
> > Looks like Juha's MMC scatter-gather patch breaks at least overo when
> > using 4 data lines. It seems to work when using only 1 data line.
> 
> > Any ideas? Maybe some timings issue?
> 
> TI errata says there is a HW bug is multi-block reads causing
> data CRC errors when the MMC clock is stopped and restarted.
> This is now fixed in Omap 3430 es3.0.
> 
> Juha's patch increases the CRC errors when the FIFOs are more
> likely filled during channel callback interrupt.  But the FIFOs
> can be and are stopped also without SG emulation when bus is
> busy.
> 
> On a test board with buggy HSMMC, the CRC error does not appear
> at all if I have no load on the bus.  When I have full Linux
> system running with bells and whistles, the CRC error occurs with
> frequency of 0.4%. 
> 
> Retrying multi-block read in case of data CRC seems effective and
> has never failed on the test board.  The performance penalty of the 
> retry is obviously minimal.
> 
> Juha's patch would need to be modified to be conditionally
> enabled only on es3.0 and used bounce buffer otherwise and teach
> mmc_blk_issue_rq() to do retry.

Thanks for the info. Jarkko, do you mind putting together a omap mmc
git branch against the mainline kernel once the hsmmc driver is
integrated?

Once the hsmmc.c is in the mainline tree, I'd like to switch to the
mainline version of drivers/mmc and then just keep merging in your mmc
queue as needed.

That way you could then send the mmc patches via LKML to Pierre,
and I could get out of the MMC loop ;)

Regards,

Tony

