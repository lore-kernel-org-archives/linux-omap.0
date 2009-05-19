From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: OMAP2/3: Remove unused L4_WK_OMAP_BASE,
	L4_PER_OMAP_BASE, L4_EMU_BASE, L3_OMAP_BASE (Re: [PATCH 2/7] OMAP4:
	Create board support for OMAP_4430SDP, v3)
Date: Tue, 19 May 2009 15:37:41 -0700
Message-ID: <20090519223741.GK19742@atomide.com>
References: <1242739888-12428-1-git-send-email-santosh.shilimkar@ti.com> <20090519211756.GH19742@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="AQNmCumFClRcGgHG"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:57525 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751361AbZESWhu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 May 2009 18:37:50 -0400
Content-Disposition: inline
In-Reply-To: <20090519211756.GH19742@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org


--AQNmCumFClRcGgHG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Tony Lindgren <tony@atomide.com> [090519 14:18]:
> Hi,
> 
> I rebased these patches on top of the for-next branch in linux-omap
> tree, some comments and the updated patch below.

We can now get rid of these old defines too BTW.

Tony

--AQNmCumFClRcGgHG
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="remove-unused-defines.patch"

>From a64bb3a0bf0128ee4ae1d540c7482c186aff326b Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Tue, 19 May 2009 13:51:44 -0700
Subject: [PATCH] ARM: OMAP2/3: Remove unused L4_WK_OMAP_BASE, L4_PER_OMAP_BASE, L4_EMU_BASE, L3_OMAP_BASE

These are not being used right now, and the processor specific
defines should be used instead by any code accessing these registers.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/plat-omap/include/mach/omap34xx.h b/arch/arm/plat-omap/include/mach/omap34xx.h
index cc25733..f8d186a 100644
--- a/arch/arm/plat-omap/include/mach/omap34xx.h
+++ b/arch/arm/plat-omap/include/mach/omap34xx.h
@@ -31,13 +31,9 @@
 
 #define L4_34XX_BASE		0x48000000
 #define L4_WK_34XX_BASE		0x48300000
-#define L4_WK_OMAP_BASE		L4_WK_34XX_BASE
 #define L4_PER_34XX_BASE	0x49000000
-#define L4_PER_OMAP_BASE	L4_PER_34XX_BASE
 #define L4_EMU_34XX_BASE	0x54000000
-#define L4_EMU_BASE		L4_EMU_34XX_BASE
 #define L3_34XX_BASE		0x68000000
-#define L3_OMAP_BASE		L3_34XX_BASE
 
 #define OMAP3430_32KSYNCT_BASE	0x48320000
 #define OMAP3430_CM_BASE	0x48004800

--AQNmCumFClRcGgHG--
