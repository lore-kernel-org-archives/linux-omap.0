From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RESENDING PATCH 1/4] ARM: OMAP: Add register defines for
	TWL4030 vaux1
Date: Fri, 16 May 2008 10:52:56 -0700
Message-ID: <20080516175256.GT23002@atomide.com>
References: <1210862562-5903-1-git-send-email-nskamat@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:53765 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754866AbYEPRwz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 May 2008 13:52:55 -0400
Content-Disposition: inline
In-Reply-To: <1210862562-5903-1-git-send-email-nskamat@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishant Kamat <nskamat@ti.com>
Cc: linux-omap@vger.kernel.org

* Nishant Kamat <nskamat@ti.com> [080515 07:45]:
> This patch adds the register defines for TWL4030 VAUX1.

Pushing.

Tony

> Signed-off-by: Nishant Kamat <nskamat@ti.com>
> ---
>  include/linux/i2c/twl4030.h |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/include/linux/i2c/twl4030.h b/include/linux/i2c/twl4030.h
> index 05d07f9..40af46e 100644
> --- a/include/linux/i2c/twl4030.h
> +++ b/include/linux/i2c/twl4030.h
> @@ -77,6 +77,8 @@
>  /* Offsets to Power Registers */
>  #define TWL4030_VDAC_DEV_GRP		0x3B
>  #define TWL4030_VDAC_DEDICATED		0x3E
> +#define TWL4030_VAUX1_DEV_GRP		0x17
> +#define TWL4030_VAUX1_DEDICATED		0x1A
>  #define TWL4030_VAUX2_DEV_GRP		0x1B
>  #define TWL4030_VAUX2_DEDICATED		0x1E
>  #define TWL4030_VAUX3_DEV_GRP		0x1F
> -- 
> 1.5.3.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
