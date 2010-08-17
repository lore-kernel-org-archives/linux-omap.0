From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/4] ARM: Add SMP_ON_UP Kconfig option for booting SMP kernel
	on UP
Date: Tue, 17 Aug 2010 13:53:19 +0300
Message-ID: <20100817105319.19061.6095.stgit@baageli.muru.com>
References: <20100817104414.19061.38999.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:55265 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751937Ab0HQKxR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Aug 2010 06:53:17 -0400
In-Reply-To: <20100817104414.19061.38999.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, bryan.wu@canonical.com

Add Kconfig option to boot SMP kernel on uniprocessor systems,
and define MULTI_CPU, MULTI_TLB and MULTI_CACHE when SMP_ON_UP
option is set.

This will allow us to dynamically set the uniprocessor functions
during the boot in a way that should also work with ZBOOT_ROM.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/Kconfig                  |    7 +++++++
 arch/arm/include/asm/cacheflush.h |    6 ++++++
 arch/arm/include/asm/proc-fns.h   |    8 ++++++++
 arch/arm/include/asm/tlbflush.h   |    6 ++++++
 4 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 9295110..1e9df6d 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1166,6 +1166,13 @@ config SMP
 
 	  If you don't know what to do here, say N.
 
+config SMP_ON_UP
+	bool "Allow booting SMP kernel on uniprocessor systems (EXPERIMENTAL)"
+	depends on SMP
+	default y
+	help
+          Allows booting SMP kernel on uniprocessor systems.
+
 config HAVE_ARM_SCU
 	bool
 	depends on SMP
diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
index 4656a24..e0ed5b4 100644
--- a/arch/arm/include/asm/cacheflush.h
+++ b/arch/arm/include/asm/cacheflush.h
@@ -26,6 +26,12 @@
 #undef _CACHE
 #undef MULTI_CACHE
 
+/* Force multiple cache support to boot SMP kernel on uniprocessor systems */
+#ifdef CONFIG_SMP_ON_UP
+# undef  MULTI_CACHE
+# define MULTI_CACHE 1
+#endif
+
 #if defined(CONFIG_CPU_CACHE_V3)
 # ifdef _CACHE
 #  define MULTI_CACHE 1
diff --git a/arch/arm/include/asm/proc-fns.h b/arch/arm/include/asm/proc-fns.h
index 8fdae9b..87a558b 100644
--- a/arch/arm/include/asm/proc-fns.h
+++ b/arch/arm/include/asm/proc-fns.h
@@ -20,6 +20,14 @@
 #undef MULTI_CPU
 #undef CPU_NAME
 
+/* Force multiple CPU support to boot SMP kernel on uniprocessor systems */
+#ifdef CONFIG_SMP_ON_UP
+# undef  MULTI_CPU
+# undef  CPU_NAME
+# define MULTI_CPU
+# define CPU_NAME
+#endif
+
 /*
  * CPU_NAME - the prefix for CPU related functions
  */
diff --git a/arch/arm/include/asm/tlbflush.h b/arch/arm/include/asm/tlbflush.h
index 33b546a..9b310bd 100644
--- a/arch/arm/include/asm/tlbflush.h
+++ b/arch/arm/include/asm/tlbflush.h
@@ -70,6 +70,12 @@
 #undef _TLB
 #undef MULTI_TLB
 
+/* Force multiple TLB support to boot SMP kernel on uniprocessor systems */
+#ifdef CONFIG_SMP_ON_UP
+# undef  MULTI_TLB
+# define MULTI_TLB 1
+#endif
+
 #define v3_tlb_flags	(TLB_V3_FULL | TLB_V3_PAGE)
 
 #ifdef CONFIG_CPU_TLB_V3

