From: Vladimir Pantelic <vladoman@gmail.com>
Subject: Re: [RFC][PATCH 2/9] OMAP4: HWMOD: make current hwmods common for
 4460 and 4430
Date: Mon, 30 May 2011 11:01:17 +0200
Message-ID: <4DE35CDD.30709@gmail.com>
References: <1306375016-707-1-git-send-email-nm@ti.com> <1306375016-707-3-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:54904 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752654Ab1E3JBU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 May 2011 05:01:20 -0400
Received: by bwz15 with SMTP id 15so2706183bwz.19
        for <linux-omap@vger.kernel.org>; Mon, 30 May 2011 02:01:19 -0700 (PDT)
In-Reply-To: <1306375016-707-3-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Aneesh V <aneesh@ti.com>

Nishanth Menon wrote:
> From: Aneesh V<aneesh@ti.com>
>
> Make all hwmod data used for OMAP4430 available for
> the OMAP44XX class so that OMAP4460 can use them.
> We will modify the required 4460 hwmod in further patch(es).
>
> [nm@ti.com: just rebased to .39]
> Signed-off-by: Nishanth Menon<nm@ti.com>
> Signed-off-by: Aneesh V<aneesh@ti.com>
> ---
>   arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  164 ++++++++++++++--------------
>   1 files changed, 82 insertions(+), 82 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> index abc548a..2f51a5a 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -124,7 +124,7 @@ static struct omap_hwmod omap44xx_dmm_hwmod = {
>   	.slaves_cnt	= ARRAY_SIZE(omap44xx_dmm_slaves),
>   	.mpu_irqs	= omap44xx_dmm_irqs,
>   	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_dmm_irqs),
> -	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
> +	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),

I guess at the time that CHIP_IS_OMAP4430 was introduced it was totally
unthinkable that another 44xx based chip would ever exist?

