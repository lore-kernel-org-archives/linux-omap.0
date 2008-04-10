From: Paul Walmsley <paul@pwsan.com>
Subject: [RFC PATCH] musb: fix "musb_hdrc: invalid ep 8" messages
Date: Thu, 10 Apr 2008 11:45:32 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0804101143550.10613@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:38420 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756770AbYDJRpd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Apr 2008 13:45:33 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: david-b@pacbell.net, me@felipebalbi.com


This patch fixes the "musb_hdrc: invalid ep 8" messages that show up on
boot with current linux-omap git head on OMAP3430SDP ES2.1.  I guess that
the musb driver comes up in FIFO mode 4 with 16 endpoints defined, but the 
driver is limited to 8 endpoints by macros in hdrc_cnf.h.

Anyway, I don't know much about MUSB.  David or Felipe, maybe you could 
take a quick look at this patch?


Signed-off-by: Paul Walmsley <paul@pwsan.com>

---
 include/asm-arm/arch-omap/hdrc_cnf.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: linux-omap/include/asm-arm/arch-omap/hdrc_cnf.h
===================================================================
--- linux-omap.orig/include/asm-arm/arch-omap/hdrc_cnf.h	2007-08-27 02:19:07.000000000 -0600
+++ linux-omap/include/asm-arm/arch-omap/hdrc_cnf.h	2008-04-01 11:10:34.000000000 -0600
@@ -14,11 +14,11 @@
 
 /* ** Number of Tx endpoints ** */
 /* Legal values are 1 - 16 (this value includes EP0) */
-#define MUSB_C_NUM_EPT 8
+#define MUSB_C_NUM_EPT 16
 
 /* ** Number of Rx endpoints ** */
 /* Legal values are 1 - 16 (this value includes EP0) */
-#define MUSB_C_NUM_EPR 8
+#define MUSB_C_NUM_EPR 16
 
 /* ** Endpoint 1 to 15 direction types ** */
 /* C_EP1_DEF is defined if either Tx endpoint 1 or Rx endpoint 1 are used */
@@ -163,7 +163,7 @@
  * Legal values are 2 - 16
  * This must be equal to the larger of C_NUM_EPT, C_NUM_EPR
  */
-#define MUSB_C_NUM_EPS 8
+#define MUSB_C_NUM_EPS 16
 
 /* C_EPMAX_BITS is equal to the largest endpoint FIFO word address bits */
 #define MUSB_C_EPMAX_BITS 12
