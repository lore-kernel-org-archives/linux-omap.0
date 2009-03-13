From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/4] Clean-up for rx51
Date: Fri, 13 Mar 2009 11:07:07 -0700
Message-ID: <20090313180707.GQ19229@atomide.com>
References: <20090313180123.1548.1188.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:49340 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751112AbZCMSHH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Mar 2009 14:07:07 -0400
Received: from c-69-181-40-92.hsd1.ca.comcast.net ([69.181.40.92] helo=localhost.localdomain)
	by mho-01-bos.mailhop.org with esmtpa (Exim 4.68)
	(envelope-from <tony@atomide.com>)
	id 1LiBmi-00058i-JI
	for linux-omap@vger.kernel.org; Fri, 13 Mar 2009 18:07:05 +0000
Content-Disposition: inline
In-Reply-To: <20090313180123.1548.1188.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [090313 11:03]:
> Hi all,
> 
> Here are few patches against the l-o tree to clean-up rx51 board
> files. Also catch up with the mmc-twl4030 changes, and make
> the smc911x Ethernet work.

Correction, smc91x that is, not smc911x or smsc911x.
 
> Regards,
> 
> Tony
> 
> ---
> 
> David Brownell (3):
>       Hook up twl4030 regulators to the relevant RX51 MMC slots.
>       Bugfix to RX51 flash support:  this board has no NOR flash,
>       Clean-up rx51 a bit and set the regulators.
> 
> Tony Lindgren (1):
>       Set the smc91x timings for rx51
> 
> 
>  arch/arm/mach-omap2/board-rx51-flash.c       |   58 -----
>  arch/arm/mach-omap2/board-rx51-peripherals.c |  305 ++++++++++++++++++++++----
>  2 files changed, 262 insertions(+), 101 deletions(-)
> 
> -- 
> Signature
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
