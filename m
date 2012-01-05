From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [RFC/PATCH 5/7] ARM: OMAP: clock: remove unused CK_3505 flag
Date: Thu, 5 Jan 2012 11:06:43 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A807193F@DBDE01.ent.ti.com>
References: <1325726206-11199-1-git-send-email-khilman@ti.com>
 <1325726206-11199-6-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48687 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754932Ab2AELGw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Jan 2012 06:06:52 -0500
In-Reply-To: <1325726206-11199-6-git-send-email-khilman@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Paul Walmsley <paul@pwsan.com>


> -----Original Message-----
> From: Hilman, Kevin
> Sent: Thursday, January 05, 2012 6:47 AM
> To: linux-omap@vger.kernel.org
> Cc: Paul Walmsley; Hiremath, Vaibhav
> Subject: [RFC/PATCH 5/7] ARM: OMAP: clock: remove unused CK_3505 flag
> 
> This flag is no longer used since clock init all AM35x devices
> is now the same.
> 
This can be merged with 

ARM: OMAP3: clock data: replace 3503/3517 flag with AM35x flag for UART4

Thanks,
Vaibhav

> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
>  arch/arm/plat-omap/include/plat/clkdev_omap.h |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/include/plat/clkdev_omap.h
> b/arch/arm/plat-omap/include/plat/clkdev_omap.h
> index b299b8d..45afa4d 100644
> --- a/arch/arm/plat-omap/include/plat/clkdev_omap.h
> +++ b/arch/arm/plat-omap/include/plat/clkdev_omap.h
> @@ -34,7 +34,6 @@ struct omap_clk {
>  #define CK_243X		(1 << 5)	/* 243x, 253x */
>  #define CK_3430ES1	(1 << 6)	/* 34xxES1 only */
>  #define CK_3430ES2PLUS	(1 << 7)	/* 34xxES2, ES3, non-Sitara 35xx only
> */
> -#define CK_3505		(1 << 8)
>  #define CK_3517		(1 << 9)
>  #define CK_36XX		(1 << 10)	/* 36xx/37xx-specific clocks */
>  #define CK_443X		(1 << 11)
> @@ -44,7 +43,7 @@ struct omap_clk {
> 
> 
>  #define CK_34XX		(CK_3430ES1 | CK_3430ES2PLUS)
> -#define CK_AM35XX	(CK_3505 | CK_3517)	/* all Sitara AM35xx */
> +#define CK_AM35XX	CK_3517		/* all Sitara AM35xx */
>  #define CK_3XXX		(CK_34XX | CK_AM35XX | CK_36XX)
> 
> 
> --
> 1.7.8.2

