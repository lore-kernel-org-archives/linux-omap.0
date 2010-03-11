From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 15/19] OMAP2: cpu_is_omap2*: fix compile-time removal of
	unused code
Date: Thu, 11 Mar 2010 15:48:41 -0800
Message-ID: <20100311234841.4500.88816.stgit@baageli.muru.com>
References: <20100311234404.4500.82861.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:53829 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753917Ab0CKXrT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Mar 2010 18:47:19 -0500
In-Reply-To: <20100311234404.4500.82861.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

From: Kevin Hilman <khilman@deeprootsystems.com>

Currently if omap2420 is defined but not omap2430, cpu_is_omap2430()
is still defined as a macro, instead of #define'd to zero.  This
results in conditional cpu_is_omap2430() code still being compiled,
and leads to possible compile/link errors.  In particular for hwmod
init.

To fix, add extra #ifdefs to CPU check macros to ensure that the
is_omap* macros are zero for each OMAP2 if they are not configured
into the kernel.

Tested-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/include/plat/cpu.h |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
index ed8786c..7514174 100644
--- a/arch/arm/plat-omap/include/plat/cpu.h
+++ b/arch/arm/plat-omap/include/plat/cpu.h
@@ -167,10 +167,14 @@ IS_OMAP_SUBCLASS(443x, 0x443)
 #if defined(MULTI_OMAP2)
 # if defined(CONFIG_ARCH_OMAP2)
 #  undef  cpu_is_omap24xx
-#  undef  cpu_is_omap242x
-#  undef  cpu_is_omap243x
 #  define cpu_is_omap24xx()		is_omap24xx()
+# endif
+# if defined (CONFIG_ARCH_OMAP2420)
+#  undef  cpu_is_omap242x
 #  define cpu_is_omap242x()		is_omap242x()
+# endif
+# if defined (CONFIG_ARCH_OMAP2430)
+#  undef  cpu_is_omap243x
 #  define cpu_is_omap243x()		is_omap243x()
 # endif
 # if defined(CONFIG_ARCH_OMAP3)

