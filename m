From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/3] Some am3517 related patches [V4]
Date: Fri, 14 May 2010 14:30:28 -0700
Message-ID: <20100514213027.GG3428@atomide.com>
References: <1273754371-26014-1-git-send-email-stanley.miao@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:59404 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752787Ab0ENVa3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 May 2010 17:30:29 -0400
Content-Disposition: inline
In-Reply-To: <1273754371-26014-1-git-send-email-stanley.miao@windriver.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Stanley.Miao" <stanley.miao@windriver.com>
Cc: linux-omap@vger.kernel.org

* Stanley.Miao <stanley.miao@windriver.com> [100513 05:24]:
> Changes from V3:
> 1, refresh the the patches against the current omap-for-linus branch
> 2, Added "features" in mmc->slot[i].
> 
> Stanley.Miao (3):
>       AM3517: rename the i2c boardinfo to make it more readable
>       omap: init the gpio pinmux for mmc
>       omap hsmmc: fix the hsmmc driver for am3517
> 
>  arch/arm/mach-omap2/board-am3517evm.c |   20 ++++++++++----------
>  arch/arm/mach-omap2/devices.c         |    9 +++++++++
>  arch/arm/mach-omap2/hsmmc.c           |   27 +++++++++++++++++++++------
>  arch/arm/plat-omap/include/plat/mmc.h |    4 ++++
>  4 files changed, 44 insertions(+), 16 deletions(-)

Thanks, I've added all three into omap for-next branch.

Regards,

Tony 
