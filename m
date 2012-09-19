From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 01/29] ARM: OMAP: Remove unused param.h
Date: Wed, 19 Sep 2012 14:05:34 -0700
Message-ID: <20120919210534.28074.90970.stgit@muffinssi>
References: <20120919205732.28074.43697.stgit@muffinssi>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:41911 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751967Ab2ISVFg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Sep 2012 17:05:36 -0400
In-Reply-To: <20120919205732.28074.43697.stgit@muffinssi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

This is no longer needed.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/include/plat/param.h |    8 --------
 1 file changed, 8 deletions(-)
 delete mode 100644 arch/arm/plat-omap/include/plat/param.h

diff --git a/arch/arm/plat-omap/include/plat/param.h b/arch/arm/plat-omap/include/plat/param.h
deleted file mode 100644
index 1eb4dc3..0000000
--- a/arch/arm/plat-omap/include/plat/param.h
+++ /dev/null
@@ -1,8 +0,0 @@
-/*
- *  arch/arm/plat-omap/include/mach/param.h
- *
- */
-
-#ifdef CONFIG_OMAP_32K_TIMER_HZ
-#define HZ	CONFIG_OMAP_32K_TIMER_HZ
-#endif

