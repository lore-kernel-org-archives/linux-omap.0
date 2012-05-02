From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 1/7] ARM: OMAP4: Don't compile cm2xxx_3xxx.c for OMAP4 only builds.
Date: Wed, 2 May 2012 15:18:07 +0530
Message-ID: <1335952093-12541-2-git-send-email-santosh.shilimkar@ti.com>
References: <1335952093-12541-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42383 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750807Ab2EBJs1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 May 2012 05:48:27 -0400
In-Reply-To: <1335952093-12541-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, tony@atomide.com, Santosh Shilimkar <santosh.shilimkar@ti.com>, Paul Walmsley <paul@pwsan.com>

Since OMAP4 code base now makes use of OMAP4 specific PRCM functions,
cm2xxx_3xxx.c need not be compiled for OMAP4 only builds.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/Makefile |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 49f92bc..56ed62e 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -86,10 +86,7 @@ obj-y					+= prm_common.o
 obj-$(CONFIG_ARCH_OMAP2)		+= prcm.o cm2xxx_3xxx.o prm2xxx_3xxx.o
 obj-$(CONFIG_ARCH_OMAP3)		+= prcm.o cm2xxx_3xxx.o prm2xxx_3xxx.o \
 					   vc3xxx_data.o vp3xxx_data.o
-# XXX The presence of cm2xxx_3xxx.o on the line below is temporary and
-# will be removed once the OMAP4 part of the codebase is converted to
-# use OMAP4-specific PRCM functions.
-obj-$(CONFIG_ARCH_OMAP4)		+= prcm.o cm2xxx_3xxx.o cminst44xx.o \
+obj-$(CONFIG_ARCH_OMAP4)		+= prcm.o cminst44xx.o \
 					   cm44xx.o prcm_mpu44xx.o \
 					   prminst44xx.o vc44xx_data.o \
 					   vp44xx_data.o prm44xx.o
-- 
1.7.5.4

