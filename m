From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] arm: omap: fix build for 2430sdp
Date: Fri, 5 Sep 2008 09:31:17 -0700
Message-ID: <20080905163117.GC24202@atomide.com>
References: <1220112708-26556-1-git-send-email-me@felipebalbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:64583 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751090AbYIEQbU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Sep 2008 12:31:20 -0400
Content-Disposition: inline
In-Reply-To: <1220112708-26556-1-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: linux-omap@vger.kernel.org, Felipe Balbi <felipe.balbi@nokia.com>

* Felipe Balbi <me@felipebalbi.com> [080830 09:12]:
> From: Felipe Balbi <felipe.balbi@nokia.com>
> 
> Missing include file broke compilation for 2430sdp.

Pushing today.

Tony

> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> ---
>  arch/arm/mach-omap2/board-2430sdp.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
> index 64e76e8..94e202d 100644
> --- a/arch/arm/mach-omap2/board-2430sdp.c
> +++ b/arch/arm/mach-omap2/board-2430sdp.c
> @@ -20,6 +20,7 @@
>  #include <linux/mtd/partitions.h>
>  #include <linux/delay.h>
>  #include <linux/input.h>
> +#include <linux/i2c/twl4030.h>
>  #include <linux/err.h>
>  #include <linux/clk.h>
>  #include <linux/spi/spi.h>
> -- 
> 1.6.0.1.141.g445ca
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
