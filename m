From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/7] NET: SMC911X: Driver works for SMC9211 too
Date: Fri, 2 May 2008 16:19:22 -0700
Message-ID: <20080502231922.GY8981@atomide.com>
References: <1209727441-4312-1-git-send-email-nskamat@ti.com> <1209727441-4312-2-git-send-email-nskamat@ti.com> <1209727441-4312-3-git-send-email-nskamat@ti.com> <1209727441-4312-4-git-send-email-nskamat@ti.com> <1209727441-4312-5-git-send-email-nskamat@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:59969 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932485AbYEBXTX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 May 2008 19:19:23 -0400
Content-Disposition: inline
In-Reply-To: <1209727441-4312-5-git-send-email-nskamat@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishant Kamat <nskamat@ti.com>
Cc: linux-omap@vger.kernel.org

* Nishant Kamat <nskamat@ti.com> [080502 04:26]:
> The smc911x driver can support SMC9211 also. This patch adds 9211
> in the table of supported chip ids, and fixes the ID verification
> to care about only 4 nibbles.

This patch should be sent via smc911x maintainer on appropriate
mailing list.

Tony

> Signed-off-by: Nishant Kamat <nskamat@ti.com>
> ---
>  drivers/net/smc911x.c |    4 ++--
>  drivers/net/smc911x.h |    5 ++++-
>  2 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/smc911x.c b/drivers/net/smc911x.c
> index 76cc1d3..00b9b3e 100644
> --- a/drivers/net/smc911x.c
> +++ b/drivers/net/smc911x.c
> @@ -1,6 +1,6 @@
>  /*
>   * smc911x.c
> - * This is a driver for SMSC's LAN911{5,6,7,8} single-chip Ethernet devices.
> + * Driver for SMSC's LAN9{115,116,117,118, 211} single-chip Ethernet devices.
>   *
>   * Copyright (C) 2005 Sensoria Corp
>   *	   Derived from the unified SMC91x driver by Nicolas Pitre
> @@ -1902,7 +1902,7 @@ static int __init smc911x_probe(struct net_device *dev, unsigned long ioaddr)
>  	 * recognize.	These might need to be added to later,
>  	 * as future revisions could be added.
>  	 */
> -	chip_id = SMC_GET_PN();
> +	chip_id = 0xffff & SMC_GET_PN();
>  	DBG(SMC_DEBUG_MISC, "%s: id probe returned 0x%04x\n", CARDNAME, chip_id);
>  	for(i=0;chip_ids[i].id != 0; i++) {
>  		if (chip_ids[i].id == chip_id) break;
> diff --git a/drivers/net/smc911x.h b/drivers/net/smc911x.h
> index 7defa63..a416c61 100644
> --- a/drivers/net/smc911x.h
> +++ b/drivers/net/smc911x.h
> @@ -1,5 +1,6 @@
>  /*------------------------------------------------------------------------
> - . smc911x.h - macros for SMSC's LAN911{5,6,7,8} single-chip Ethernet device.
> + . smc911x.h - macros for SMSC's LAN9{115,116,117,118,211} single-chip
> + . Ethernet device.
>   .
>   . Copyright (C) 2005 Sensoria Corp.
>   . Derived from the unified SMC91x driver by Nicolas Pitre
> @@ -608,6 +609,7 @@ smc_pxa_dma_outsw(struct device *dev, u_long ioaddr, u_long physaddr,
>  #define CHIP_9116	0x116
>  #define CHIP_9117	0x117
>  #define CHIP_9118	0x118
> +#define CHIP_9211	0x9211
>  
>  struct chip_id {
>  	u16 id;
> @@ -619,6 +621,7 @@ static const struct chip_id chip_ids[] =  {
>  	{ CHIP_9116, "LAN9116" },
>  	{ CHIP_9117, "LAN9117" },
>  	{ CHIP_9118, "LAN9118" },
> +	{ CHIP_9211, "LAN9211" },
>  	{ 0, NULL },
>  };
>  
> -- 
> 1.5.3.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
