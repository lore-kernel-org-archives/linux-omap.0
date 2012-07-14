From: Domenico Andreoli <cavokz@gmail.com>
Subject: [PATCH] OMAP: remove unused parameter arch_id from uncompress.h
Date: Sat, 14 Jul 2012 22:49:54 +0200
Message-ID: <20120714204952.GA4798@raptus.dandreoli.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:59831 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750917Ab2GNUt6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 14 Jul 2012 16:49:58 -0400
Received: by wibhr14 with SMTP id hr14so1633219wib.1
        for <linux-omap@vger.kernel.org>; Sat, 14 Jul 2012 13:49:57 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

From: Domenico Andreoli <domenico.andreoli@linux.com>

There is not point in having arch_id as parameter of __arch_decomp_setup(),
nothing in it uses arch_id. The machine id is already exported (and used)
with symbol __machine_arch_type as per mach-types.h.

Removing the pointless macro as well.

Signed-off-by: Domenico Andreoli <domenico.andreoli@linux.com>
---
 arch/arm/plat-omap/include/plat/uncompress.h |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

Index: b/arch/arm/plat-omap/include/plat/uncompress.h
===================================================================
--- a/arch/arm/plat-omap/include/plat/uncompress.h
+++ b/arch/arm/plat-omap/include/plat/uncompress.h
@@ -103,7 +103,7 @@ static inline void flush(void)
 	_DEBUG_LL_ENTRY(mach, TI81XX_UART##p##_BASE, OMAP_PORT_SHIFT,	\
 		TI81XXUART##p)
 
-static inline void __arch_decomp_setup(unsigned long arch_id)
+static inline void arch_decomp_setup(void)
 {
 	int port = 0;
 
@@ -186,8 +186,6 @@ static inline void __arch_decomp_setup(u
 	} while (0);
 }
 
-#define arch_decomp_setup()	__arch_decomp_setup(arch_id)
-
 /*
  * nothing to do
  */
