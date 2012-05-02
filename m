From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 5/7] ARM: All OMAP2PLUS machines use omap2 directory so just add one entry
Date: Wed, 2 May 2012 15:18:11 +0530
Message-ID: <1335952093-12541-6-git-send-email-santosh.shilimkar@ti.com>
References: <1335952093-12541-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36372 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751927Ab2EBJse (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 2 May 2012 05:48:34 -0400
In-Reply-To: <1335952093-12541-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, tony@atomide.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

All OMAP2PLUS arch based machines makes use of mach-omap2 directory.
So just add one entry so that there is no need to patch this file
for any OMAP2+ devices.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/Makefile |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 047a207..7a6bde0 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -164,9 +164,7 @@ machine-$(CONFIG_ARCH_MXS)		:= mxs
 machine-$(CONFIG_ARCH_NETX)		:= netx
 machine-$(CONFIG_ARCH_NOMADIK)		:= nomadik
 machine-$(CONFIG_ARCH_OMAP1)		:= omap1
-machine-$(CONFIG_ARCH_OMAP2)		:= omap2
-machine-$(CONFIG_ARCH_OMAP3)		:= omap2
-machine-$(CONFIG_ARCH_OMAP4)		:= omap2
+machine-$(CONFIG_ARCH_OMAP2PLUS)	:= omap2
 machine-$(CONFIG_ARCH_ORION5X)		:= orion5x
 machine-$(CONFIG_ARCH_PICOXCELL)	:= picoxcell
 machine-$(CONFIG_ARCH_PNX4008)		:= pnx4008
-- 
1.7.5.4

