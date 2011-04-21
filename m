From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: Fix relocation if image end past uncompressed kernel
 end
Date: Thu, 21 Apr 2011 03:49:54 -0700
Message-ID: <20110421104954.GH13688@atomide.com>
References: <1303272904-31392-1-git-send-email-nicolas.pitre@linaro.org>
 <20110420072156.GA28679@atomide.com>
 <alpine.LFD.2.00.1104200850030.24613@xanadu.home>
 <20110420165514.GE10402@atomide.com>
 <alpine.LFD.2.00.1104201318040.24613@xanadu.home>
 <20110421055945.GB13688@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:10863 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752514Ab1DUKt7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Apr 2011 06:49:59 -0400
Content-Disposition: inline
In-Reply-To: <20110421055945.GB13688@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Shawn Guo <shawn.guo@freescale.com>, linux-arm-kernel@lists.infradead.org, patches@linaro.org, Aaro Koskinen <aaro.koskinen@nokia.com>, linux-omap@vger.kernel.org

Otherwise we end up overwriting ourselves. This fixes booting
on n900 after commit 6d7d0ae51574943bf571d269da3243257a2d15db
(ARM: 6750/1: improvements to compressed/head.S).

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -282,6 +282,7 @@ dtb_check_done:
 
 /*
  * Check to see if we will overwrite ourselves.
+ *   r1  = corrupted, temporary uncompressed kernel end 
  *   r4  = final kernel address
  *   r5  = start of this image
  *   r9  = size of decompressed image
@@ -292,15 +293,24 @@ dtb_check_done:
  */
 		cmp	r4, r10
 		bhs	wont_overwrite
-		add	r10, r4, r9
-		cmp	r10, r5
+		add	r1, r4, r9
+		cmp	r1, r5
 		bls	wont_overwrite
 
+		/*
+		 * Check if the compressed image end is past the uncompressed
+		 * kernel end. In that case, relocate ourselves to the end
+		 * of the compressed image instead of the uncompressed kernel
+		 * end to avoid overwriting ourselves.
+		 */
+		cmp	r10, r1
+		movls	r10, r1
+
 /*
  * Relocate ourselves past the end of the decompressed kernel.
  *   r5  = start of this image
  *   r6  = _edata
- *   r10 = end of the decompressed kernel
+ *   r10 = end of the decompressed kernel or end of this image if larger
  * Because we always copy ahead, we need to do it from the end and go
  * backward in case the source and destination overlap.
  */
