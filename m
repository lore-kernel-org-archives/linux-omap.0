From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP: kill all section mismatch warning for
 omap2plus_defconfig
Date: Fri, 17 Dec 2010 17:26:54 -0800
Message-ID: <20101218012653.GF5941@atomide.com>
References: <1291776085-9538-1-git-send-email-bryan.wu@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:40191 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756774Ab0LRB06 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Dec 2010 20:26:58 -0500
Content-Disposition: inline
In-Reply-To: <1291776085-9538-1-git-send-email-bryan.wu@canonical.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Bryan Wu <bryan.wu@canonical.com>
Cc: paul@pwsan.com, linux-omap@vger.kernel.org

* Bryan Wu <bryan.wu@canonical.com> [101207 18:31]:
> This patch will kill following section mismatch warnings:
...

> --- a/arch/arm/mach-omap2/board-2430sdp.c
> +++ b/arch/arm/mach-omap2/board-2430sdp.c
> @@ -135,7 +135,7 @@ static inline void board_smc91x_init(void)
>  
>  #endif
>  
> -static struct omap_board_config_kernel sdp2430_config[] = {
> +static struct omap_board_config_kernel sdp2430_config[] __initdata = {
>  	{OMAP_TAG_LCD, &sdp2430_lcd_config},
>  };
>  

Thanks merging this. Note that the OMAP_TAG_LCD stuff should be
replaced with just platform_data.

Regards,

Tony
