From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP: DISPC: Enable dispc wake up capability
Date: Wed, 20 Aug 2008 14:59:15 +0300
Message-ID: <20080820115914.GH29374@atomide.com>
References: <1218792684-4202-1-git-send-email-jouni.hogander@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:53625 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751569AbYHTNsw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Aug 2008 09:48:52 -0400
Content-Disposition: inline
In-Reply-To: <1218792684-4202-1-git-send-email-jouni.hogander@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jouni Hogander <jouni.hogander@nokia.com>
Cc: linux-omap@vger.kernel.org

* Jouni Hogander <jouni.hogander@nokia.com> [080815 12:51]:
> Without wakeup enable omap doesn't wake up on dispc interrupts. This
> causes problems in a case where mpu is in sleep state and dispc
> interrupt fires.

Pushing today.

Tony

> Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
> ---
>  drivers/video/omap/dispc.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/omap/dispc.c b/drivers/video/omap/dispc.c
> index 3d64314..d232ea9 100644
> --- a/drivers/video/omap/dispc.c
> +++ b/drivers/video/omap/dispc.c
> @@ -1393,10 +1393,10 @@ static int omap_dispc_init(struct omapfb_device *fbdev, int ext_mode,
>  		enable_digit_clocks(0);
>  	}
>  
> -	/* Enable smart idle and autoidle */
> +	/* Enable smart standby/idle, autoidle and wakeup */
>  	l = dispc_read_reg(DISPC_SYSCONFIG);
>  	l &= ~((3 << 12) | (3 << 3));
> -	l |= (2 << 12) | (2 << 3) | (1 << 0);
> +	l |= (2 << 12) | (2 << 3) | (1 << 2) | (1 << 0);
>  	dispc_write_reg(DISPC_SYSCONFIG, l);
>  	omap_writel(1 << 0, DSS_BASE + DSS_SYSCONFIG);
>  
> -- 
> 1.5.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
