From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH] dspbridge: clean up errbase.h
Date: Thu, 17 Sep 2009 18:26:40 +0300
Message-ID: <1253201200-31883-1-git-send-email-andy.shevchenko@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:38159 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754495AbZIQP05 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Sep 2009 11:26:57 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: x0095840@ti.com, omar.ramirez@ti.com, hiroshi.doyu@nokia.com, Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

From: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

It seems BRD_* error codes from this certain file is redundant.

Signed-off-by: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
---
 arch/arm/plat-omap/include/dspbridge/errbase.h |   15 ---------------
 1 files changed, 0 insertions(+), 15 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/errbase.h b/arch/arm/plat-omap/include/dspbridge/errbase.h
index f04c005..47b9a0b 100644
--- a/arch/arm/plat-omap/include/dspbridge/errbase.h
+++ b/arch/arm/plat-omap/include/dspbridge/errbase.h
@@ -324,21 +324,6 @@
 /* Insufficient buffer size */
 #define CFG_E_INSUFFICIENTBUFSIZE   (CFG_EBASE + 0x05)
 
-/* FAILURE Codes : BRD */
-#define BRD_EBASE                   (DSP_COMP_EBASE + 0x300)
-
-/* Board client does not have sufficient access rights for this operation. */
-#define BRD_E_ACCESSDENIED          (BRD_EBASE + 0x00)
-
-/* Unable to find trace buffer symbols in the DSP executable COFF file. */
-#define BRD_E_NOTRACEBUFFER         (BRD_EBASE + 0x01)
-
-/* Attempted to auto-start board, but no default DSP executable configured. */
-#define BRD_E_NOEXEC                (BRD_EBASE + 0x02)
-
-/* The operation failed because it was started from a wrong state */
-#define BRD_E_WRONGSTATE            (BRD_EBASE + 0x03)
-
 /* FAILURE Codes : COD */
 #define COD_EBASE                   (DSP_COMP_EBASE + 0x400)
 
-- 
1.5.6.5

