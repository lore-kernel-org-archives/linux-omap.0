From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH 2/4] omap4: l2x0: Override the default l2x0_disable
Date: Mon, 2 Aug 2010 17:48:11 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0323E686D4@dbde02.ent.ti.com>
References: <1280598348-4721-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45942 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752690Ab0HBMSS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Aug 2010 08:18:18 -0400
In-Reply-To: <1280598348-4721-1-git-send-email-santosh.shilimkar@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>

> diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
> index 13dc979..b557cc2 100644
> --- a/arch/arm/mach-omap2/omap4-common.c
> +++ b/arch/arm/mach-omap2/omap4-common.c

<snip>

> @@ -66,6 +73,12 @@ static int __init omap_l2_cache_init(void)
>  	 */
>  	l2x0_init(l2cache_base, 0x0e050000, 0xc0000fff);
>  
> +	/*
> +	 * Override default outer_cache.disable with a OMAP4
> +	 * specific one
> +	*/

Minor comment - you need a space before the '*'

> +	outer_cache.disable = omap4_l2x0_disable;
> +
>  	return 0;
>  }
>  early_initcall(omap_l2_cache_init);
