From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap-mmc: Fix possible NULL pointer deref
Date: Wed, 2 Mar 2011 10:14:09 -0800
Message-ID: <20110302181409.GB20560@atomide.com>
References: <1298806697.30857.5.camel@marge>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:45928 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752168Ab1CBSOM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Mar 2011 13:14:12 -0500
Content-Disposition: inline
In-Reply-To: <1298806697.30857.5.camel@marge>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Michael Buesch <mb@bu3sch.de>
Cc: linux-omap <linux-omap@vger.kernel.org>

* Michael Buesch <mb@bu3sch.de> [110227 03:36]:
> Either OMAP_MMC_STAT_CARD_ERR or OMAP_MMC_STAT_END_OF_CMD might
> fire if there is no host->cmd pointer.
> Check for a valid host->cmd pointer before calling mmc_omap_cmd_done().
> 
> Signed-off-by: Michael Buesch <mb@bu3sch.de>

Can you please resend this to the MMC list?

Acked-by: Tony Lindgren <tony@atomide.com>
