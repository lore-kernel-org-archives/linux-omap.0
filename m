From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v3 1/2] omap: introduce uart_no_empty_fifo_read feature
Date: Fri, 20 Nov 2009 10:09:49 -0600
Message-ID: <4B06BF4D.2090201@ti.com>
References: <1258732956-18799-1-git-send-email-vikram.pandita@ti.com> <1258732956-18799-2-git-send-email-vikram.pandita@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42602 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753889AbZKTQJr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Nov 2009 11:09:47 -0500
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id nAKG9rWW005792
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 20 Nov 2009 10:09:53 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id nAKG9n0T002146
	for <linux-omap@vger.kernel.org>; Fri, 20 Nov 2009 10:09:49 -0600 (CST)
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id nAKG9nLk010767
	for <linux-omap@vger.kernel.org>; Fri, 20 Nov 2009 10:09:49 -0600 (CST)
In-Reply-To: <1258732956-18799-2-git-send-email-vikram.pandita@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vikram Pandita <vikram.pandita@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Vikram Pandita had written, on 11/20/2009 10:02 AM, the following:
> Interoduce omap feature OMAP3_HAS_UART_NO_EMPTY_FIFO_READ
    ^^^^^^^^^ <- you meant introduce
> 
> On omap3630/omap4 an empty fifo read causes a crash
> 
> Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
> Ack-by: Menon, Nishanth <nm@ti.com>
    ^^^^^ <- :P nope you dont have my Acked-by until you change this to 
Acked from Ack ;)..

Thanks for the simpler patch.

> ---
>  arch/arm/mach-omap2/id.c              |    7 +++++++
>  arch/arm/plat-omap/include/plat/cpu.h |    2 ++
>  2 files changed, 9 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
> index f48a4b2..3e266cd 100644
> --- a/arch/arm/mach-omap2/id.c
> +++ b/arch/arm/mach-omap2/id.c
> @@ -176,6 +176,12 @@ void __init omap3_check_features(void)
>  	OMAP3_CHECK_FEATURE(status, NEON);
>  	OMAP3_CHECK_FEATURE(status, ISP);
>  
> +	/* On omap3630 and omap4: UART empty rx fifo read aborts */
> +	if (cpu_is_omap3630())
> +		omap3_features |= OMAP3_HAS_UART_NO_EMPTY_FIFO_READ;
> +	if (cpu_is_omap44xx())
> +		omap3_features |= OMAP3_HAS_UART_NO_EMPTY_FIFO_READ;
> +
>  	/*
>  	 * TODO: Get additional info (where applicable)
>  	 *       e.g. Size of L2 cache.
> @@ -316,6 +322,7 @@ void __init omap3_cpuinfo(void)
>  	OMAP3_SHOW_FEATURE(sgx);
>  	OMAP3_SHOW_FEATURE(neon);
>  	OMAP3_SHOW_FEATURE(isp);
> +	OMAP3_SHOW_FEATURE(uart_no_empty_fifo_read);
>  
>  	printk(")\n");
>  }
> diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
> index 2e17890..c32f015 100644
> --- a/arch/arm/plat-omap/include/plat/cpu.h
> +++ b/arch/arm/plat-omap/include/plat/cpu.h
> @@ -497,6 +497,7 @@ extern u32 omap3_features;
>  #define OMAP3_HAS_SGX			BIT(2)
>  #define OMAP3_HAS_NEON			BIT(3)
>  #define OMAP3_HAS_ISP			BIT(4)
> +#define OMAP3_HAS_UART_NO_EMPTY_FIFO_READ	BIT(5)
>  
>  #define OMAP3_HAS_FEATURE(feat,flag)			\
>  static inline unsigned int omap3_has_ ##feat(void)	\
> @@ -509,5 +510,6 @@ OMAP3_HAS_FEATURE(sgx, SGX)
>  OMAP3_HAS_FEATURE(iva, IVA)
>  OMAP3_HAS_FEATURE(neon, NEON)
>  OMAP3_HAS_FEATURE(isp, ISP)
> +OMAP3_HAS_FEATURE(uart_no_empty_fifo_read, UART_NO_EMPTY_FIFO_READ)
>  
>  #endif


-- 
Regards,
Nishanth Menon
