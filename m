From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4/5] ARM: OMAP2/3: Remove OMAP2_PRCM_BASE
Date: Thu, 07 May 2009 13:43:10 -0700
Message-ID: <20090507204310.7461.21502.stgit@localhost>
References: <20090507203552.7461.35051.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:53342 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763333AbZEGUnK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 May 2009 16:43:10 -0400
Received: from c-67-160-239-110.hsd1.ca.comcast.net ([67.160.239.110] helo=[127.0.0.1])
	by mho-02-ewr.mailhop.org with esmtpa (Exim 4.68)
	(envelope-from <tony@atomide.com>)
	id 1M2AQx-000FS4-Bh
	for linux-omap@vger.kernel.org; Thu, 07 May 2009 20:43:11 +0000
In-Reply-To: <20090507203552.7461.35051.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

It's currently unused, and processor specific defines should
be used instead.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/include/mach/omap24xx.h |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/include/mach/omap24xx.h b/arch/arm/plat-omap/include/mach/omap24xx.h
index 4ce9b6a..60f8324 100644
--- a/arch/arm/plat-omap/include/mach/omap24xx.h
+++ b/arch/arm/plat-omap/include/mach/omap24xx.h
@@ -87,12 +87,10 @@
 
 #if defined(CONFIG_ARCH_OMAP2420)
 
-#define OMAP2_PRCM_BASE		OMAP2420_PRCM_BASE
 #define OMAP2_CM_BASE		OMAP2420_CM_BASE
 
 #elif defined(CONFIG_ARCH_OMAP2430)
 
-#define OMAP2_PRCM_BASE		OMAP2430_PRCM_BASE
 #define OMAP2_CM_BASE		OMAP2430_CM_BASE
 
 #endif

