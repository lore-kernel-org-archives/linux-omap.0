From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [RFC/PATCH 7/7] ARM: OMAP: remove unused cpu_is_omap3530()
Date: Thu, 5 Jan 2012 11:07:36 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A8071965@DBDE01.ent.ti.com>
References: <1325726206-11199-1-git-send-email-khilman@ti.com>
 <1325726206-11199-8-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51075 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757216Ab2AELHm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Jan 2012 06:07:42 -0500
In-Reply-To: <1325726206-11199-8-git-send-email-khilman@ti.com>
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
> Subject: [RFC/PATCH 7/7] ARM: OMAP: remove unused cpu_is_omap3530()
> 
> The cpu_is_omap3530() macro is unused, remove.
> 
This also make sense, since 3530 is exactly same as 3430 and even we don't 
use cpu_is_omap3530 anywhere. 

This can also be submitted to the list independently.

Thanks,
Vaibhav

> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
>  arch/arm/plat-omap/include/plat/cpu.h |    3 ---
>  1 files changed, 0 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-
> omap/include/plat/cpu.h
> index 8d858c2..2c8e5ab 100644
> --- a/arch/arm/plat-omap/include/plat/cpu.h
> +++ b/arch/arm/plat-omap/include/plat/cpu.h
> @@ -290,7 +290,6 @@ IS_OMAP_TYPE(3517, 0x3517)
>  #define cpu_is_omap2422()		0
>  #define cpu_is_omap2423()		0
>  #define cpu_is_omap2430()		0
> -#define cpu_is_omap3530()		0
>  #define cpu_is_omap3517()		0
>  #define cpu_is_omap3430()		0
>  #define cpu_is_omap4430()		0
> @@ -344,7 +343,6 @@ IS_OMAP_TYPE(3517, 0x3517)
> 
>  #if defined(CONFIG_ARCH_OMAP3)
>  # undef cpu_is_omap3430
> -# undef cpu_is_omap3530
>  # undef cpu_is_omap3517
>  # undef cpu_is_ti81xx
>  # undef cpu_is_ti816x
> @@ -352,7 +350,6 @@ IS_OMAP_TYPE(3517, 0x3517)
>  # undef cpu_is_am33xx
>  # undef cpu_is_am335x
>  # define cpu_is_omap3430()		is_omap3430()
> -# define cpu_is_omap3530()		(cpu_is_omap3430())
>  # define cpu_is_omap3517()		is_omap3517()
>  # undef cpu_is_omap3630
>  # define cpu_is_omap3630()		is_omap363x()
> --
> 1.7.8.2

