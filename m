From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 2/8] omap: DEBUG_LL: allow no omap uart configuration
Date: Tue, 3 Nov 2009 16:09:34 -0600
Message-ID: <4AF0AA1E.8020502@ti.com>
References: <1257283215-6448-1-git-send-email-vikram.pandita@ti.com> <1257283215-6448-2-git-send-email-vikram.pandita@ti.com> <1257283215-6448-3-git-send-email-vikram.pandita@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53694 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755104AbZKCWJa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 3 Nov 2009 17:09:30 -0500
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id nA3M9ZOh023203
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 3 Nov 2009 16:09:35 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id nA3M9YoV020841
	for <linux-omap@vger.kernel.org>; Tue, 3 Nov 2009 16:09:34 -0600 (CST)
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id nA3M9YDD022482
	for <linux-omap@vger.kernel.org>; Tue, 3 Nov 2009 16:09:34 -0600 (CST)
In-Reply-To: <1257283215-6448-3-git-send-email-vikram.pandita@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vikram Pandita <vikram.pandita@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Vikram Pandita had written, on 11/03/2009 03:20 PM, the following:
[...]
> diff --git a/arch/arm/plat-omap/include/plat/uncompress.h b/arch/arm/plat-omap/include/plat/uncompress.h
> index e22f575..49b38f0 100644
> --- a/arch/arm/plat-omap/include/plat/uncompress.h
> +++ b/arch/arm/plat-omap/include/plat/uncompress.h
> @@ -44,8 +44,10 @@ static void putc(int c)
>  	uart = (volatile u8 *)(OMAP_UART3_BASE);
>  #elif defined(CONFIG_OMAP_LL_DEBUG_UART2)
>  	uart = (volatile u8 *)(OMAP_UART2_BASE);
> -#else
> +#elif defined(CONFIG_OMAP_LL_DEBUG_UART1)
>  	uart = (volatile u8 *)(OMAP_UART1_BASE);
> +#elif defined(CONFIG_OMAP_LL_DEBUG_NONE)
> +	return;
what is the default? an #else missing? maybe, we might want to use:
#else
	return;

also I am not clear about
#ifdef CONFIG_MACH_OMAP_PALMTE
	return
#endif
Vs this -> should'nt PALMTE also use this instead?

unrelated..  purpose of #ifdef CONFIG_ARCH_OMAP in
arch/arm/plat-omap/include/plat/uncompress.h
is'nt it already OMAP?

-- 
Regards,
Nishanth Menon
