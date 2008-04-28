From: "Gopinath, Thara" <thara@ti.com>
Subject: [PATCH] OMAP: Correcting the gpmc prefetch control register address
Date: Mon, 28 Apr 2008 16:55:01 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB2E7A2591@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from soda.ext.ti.com ([198.47.26.145]:38808 "EHLO soda.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763083AbYD1LZN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Apr 2008 07:25:13 -0400
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by soda.ext.ti.com (8.13.7/8.13.7) with ESMTP id m3SBP77m018045
	for <linux-omap@vger.kernel.org>; Mon, 28 Apr 2008 06:25:12 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id m3SBP6pI020218
	for <linux-omap@vger.kernel.org>; Mon, 28 Apr 2008 06:25:06 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

From: Thara Gopinath <thara@ti.com>

Correcting the GPMC_PREFETCH_CONTROL register address

Signed-off-by: Thara Gopinath <thara@ti.com>
Index: linux-omap-2.6/arch/arm/mach-omap2/gpmc.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/gpmc.c      2008-04-28 16:07:01.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/gpmc.c   2008-04-28 16:09:06.246933117 +0530
@@ -41,7 +41,7 @@
 #define GPMC_STATUS            0x54
 #define GPMC_PREFETCH_CONFIG1  0x1e0
 #define GPMC_PREFETCH_CONFIG2  0x1e4
-#define GPMC_PREFETCH_CONTROL  0x1e8
+#define GPMC_PREFETCH_CONTROL  0x1ec
 #define GPMC_PREFETCH_STATUS   0x1f0
 #define GPMC_ECC_CONFIG                0x1f4
 #define GPMC_ECC_CONTROL       0x1f8
