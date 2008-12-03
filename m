From: Carlos Chinea <carlos.chinea@nokia.com>
Subject: [PATCH 2.6.28-rc6 1/1] Fix OMAP/README docummentation
Date: Wed,  3 Dec 2008 12:40:03 +0200
Message-ID: <1228300803-19127-1-git-send-email-carlos.chinea@nokia.com>
References: <1228300638.26377.124.camel@groo.research.nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:32823 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751346AbYLCKnL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Dec 2008 05:43:11 -0500
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id mB3Agf8e032675
	for <linux-omap@vger.kernel.org>; Wed, 3 Dec 2008 12:43:08 +0200
In-Reply-To: <1228300638.26377.124.camel@groo.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org


        - Remove section 4 because it has wrong and misleading information

Signed-off-by: Carlos Chinea <carlos.chinea@nokia.com>
---
 Documentation/arm/OMAP/README |   39 ---------------------------------------
 1 files changed, 0 insertions(+), 39 deletions(-)

diff --git a/Documentation/arm/OMAP/README b/Documentation/arm/OMAP/README
index f8ffb68..038d863 100644
--- a/Documentation/arm/OMAP/README
+++ b/Documentation/arm/OMAP/README
@@ -370,45 +370,6 @@ other users. It then can be included into the public OMAP kernel tree.
 processor peripherals or board devices. Improve and maintain the code for your 
 new processor or board.
 
-
-4. General guidelines to write clean and OMAP Linux compatible code
--------------------------------------------------------------------
-
-- For register access use the __REG8/16/32() macros. At the moment, see first
-example in include/asm-arm/arch-omap/hardware.h.
-
-Allegedly __REG() makes at least some versions of GCC emit tighter code
-than the more direct wrappers. Presumably by making it easier to use certain 
-addressing modes. 
-
-Make sure that the registers names are clearly marked as being registers
-(and not addresses of registers). This has to be done by adding a '_REG'
-suffix. E.g.
-
-#define OMAP_ID_REG  (__REG32(0xfffed400))
-#define DPLL_CTL_REG (__REG16(0xfffecf00))
-
-__raw_read[bwl] and __raw_write[bwl] are deprecated. They will converted to
-__REG8/16/32() syntax, soon. Don't use anything else like own pointer
-definitions or in[bwl]/out[bwl] etc., too.
-
-- Make read-modify-write register access preemption save. Use spin_lock() and 
-spin_unlock() where necessary. If an IRQ handler can access the registers, 
-use spin_lock_irqsave(), too. 
-
-- Functions declared as __init shouldn't have any references after the kernel 
-initialization phase is complete. Usually they should be static as well.
-
-- Don't use return statements at end of void functions.
-
-- Use consistent indentation style. Don't use space indentations. Use tab 
-indentations.
-
-- In general use Linux formatting style. See Documentation/CodingStyle for more
-information. If you use GNU emacs, see also chapter 8 of that document how to
-add a linux-c-mode to emacs.
-
-
 ------------------------------------------------------------------
 Last modified 15. March 2006
 The OMAP Linux Kernel Team
-- 
1.5.3.6

