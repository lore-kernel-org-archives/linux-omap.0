From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP3 DSS: Fixed FIFO buffer register field sizes
Date: Fri, 24 Oct 2008 12:24:48 -0700
Message-ID: <20081024192448.GH16354@atomide.com>
References: <1224658026-4334-1-git-send-email-ext-kalle.jokiniemi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:61905 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751278AbYJXTYv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Oct 2008 15:24:51 -0400
Content-Disposition: inline
In-Reply-To: <1224658026-4334-1-git-send-email-ext-kalle.jokiniemi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>
Cc: linux-omap@vger.kernel.org

* Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com> [081021 23:46]:
> The size status field in DISPC_[GFX | VID1 | VID2]_FIFO_SIZE_STATUS
> register is 11 bits wide in OMAP3, but only 9 bits were read. Similarly,
> the threshold field in DISPC_[GFX | VID1 | VID2]_FIFO_THRESHOLD register
> is 12 bits wide, while only 9 bits were written in it.
> 
> This patch extends the bit field sizes used in setup_plane_fifo to
> correspond to ones in OMAP3. In OMAP2 the extra bits are reserved, so no
> harm should come from extending the bit fields.

Pusing today.

Tony

> 
> Signed-off-by: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>
> ---
>  drivers/video/omap/dispc.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/omap/dispc.c b/drivers/video/omap/dispc.c
> index beda40b..c140c21 100644
> --- a/drivers/video/omap/dispc.c
> +++ b/drivers/video/omap/dispc.c
> @@ -290,7 +290,7 @@ static void setup_plane_fifo(int plane, int ext_mode)
>  	BUG_ON(plane > 2);
>  
>  	l = dispc_read_reg(fsz_reg[plane]);
> -	l &= FLD_MASK(0, 9);
> +	l &= FLD_MASK(0, 11);
>  	if (ext_mode) {
>  		low = l * 3 / 4;
>  		high = l;
> @@ -298,7 +298,7 @@ static void setup_plane_fifo(int plane, int ext_mode)
>  		low = l / 4;
>  		high = l * 3 / 4;
>  	}
> -	MOD_REG_FLD(ftrs_reg[plane], FLD_MASK(16, 9) | FLD_MASK(0, 9),
> +	MOD_REG_FLD(ftrs_reg[plane], FLD_MASK(16, 12) | FLD_MASK(0, 12),
>  			(high << 16) | low);
>  }
>  
> -- 
> 1.5.4.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
