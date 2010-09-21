From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: fix build break due to typo in cacheflush.h
Date: Tue, 21 Sep 2010 09:07:46 -0700
Message-ID: <20100921160746.GS4611@atomide.com>
References: <1285085120-29780-1-git-send-email-gadiyar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:50257 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754115Ab0IUQHo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Sep 2010 12:07:44 -0400
Content-Disposition: inline
In-Reply-To: <1285085120-29780-1-git-send-email-gadiyar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anand Gadiyar <gadiyar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Anand Gadiyar <gadiyar@ti.com> [100921 08:57]:
> commit 9d85ac1e6 introduced a small typo. This causes the build
> to break when CONFIG_CPU_V7 is set and CONFIG_CPU_V6 and
> CONFIG_SMP_ON_UP are not. (log below)
> 
>   CC      init/main.o
> In file included from include/linux/highmem.h:9,
>                  from include/linux/pagemap.h:10,
>                  from include/linux/mempolicy.h:70,
>                  from init/main.c:50:
> arch/arm/include/asm/cacheflush.h: In function '__flush_icache_all':
> arch/arm/include/asm/cacheflush.h:332: error: implicit declaration of function '__flush_icache_preferred'
> make[1]: *** [init/main.o] Error 1
> make: *** [init] Error 2
> 
> Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/include/asm/cacheflush.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-omap-2.6/arch/arm/include/asm/cacheflush.h
> ===================================================================
> --- linux-omap-2.6.orig/arch/arm/include/asm/cacheflush.h
> +++ linux-omap-2.6/arch/arm/include/asm/cacheflush.h
> @@ -324,7 +324,7 @@ extern void copy_to_user_page(struct vm_
>  #elif __LINUX_ARM_ARCH__ == 6 && defined(CONFIG_ARM_ERRATA_411920)
>  #define __flush_icache_preferred	__cpuc_flush_icache_all
>  #else
> -#define __fluch_icache_preferred	__flush_icache_all_generic
> +#define __flush_icache_preferred	__flush_icache_all_generic
>  #endif
>  
>  static inline void __flush_icache_all(void)

Thanks, will merge that into the original patch with your S-O-B
and repost.

Tony
