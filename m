From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv2 02/19] ARM: OMAP4: Add SAR ROM base address
Date: Wed, 16 May 2012 11:28:17 -0700
Message-ID: <87zk98dlq6.fsf@ti.com>
References: <1336990730-26892-1-git-send-email-t-kristo@ti.com>
	<1336990730-26892-3-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:37418 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760179Ab2EPS2T (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 May 2012 14:28:19 -0400
Received: by dadz8 with SMTP id z8so1735367dad.35
        for <linux-omap@vger.kernel.org>; Wed, 16 May 2012 11:28:18 -0700 (PDT)
In-Reply-To: <1336990730-26892-3-git-send-email-t-kristo@ti.com> (Tero
	Kristo's message of "Mon, 14 May 2012 13:18:33 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

Tero Kristo <t-kristo@ti.com> writes:

> Added in preparation for device off mode. SAR ROM contains the mapping
> from SAR RAM to IO registers, and this will eventually be parsed during
> init time to do the reverse before device off.
>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

This should be combined with the patch that uses the #define.

Kevin

> ---
>  arch/arm/plat-omap/include/plat/omap44xx.h |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/plat-omap/include/plat/omap44xx.h b/arch/arm/plat-omap/include/plat/omap44xx.h
> index c0d478e..1a45700 100644
> --- a/arch/arm/plat-omap/include/plat/omap44xx.h
> +++ b/arch/arm/plat-omap/include/plat/omap44xx.h
> @@ -46,6 +46,7 @@
>  #define OMAP44XX_MCPDM_BASE		0x40132000
>  #define OMAP44XX_MCPDM_L3_BASE		0x49032000
>  #define OMAP44XX_SAR_RAM_BASE		0x4a326000
> +#define OMAP44XX_SAR_ROM_BASE		0x4a05e000
>  
>  #define OMAP44XX_MAILBOX_BASE		(L4_44XX_BASE + 0xF4000)
>  #define OMAP44XX_HSUSB_OTG_BASE		(L4_44XX_BASE + 0xAB000)
