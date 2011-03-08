From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH V2 1/3] OMAP4: Enable 800 MHz and 1 GHz MPU-OPP
Date: Tue, 08 Mar 2011 07:33:16 +0530
Message-ID: <4D758E64.8010400@ti.com>
References: <1299318681-21348-1-git-send-email-shweta.gulati@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:60431 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752016Ab1CHCDY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Mar 2011 21:03:24 -0500
Received: by mail-vx0-f172.google.com with SMTP id 33so5070915vxg.31
        for <linux-omap@vger.kernel.org>; Mon, 07 Mar 2011 18:03:22 -0800 (PST)
In-Reply-To: <1299318681-21348-1-git-send-email-shweta.gulati@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shweta Gulati <shweta.gulati@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Shweta Gulati wrote, on 03/05/2011 03:21 PM:
> Almost all OMAP4 boards support OPP 800 MHz and OPP 1 GHz.
> Enable them in OPP Table. For small minority of boards which use
> OMAP4430-800 MHz device OPP 1GHz is not supported,
> OPP 1GHz should be disabled from board file.
>
> Signed-off-by: Shweta Gulati<shweta.gulati@ti.com>
> Cc: linux-arm-kernel@lists.infradead.org
> ---
>   arch/arm/mach-omap2/opp4xxx_data.c |    4 ++--
>   1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/opp4xxx_data.c b/arch/arm/mach-omap2/opp4xxx_data.c
> index 57f1498..93b9744 100644
> --- a/arch/arm/mach-omap2/opp4xxx_data.c
> +++ b/arch/arm/mach-omap2/opp4xxx_data.c
> @@ -71,9 +71,9 @@ static struct omap_opp_def __initdata omap44xx_opp_def_list[] = {
>   	/* MPU OPP2 - OPP100 */
>   	OPP_INITIALIZER("mpu", true, 600000000, OMAP4430_VDD_MPU_OPP100_UV),
>   	/* MPU OPP3 - OPP-Turbo */
> -	OPP_INITIALIZER("mpu", false, 800000000, OMAP4430_VDD_MPU_OPPTURBO_UV),
> +	OPP_INITIALIZER("mpu", true, 800000000, OMAP4430_VDD_MPU_OPPTURBO_UV),
>   	/* MPU OPP4 - OPP-SB */
> -	OPP_INITIALIZER("mpu", false, 1008000000, OMAP4430_VDD_MPU_OPPNITRO_UV),
> +	OPP_INITIALIZER("mpu", true, 1008000000, OMAP4430_VDD_MPU_OPPNITRO_UV),
>   	/* L3 OPP1 - OPP50 */
>   	OPP_INITIALIZER("l3_main_1", true, 100000000, OMAP4430_VDD_CORE_OPP50_UV),
>   	/* L3 OPP2 - OPP100, OPP-Turbo, OPP-SB */
Acked-by: Nishanth Menon <nm@ti.com>

-- 
Regards,
Nishanth Menon
