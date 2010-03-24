From: Deepak Chitriki <deepak.chitriki@ti.com>
Subject: Re: [PATCH 2/3] DSPBRIDGE: Fix obvious wrong comment formats in mbox
 migration
Date: Wed, 24 Mar 2010 14:12:01 -0500
Message-ID: <4BAA6401.7010603@ti.com>
References: <1269384510-1526-1-git-send-email-omar.ramirez@ti.com> <1269384510-1526-2-git-send-email-omar.ramirez@ti.com> <1269384510-1526-3-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38873 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932788Ab0CXTMG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Mar 2010 15:12:06 -0400
In-Reply-To: <1269384510-1526-3-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@gmail.com>, Ameya Palande <ameya.palande@nokia.com>, "Guzman Lugo, Fernando" <x0095840@ti.com>

Ramirez Luna, Omar wrote:
> Fix obvious wrong comment formats in mbox migration.
>
> Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com
> ---
>  drivers/dsp/bridge/wmd/_tiomap.h    |    2 +-
>  drivers/dsp/bridge/wmd/tiomap3430.c |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/dsp/bridge/wmd/_tiomap.h b/drivers/dsp/bridge/wmd/_tiomap.h
> index e853777..71ef731 100644
> --- a/drivers/dsp/bridge/wmd/_tiomap.h
> +++ b/drivers/dsp/bridge/wmd/_tiomap.h
> @@ -326,7 +326,7 @@ struct wmd_dev_context {
>  	u32 dw_dsp_start_add;	/* API Boot vector */
>  	u32 dw_internal_size;	/* Internal memory size */
>  
> -	struct omap_mbox *mbox;		/* Mail box handle*/
> +	struct omap_mbox *mbox;		/* Mail box handle */
>  
>  	/*
>  	 * Processor specific info is set when prog loaded and read from DCD.
> diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c b/drivers/dsp/bridge/wmd/tiomap3430.c
> index d90518a..a972ea2 100644
> --- a/drivers/dsp/bridge/wmd/tiomap3430.c
> +++ b/drivers/dsp/bridge/wmd/tiomap3430.c
> @@ -663,7 +663,7 @@ static dsp_status bridge_brd_start(struct wmd_dev_context *hDevContext,
>  					       ul_dsp_clk_addr, sizeof(u32), 0);
>  		}
>  		/*
> -		 *Enable Mailbox events and also drain any pending
> +		 * Enable Mailbox events and also drain any pending
>  		 * stale messages.
>  		 */
>  		dev_context->mbox = omap_mbox_get("dsp");
>   
Acked-by: Deepak Chitriki <deepak.chitriki@ti.com>

Deepak
