From: Manjunatha GK <manjugk@ti.com>
Subject: [PATCH v2] OMAP: DMA: Init CDAC to zero
Date: Thu,  4 Mar 2010 12:41:56 +0530
Message-ID: <1267686716-22264-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52466 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753065Ab0CDGxP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 4 Mar 2010 01:53:15 -0500
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id o246rEVx032005
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 4 Mar 2010 00:53:15 -0600
Received: from localhost.localdomain (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id o246rC3D025332
	for <linux-omap@vger.kernel.org>; Thu, 4 Mar 2010 00:53:13 -0600 (CST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

The register DMA4_CDAC needs to be initialized to zero
before starting DMA transfer.

Cc: Tony Lindgren <tony@atomide.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Govindraj R <govindraj.raja@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Reported-by:S, Venkatraman <svenkatr@ti.com>
Signed-off-by: Manjunatha GK <manjugk@ti.com>
---
It was aligned to reset CDAC to zero in omap_start_dma(int lch)
instead of creating new API for accessing CDAC register.

Discussion thread is at:
http://patchwork.kernel.org/patch/83176/
http://patchwork.kernel.org/patch/82948/

v2 changes:
Fixed multiline comments as per CodingStyle

 arch/arm/plat-omap/dma.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 2ab224c..f6c9bdc 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -936,6 +936,15 @@ void omap_start_dma(int lch)
 {
 	u32 l;
 
+	/*
+	 * The CPC/CDAC register needs to be initialized to zero
+	 * before starting dma transfer.
+	 */
+	if (cpu_is_omap15xx())
+		dma_write(0, CPC(lch));
+	else
+		dma_write(0, CDAC(lch));
+
 	if (!omap_dma_in_1510_mode() && dma_chan[lch].next_lch != -1) {
 		int next_lch, cur_lch;
 		char dma_chan_link_map[OMAP_DMA4_LOGICAL_DMA_CH_COUNT];
-- 
1.6.3.3

