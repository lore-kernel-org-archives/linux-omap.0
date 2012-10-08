From: Paul Walmsley <paul@pwsan.com>
Subject: Re: ARM: OMAP: fix new sparse warnings
Date: Mon, 8 Oct 2012 01:42:59 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1210080141040.5736@utopia.booyaka.com>
References: <alpine.DEB.2.00.1209242308100.10406@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:54173 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750745Ab2JHBm7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 7 Oct 2012 21:42:59 -0400
In-Reply-To: <alpine.DEB.2.00.1209242308100.10406@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, linux-arm-kernel@lists.infradead.org, grinberg@compulab.co.il


Here's an updated version of this one that drops the debug-devices.c 
change.   That will be dealt with in a separate patch.


- Paul

From: Paul Walmsley <paul@pwsan.com>
Date: Sun, 7 Oct 2012 13:10:00 -0600
Subject: [PATCH] ARM: OMAP: omap3evm: fix new sparse warning

Commit e54adb1e79762d3591459e5b0e9b9ff578e33fdb ("ARM: OMAP: omap3evm:
cleanup revision bits") adds a new sparse[1] warning:

arch/arm/mach-omap2/board-omap3evm.c:90:4: warning: symbol 'get_omap3_evm_rev' was not declared. Should it be static?

This symbol no longer appears to be used outside this file, so mark it
static and remove the export.

...

1. https://sparse.wiki.kernel.org/index.php/Main_Page

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Igor Grinberg <grinberg@compulab.co.il>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-omap3evm.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index c64e565..184ef21 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -88,11 +88,10 @@ enum {
 
 static u8 omap3_evm_version;
 
-u8 get_omap3_evm_rev(void)
+static u8 get_omap3_evm_rev(void)
 {
 	return omap3_evm_version;
 }
-EXPORT_SYMBOL(get_omap3_evm_rev);
 
 static void __init omap3_evm_get_revision(void)
 {
-- 
1.7.10.4

