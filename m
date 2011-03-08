From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH V2 3/3] OMAP4: Add IVA OPP enteries.
Date: Tue, 08 Mar 2011 07:37:49 +0530
Message-ID: <4D758F75.6090807@ti.com>
References: <1299318746-21438-1-git-send-email-shweta.gulati@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:34866 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932470Ab1CHCII (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Mar 2011 21:08:08 -0500
Received: by mail-vw0-f47.google.com with SMTP id 4so5217744vws.34
        for <linux-omap@vger.kernel.org>; Mon, 07 Mar 2011 18:08:07 -0800 (PST)
In-Reply-To: <1299318746-21438-1-git-send-email-shweta.gulati@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shweta Gulati <shweta.gulati@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Shweta Gulati wrote, on 03/05/2011 03:22 PM:
> This Patch adds OPP enteries for IVA  in OMAP4 OPP Table
>
> Tested on OMAP4430 SDP Board.
>
> Signed-off-by: Shweta Gulati<shweta.gulati@ti.com>
> Cc: linux-arm-kernel@lists.infradead.org
> ---
>   arch/arm/mach-omap2/opp4xxx_data.c |    8 +++++++-
>   1 files changed, 7 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/opp4xxx_data.c b/arch/arm/mach-omap2/opp4xxx_data.c
> index 36a4517..ba5eddd 100644
> --- a/arch/arm/mach-omap2/opp4xxx_data.c
> +++ b/arch/arm/mach-omap2/opp4xxx_data.c
> @@ -78,7 +78,13 @@ static struct omap_opp_def __initdata omap44xx_opp_def_list[] = {
>   	OPP_INITIALIZER("l3_main_1", true, 100000000, OMAP4430_VDD_CORE_OPP50_UV),
>   	/* L3 OPP2 - OPP100, OPP-Turbo, OPP-SB */
>   	OPP_INITIALIZER("l3_main_1", true, 200000000, OMAP4430_VDD_CORE_OPP100_UV),
> -	/* TODO: add IVA, DSP, aess, fdif, gpu */
> +	/* IVA OPP1 - OPP50 */
> +	OPP_INITIALIZER("iva", true, 133000000, OMAP4430_VDD_IVA_OPP50_UV),
> +	/* IVA OPP2 - OPP100 */
> +	OPP_INITIALIZER("iva", true, 266100000, OMAP4430_VDD_IVA_OPP100_UV),
> +	/* IVA OPP3 - OPP-Turbo */
> +	OPP_INITIALIZER("iva", false, 332000000, OMAP4430_VDD_IVA_OPPTURBO_UV),
> +	/* TODO: add DSP, aess, fdif, gpu */
>   };
>
>   /**
Acked-by: Nishanth Menon <nm@ti.com>

-- 
Regards,
Nishanth Menon
