From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 02/29] ARM: OMAP: Remove smp.h
Date: Wed, 19 Sep 2012 14:05:37 -0700
Message-ID: <20120919210536.28074.58176.stgit@muffinssi>
References: <20120919205732.28074.43697.stgit@muffinssi>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:25773 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751967Ab2ISVFi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Sep 2012 17:05:38 -0400
In-Reply-To: <20120919205732.28074.43697.stgit@muffinssi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

This is no longer needed.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/include/mach/smp.h |    5 -----
 arch/arm/mach-omap2/include/mach/smp.h |    5 -----
 2 files changed, 10 deletions(-)
 delete mode 100644 arch/arm/mach-omap1/include/mach/smp.h
 delete mode 100644 arch/arm/mach-omap2/include/mach/smp.h

diff --git a/arch/arm/mach-omap1/include/mach/smp.h b/arch/arm/mach-omap1/include/mach/smp.h
deleted file mode 100644
index 80a371c..0000000
--- a/arch/arm/mach-omap1/include/mach/smp.h
+++ /dev/null
@@ -1,5 +0,0 @@
-/*
- * arch/arm/mach-omap1/include/mach/smp.h
- */
-
-#include <plat/smp.h>
diff --git a/arch/arm/mach-omap2/include/mach/smp.h b/arch/arm/mach-omap2/include/mach/smp.h
deleted file mode 100644
index 323675f..0000000
--- a/arch/arm/mach-omap2/include/mach/smp.h
+++ /dev/null
@@ -1,5 +0,0 @@
-/*
- * arch/arm/mach-omap2/include/mach/smp.h
- */
-
-#include <plat/smp.h>

