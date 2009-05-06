From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/7] Generic gpmc-onenand initialization, v3
Date: Wed, 6 May 2009 11:07:24 -0700
Message-ID: <20090506180722.GN5593@atomide.com>
References: <20090505002144.2894.25201.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:56042 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751401AbZEFSH2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 May 2009 14:07:28 -0400
Content-Disposition: inline
In-Reply-To: <20090505002144.2894.25201.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dedekind@infradead.org, juha.yrjola@solidboot.com, linux-omap@vger.kernel.org, adrian.hunter@nokia.com

* Tony Lindgren <tony@atomide.com> [090504 17:25]:
> Hi all,
> 
> Here's the whole series one more time, looks like I missed Juha
> from the recipients originally. After all it's mostly Juha's
> code! :)
> 
> To recap, this series creates a generic gpmc-onenand.c out of the
> board-n800-flash.c so we can get this init code to the mainline
> kernel. This series is against the linux-omap tree, the patch
> against the mainline tree will be posted later.

Pushing this series to linux-omap tree today.
 
> Regards,
> 
> Tony
> 
> ---
> 
> Tony Lindgren (7):
>       onenand_init: Clean-up for checkpatch.pl
>       onenand init: Convert omap3430sdp to use gpmc-onenand
>       onenand_init: Allow disabling sync read and write based on flags, v3
>       onenand init: Pass configuration data from board-*.c files
>       onenand init: Rename n800_* functions to gpmc_onenand_* functions
>       onenand init: Build gpmc-onenand.o based on CONFIG_MTD_ONENAND_OMAP2
>       onenand init: Rename board-n800-flash.c to gpmc-onenand.c
> 
> 
>  arch/arm/mach-omap2/Makefile                 |    7 +-
>  arch/arm/mach-omap2/board-3430sdp-flash.c    |   28 -------
>  arch/arm/mach-omap2/board-n800.c             |   50 ++++++++++++
>  arch/arm/mach-omap2/board-rx51-flash.c       |   21 -----
>  arch/arm/mach-omap2/board-rx51-peripherals.c |   47 ++++++++++++
>  arch/arm/mach-omap2/board-rx51.c             |    2 
>  arch/arm/mach-omap2/gpmc-onenand.c           |  105 ++++++++++++--------------
>  arch/arm/plat-omap/include/mach/board.h      |    8 --
>  arch/arm/plat-omap/include/mach/onenand.h    |   29 +++++++
>  9 files changed, 177 insertions(+), 120 deletions(-)
>  delete mode 100644 arch/arm/mach-omap2/board-rx51-flash.c
>  rename arch/arm/mach-omap2/{board-n800-flash.c => gpmc-onenand.c} (78%)
> 
> -- 
> Signature
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
