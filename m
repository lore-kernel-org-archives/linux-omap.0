From: Anand Gadiyar <gadiyar@ti.com>
Subject: [PATCH] ARM: fix build break due to typo in cacheflush.h
Date: Tue, 21 Sep 2010 21:35:20 +0530
Message-ID: <1285085120-29780-1-git-send-email-gadiyar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38893 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753844Ab0IUQFb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Sep 2010 12:05:31 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Anand Gadiyar <gadiyar@ti.com>, Tony Lindgren <tony@atomide.com>

commit 9d85ac1e6 introduced a small typo. This causes the build
to break when CONFIG_CPU_V7 is set and CONFIG_CPU_V6 and
CONFIG_SMP_ON_UP are not. (log below)

  CC      init/main.o
In file included from include/linux/highmem.h:9,
                 from include/linux/pagemap.h:10,
                 from include/linux/mempolicy.h:70,
                 from init/main.c:50:
arch/arm/include/asm/cacheflush.h: In function '__flush_icache_all':
arch/arm/include/asm/cacheflush.h:332: error: implicit declaration of function '__flush_icache_preferred'
make[1]: *** [init/main.o] Error 1
make: *** [init] Error 2

Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/include/asm/cacheflush.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-omap-2.6/arch/arm/include/asm/cacheflush.h
===================================================================
--- linux-omap-2.6.orig/arch/arm/include/asm/cacheflush.h
+++ linux-omap-2.6/arch/arm/include/asm/cacheflush.h
@@ -324,7 +324,7 @@ extern void copy_to_user_page(struct vm_
 #elif __LINUX_ARM_ARCH__ == 6 && defined(CONFIG_ARM_ERRATA_411920)
 #define __flush_icache_preferred	__cpuc_flush_icache_all
 #else
-#define __fluch_icache_preferred	__flush_icache_all_generic
+#define __flush_icache_preferred	__flush_icache_all_generic
 #endif
 
 static inline void __flush_icache_all(void)
