From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/3] n800-bt: include board-nokia.h
Date: Thu, 22 Jan 2009 18:10:13 -0800
Message-ID: <20090123021009.GL7172@atomide.com>
References: <20090122131602.18315.84862.stgit@tikku> <20090122131906.18315.2861.stgit@tikku>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:57517 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755177AbZAWCKP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Jan 2009 21:10:15 -0500
Content-Disposition: inline
In-Reply-To: <20090122131906.18315.2861.stgit@tikku>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kalle Valo <kalle.valo@nokia.com>
Cc: linux-omap@vger.kernel.org

* Kalle Valo <kalle.valo@nokia.com> [090122 05:20]:
> Fixes compilation error:
> 
> arch/arm/mach-omap2/board-n800-bt.c: In function 'n800_bt_init':
> arch/arm/mach-omap2/board-n800-bt.c:36: error: 'OMAP_TAG_NOKIA_BT' undeclared (first use in this function)
> arch/arm/mach-omap2/board-n800-bt.c:36: error: (Each undeclared identifier is reported only once
> arch/arm/mach-omap2/board-n800-bt.c:36: error: for each function it appears in.)
> arch/arm/mach-omap2/board-n800-bt.c:36: error: invalid application of 'sizeof' to incomplete type 'struct omap_bluetooth_config'

Thanks, pushing to l-o.

Tony

> Signed-off-by: Kalle Valo <kalle.valo@nokia.com>
> ---
> 
>  arch/arm/mach-omap2/board-n800-bt.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-n800-bt.c b/arch/arm/mach-omap2/board-n800-bt.c
> index 61afd2b..da3a7bb 100644
> --- a/arch/arm/mach-omap2/board-n800-bt.c
> +++ b/arch/arm/mach-omap2/board-n800-bt.c
> @@ -22,6 +22,7 @@
>  #include <linux/kernel.h>
>  #include <linux/platform_device.h>
>  #include <mach/board.h>
> +#include <mach/board-nokia.h>
>  
>  static struct platform_device n800_bt_device = {
>  	.name           = "hci_h4p",
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
