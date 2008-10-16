From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: [PATCH 9/28] [OMAPZOOM] OMAP: CAM: ISP: MMU Fixes
Date: Wed, 15 Oct 2008 20:22:56 -0500
Message-ID: <A24693684029E5489D1D202277BE894412568840@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50067 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752483AbYJPBXD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Oct 2008 21:23:03 -0400
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id m9G1Mvdr008589
	for <linux-omap@vger.kernel.org>; Wed, 15 Oct 2008 20:23:02 -0500
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id m9G1Mvn7009319
	for <linux-omap@vger.kernel.org>; Wed, 15 Oct 2008 20:22:57 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>

From: Sergio Aguirre <saaguirre@ti.com>

OMAP: CAM: ISP: MMU Fixes

This patch removes cache flush related registers from context save.

Signed-off-by: Mohit Jalori <saaguirre@ti.com>
Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
---
 drivers/media/video/isp/ispmmu.c |    2 --
 1 file changed, 2 deletions(-)

Index: omapkernel/drivers/media/video/isp/ispmmu.c
===================================================================
--- omapkernel.orig/drivers/media/video/isp/ispmmu.c	2008-10-14 10:04:34.000000000 -0500
+++ omapkernel/drivers/media/video/isp/ispmmu.c	2008-10-14 10:20:13.000000000 -0500
@@ -65,8 +65,6 @@
 	{ISPMMU_LD_TLB, 0x0000},
 	{ISPMMU_CAM, 0x0000},
 	{ISPMMU_RAM, 0x0000},
-	{ISPMMU_GFLUSH, 0x0000},
-	{ISPMMU_FLUSH_ENTRY, 0x0000},
 	{ISP_TOK_TERM, 0x0000}
 };

