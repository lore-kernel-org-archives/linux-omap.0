From: David Anders <x0132446@ti.com>
Subject: Re: [PATCH] OMAP4: Pandaboard: Fixing MMC card detect gpio line
Date: Wed, 08 Dec 2010 10:49:08 -0600
Message-ID: <4CFFB704.3030905@ti.com>
References: <1291723986-24658-1-git-send-email-raghuveer.murthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45725 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754306Ab0LHQtM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Dec 2010 11:49:12 -0500
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id oB8GnBEc026755
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 8 Dec 2010 10:49:11 -0600
In-Reply-To: <1291723986-24658-1-git-send-email-raghuveer.murthy@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Murthy, Raghuveer" <raghuveer.murthy@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 12/07/2010 06:13 AM, Murthy, Raghuveer wrote:
> The .gpio_cd member of omap2_hsmmc_info is not initialized. This
> will default to zero. On Pandaboard this interferes with gpio line
> assigned for powering TFP410 DVI chip.
>
> This fix was missed out in the previous commit bf56f0a6668cd, from
> Nishanth Menon
>
> Signed-off-by: Kishore Kadiyala<kishore.kadiyala@ti.com>
> Signed-off-by: Raghuveer Murthy<raghuveer.murthy@ti.com>
> Acked-by: Nishanth Menon<nm@ti.com>
>    

Tested-by: David Anders <x0132446@ti.com>

> ---
>   arch/arm/mach-omap2/board-omap4panda.c |    1 +
>   1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
> index ad6b5cc..0ccc24f 100644
> --- a/arch/arm/mach-omap2/board-omap4panda.c
> +++ b/arch/arm/mach-omap2/board-omap4panda.c
> @@ -142,6 +142,7 @@ static struct omap2_hsmmc_info mmc[] = {
>   		.mmc		= 1,
>   		.caps		= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA,
>   		.gpio_wp	= -EINVAL,
> +		.gpio_cd	= -EINVAL,
>   	},
>   	{}	/* Terminator */
>   };
>    

