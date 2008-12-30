From: Jarkko Lavinen <jarkko.lavinen@nokia.com>
Subject: Re: Revert "OMAP: HSMMC: Implement scatter-gather emulation"
Date: Tue, 30 Dec 2008 11:47:31 +0200
Message-ID: <20081230094731.GA15520@angel.research.nokia.com>
References: <20081212020021.GH10664@atomide.com>
Reply-To: Jarkko Lavinen <jarkko.lavinen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:31799 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751156AbYL3Jru (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Dec 2008 04:47:50 -0500
Content-Disposition: inline
In-Reply-To: <20081212020021.GH10664@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Juha Yrjola <juha.yrjola@solidboot.com>, Adrian Hunter <ext-adrian.hunter@nokia.com>, linux-omap@vger.kernel.org

On Thu, Dec 11, 2008 at 06:00:23PM -0800, ext Tony Lindgren wrote:
> Looks like Juha's MMC scatter-gather patch breaks at least overo when
> using 4 data lines. It seems to work when using only 1 data line.

> Any ideas? Maybe some timings issue?

TI errata says there is a HW bug is multi-block reads causing
data CRC errors when the MMC clock is stopped and restarted.
This is now fixed in Omap 3430 es3.0.

Juha's patch increases the CRC errors when the FIFOs are more
likely filled during channel callback interrupt.  But the FIFOs
can be and are stopped also without SG emulation when bus is
busy.

On a test board with buggy HSMMC, the CRC error does not appear
at all if I have no load on the bus.  When I have full Linux
system running with bells and whistles, the CRC error occurs with
frequency of 0.4%. 

Retrying multi-block read in case of data CRC seems effective and
has never failed on the test board.  The performance penalty of the 
retry is obviously minimal.

Juha's patch would need to be modified to be conditionally
enabled only on es3.0 and used bounce buffer otherwise and teach
mmc_blk_issue_rq() to do retry.

Jarkko Lavinen
