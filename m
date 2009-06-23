From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 13/12] OMAP: Fix IOMEM macro for assembly
Date: Tue, 23 Jun 2009 16:57:55 +0300
Message-ID: <20090623135754.GN7352@atomide.com>
References: <20090622113422.28477.27052.stgit@localhost> <20090622115306.28477.27169.stgit@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="PEIAKu/WMn1b1Hv9"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:62288 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752337AbZFWN6F (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Jun 2009 09:58:05 -0400
Content-Disposition: inline
In-Reply-To: <20090622115306.28477.27169.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Here's one more fix.

Tony

--PEIAKu/WMn1b1Hv9
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="iomem-braces.patch"

>From 503dcbeba50fd3545283594bc391b4a400fa6c48 Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Tue, 23 Jun 2009 16:55:30 +0300
Subject: [PATCH] OMAP: Fix IOMEM macro for assembly

Otherwise IOMEM calculations can fail.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/plat-omap/include/mach/io.h b/arch/arm/plat-omap/include/mach/io.h
index 3b28147..73f483d 100644
--- a/arch/arm/plat-omap/include/mach/io.h
+++ b/arch/arm/plat-omap/include/mach/io.h
@@ -201,7 +201,7 @@
 #define OMAP2_IO_ADDRESS(pa)	IOMEM(__OMAP2_IO_ADDRESS(pa))
 
 #ifdef __ASSEMBLER__
-#define IOMEM(x)		x
+#define IOMEM(x)		(x)
 #else
 #define IOMEM(x)		((void __force __iomem *)(x))
 

--PEIAKu/WMn1b1Hv9--
