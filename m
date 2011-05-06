From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap: fix build when MTD_NAND_OMAP2 and
 TOUCHSCREEN_ADS7846 are disabled
Date: Fri, 6 May 2011 00:25:23 -0700
Message-ID: <20110506072523.GA25670@atomide.com>
References: <1304515622-25113-1-git-send-email-mike@compulab.co.il>
 <53A11D3C-4DBA-4772-AF14-3590772F6AA1@linuxhacker.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:60281 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753086Ab1EFHZ2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 May 2011 03:25:28 -0400
Content-Disposition: inline
In-Reply-To: <53A11D3C-4DBA-4772-AF14-3590772F6AA1@linuxhacker.ru>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Oleg Drokin <green@linuxhacker.ru>
Cc: Mike Rapoport <mike@compulab.co.il>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Oleg Drokin <green@linuxhacker.ru> [110504 08:59]:
> Hello!
> 
> On May 4, 2011, at 9:27 AM, Mike Rapoport wrote:
> 
> > Commits 5e6a64b36ce346b7a2d481ef9fa315290eb28e5e (omap: move detection of
> > NAND CS to common-board-devices) and 96974a249b0cf3537f49115a59be67e2c54f315c
> > (omap: consolidate touch screen initialization among different boards)
> > break compilation when CONFIG_MTD_NAND_OMAP2 and
> > CONFIG_TOUCHSCREEN_ADS7846 are not selected.
> > Removing ifdefs and stubs from common-board-devices.h fixes the problem.
> 
> Works for me.

We should not build in code unnecessarily unless the boards has
ads7847. Many boards don't have it.

So how about do the ifdef optimization for ads7846_spi_board_info
and omap_ads7846_init in common-board-devices.c?

That keeps the header clean and the we have all the code in one
place in a way where it's optimized out if not selected.

Regards,

Tony
