From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: [PATCH 1/2] OMAP3430SDP: Remove unneded extern line
Date: Wed, 25 Feb 2009 16:02:36 -0600
Message-ID: <A24693684029E5489D1D202277BE89442DF8399A@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33406 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757300AbZBYWCo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Feb 2009 17:02:44 -0500
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n1PM2bLI003192
	for <linux-omap@vger.kernel.org>; Wed, 25 Feb 2009 16:02:42 -0600
Received: from dlee75.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id n1PM2bgP008833
	for <linux-omap@vger.kernel.org>; Wed, 25 Feb 2009 16:02:37 -0600 (CST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Syed Mohammed, Khasim" <khasim@ti.com>

>From 9ec9fef55a7fbfc9f813a521bed6158db1aad46f Mon Sep 17 00:00:00 2001
From: Sergio Aguirre <saaguirre@ti.com>
Date: Wed, 25 Feb 2009 15:26:35 -0600
Subject: [PATCH 1/2] OMAP3430SDP: Remove unneded extern line

This patch removes a duplicate extern on board-3430sdp.c
file, as it is present already on

arch/arm/plat-omap/include/mach/board-3430sdp.h

Found by doing a checkpatch.pl run with board-3430sdp.c

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
---
 arch/arm/mach-omap2/board-3430sdp.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 758183c..ab0aa7d 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -623,8 +623,6 @@ static int __init omap3430_i2c_init(void)
 	return 0;
 }
 
-extern void __init sdp3430_flash_init(void);
-
 static void __init omap_3430sdp_init(void)
 {
 	omap3430_i2c_init();
-- 
1.5.6.5

