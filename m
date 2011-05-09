From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] omap: fix build when MTD_NAND_OMAP2 and
 TOUCHSCREEN_ADS7846 are disabled
Date: Mon, 9 May 2011 08:19:35 -0700
Message-ID: <20110509151935.GC11410@atomide.com>
References: <20110506072523.GA25670@atomide.com>
 <1304711893-24299-1-git-send-email-mike@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:16585 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750879Ab1EIPTj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 May 2011 11:19:39 -0400
Content-Disposition: inline
In-Reply-To: <1304711893-24299-1-git-send-email-mike@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Rapoport <mike@compulab.co.il>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Oleg Drokin <green@linuxhacker.ru>

* Mike Rapoport <mike@compulab.co.il> [110506 12:54]:
> Commits 5e6a64b36ce346b7a2d481ef9fa315290eb28e5e (omap: move detection of
> NAND CS to common-board-devices) and 96974a249b0cf3537f49115a59be67e2c54f315c
> (omap: consolidate touch screen initialization among different boards)
> break compilation when CONFIG_MTD_NAND_OMAP2 and
> CONFIG_TOUCHSCREEN_ADS7846 are not selected.
> Removing ifdefs and stubs from common-board-devices.h fixes the problem.
> 
> Signed-off-by: Mike Rapoport <mike@compulab.co.il>
> CC: Oleg Drokin <green@linuxhacker.ru>
> ---
> Hope this one is better.

Thanks, I'll fold this into your original patch.

Tony
