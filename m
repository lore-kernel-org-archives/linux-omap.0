From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH v4 06/39] ARM: OMAP2+: onenand: return value in init function
Date: Tue, 01 May 2012 20:49:37 +0400
Message-ID: <4FA01421.9080808@mvista.com>
References: <cover.1335874494.git.afzal@ti.com> <91c09cb6a6cb5e87acdcc3f6100a87b4c2a3dd41.1335874494.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:37391 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751846Ab2EAQv2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 May 2012 12:51:28 -0400
Received: by lbbgm6 with SMTP id gm6so982339lbb.19
        for <linux-omap@vger.kernel.org>; Tue, 01 May 2012 09:51:26 -0700 (PDT)
In-Reply-To: <91c09cb6a6cb5e87acdcc3f6100a87b4c2a3dd41.1335874494.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Afzal Mohammed <afzal@ti.com>
Cc: tony@atomide.com, linux@arm.linux.org.uk, khilman@ti.com, balbi@ti.com, dwmw2@infradead.org, kyungmin.park@samsung.com, gregkh@linuxfoundation.org, nm@ti.com, grinberg@compulab.co.il, notasas@gmail.com, artem.bityutskiy@linux.intel.com, vimal.newwork@gmail.com, dbaryshkov@gmail.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org, linux-mtd@lists.infradead.org

Hello.

On 01-05-2012 16:20, Afzal Mohammed wrote:

> Modify board_onenand_init to return platform data. This
> would be required for boards to be able to pass it to
> gpmc driver so that it finally reaches onenand driver.

> Also un-static the function so that boards can use it.

> Signed-off-by: Afzal Mohammed<afzal@ti.com>
[...]

> diff --git a/arch/arm/mach-omap2/board-flash.h b/arch/arm/mach-omap2/board-flash.h
> index 052964c..75ba49f 100644
> --- a/arch/arm/mach-omap2/board-flash.h
> +++ b/arch/arm/mach-omap2/board-flash.h
> @@ -52,3 +52,15 @@ board_nand_init(struct mtd_partition *nand_parts,
>   	return NULL;
>   }
>   #endif
> +
> +#if defined(CONFIG_MTD_ONENAND_OMAP2) || \
> +		defined(CONFIG_MTD_ONENAND_OMAP2_MODULE)

    You can use IS_ENABLED(CONFIG_MTD_ONENAND_OMAP2) instead these two.

> +extern struct omap_onenand_platform_data * __init
> +board_onenand_init(struct mtd_partition *onenand_parts, u8 nr_parts, u8 cs);
> +#else
> +static inline struct omap_onenand_platform_data *
> +__init board_onenand_init(struct mtd_partition *nor_parts, u8 nr_parts, u8 cs)
> +{
> +	return NULL;
> +}
> +#endif

WBR, Sergei
