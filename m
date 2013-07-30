From: Stephen Warren <swarren@wwwdotorg.org>
Subject: [PATCH] ARM: allow DEBUG_UNCOMPRESS for omap2plus
Date: Tue, 30 Jul 2013 16:49:18 -0600
Message-ID: <1375224558-8170-1-git-send-email-swarren@wwwdotorg.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:50351 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755863Ab3G3WtY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Jul 2013 18:49:24 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Stephen Warren <swarren@nvidia.com>, Shawn Guo <shawn.guo@linaro.org>

From: Stephen Warren <swarren@nvidia.com>

DEBUG_UNCOMPRESS was previously disallowed for omap2plus due to
omap2plus.S's use of .data, which is not allowed in the decompressor.
Solve this by placing that data into .text when building the file into
the decompressor. This relies on .text actually being writable in the
decompressor, which it is in practice.

Cc: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
Note that I have build-tested this with omap2plus_defconfig, but not
run-time tested it in any way.
---
 arch/arm/Kconfig.debug             | 2 +-
 arch/arm/include/debug/omap2plus.S | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index d8ff7f7..8eb04b1 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1046,7 +1046,7 @@ config DEBUG_UART_8250_FLOW_CONTROL
 config DEBUG_UNCOMPRESS
 	bool
 	depends on ARCH_MULTIPLATFORM
-	default y if DEBUG_LL && !DEBUG_OMAP2PLUS_UART
+	default y if DEBUG_LL
 	help
 	  This option influences the normal decompressor output for
 	  multiplatform kernels.  Normally, multiplatform kernels disable
diff --git a/arch/arm/include/debug/omap2plus.S b/arch/arm/include/debug/omap2plus.S
index 6d867ae..364ae35 100644
--- a/arch/arm/include/debug/omap2plus.S
+++ b/arch/arm/include/debug/omap2plus.S
@@ -58,11 +58,15 @@
 
 #define UART_OFFSET(addr)	((addr) & 0x00ffffff)
 
+#if !defined(ZIMAGE)
 		.pushsection .data
+#endif
 omap_uart_phys:	.word	0
 omap_uart_virt:	.word	0
 omap_uart_lsr:	.word	0
+#if !defined(ZIMAGE)
 		.popsection
+#endif
 
 		.macro	addruart, rp, rv, tmp
 
-- 
1.8.1.5

