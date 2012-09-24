From: Paul Walmsley <paul@pwsan.com>
Subject: ARM: OMAP: fix new sparse warnings
Date: Mon, 24 Sep 2012 23:09:32 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1209242308100.10406@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:40091 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750706Ab2IXXJd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Sep 2012 19:09:33 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, linux-arm-kernel@lists.infradead.org, grinberg@compulab.co.il


Commit e54adb1e79762d3591459e5b0e9b9ff578e33fdb ("ARM: OMAP: omap3evm:
cleanup revision bits") adds a new sparse[1] warning:

arch/arm/mach-omap2/board-omap3evm.c:90:4: warning: symbol 'get_omap3_evm_rev' was not declared. Should it be static?

This symbol no longer appears to be used outside this file, so mark it
static and remove the export.

Commit 801475ccb2b2c1928b22aec4b9e5285d9e347602 ("ARM: OMAP: move
debug_card_init() function") results in the following new sparse[1]
warning:

arch/arm/plat-omap/debug-devices.c:71:12: warning: symbol 'debug_card_init' was not declared. Should it be static?

Fix by including the proper header file.

...

1. https://sparse.wiki.kernel.org/index.php/Main_Page

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Igor Grinberg <grinberg@compulab.co.il>
Cc: Tony Lindgren <tony@atomide.com>
---

Will queue this with devel-late-fixes.

 arch/arm/mach-omap2/board-omap3evm.c |    3 +--
 arch/arm/plat-omap/debug-devices.c   |    2 ++
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index b94873d..f229aab 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -87,11 +87,10 @@ enum {
 
 static u8 omap3_evm_version;
 
-u8 get_omap3_evm_rev(void)
+static u8 get_omap3_evm_rev(void)
 {
 	return omap3_evm_version;
 }
-EXPORT_SYMBOL(get_omap3_evm_rev);
 
 static void __init omap3_evm_get_revision(void)
 {
diff --git a/arch/arm/plat-omap/debug-devices.c b/arch/arm/plat-omap/debug-devices.c
index c7a4c09..5e4f722 100644
--- a/arch/arm/plat-omap/debug-devices.c
+++ b/arch/arm/plat-omap/debug-devices.c
@@ -17,6 +17,8 @@
 
 #include <mach/hardware.h>
 
+#include <plat/debug-devices.h>
+
 /* Many OMAP development platforms reuse the same "debug board"; these
  * platforms include H2, H3, H4, and Perseus2.
  */
-- 
1.7.10.4

