From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 07/19] Code clean-up for sound/arm/omap/omap-alsa-dma.h
Date: Tue, 15 Apr 2008 10:02:11 -0400
Message-ID: <1208268143-8789-8-git-send-email-edubezval@gmail.com>
References: <1208268143-8789-1-git-send-email-edubezval@gmail.com>
 <1208268143-8789-2-git-send-email-edubezval@gmail.com>
 <1208268143-8789-3-git-send-email-edubezval@gmail.com>
 <1208268143-8789-4-git-send-email-edubezval@gmail.com>
 <1208268143-8789-5-git-send-email-edubezval@gmail.com>
 <1208268143-8789-6-git-send-email-edubezval@gmail.com>
 <1208268143-8789-7-git-send-email-edubezval@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:40405 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760072AbYDOOCe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Apr 2008 10:02:34 -0400
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m3FE2OtJ008356
	for <linux-omap@vger.kernel.org>; Tue, 15 Apr 2008 17:02:32 +0300
In-Reply-To: <1208268143-8789-7-git-send-email-edubezval@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Eduardo Valentin <eduardo.valentin@indt.org.br>

From: Eduardo Valentin <eduardo.valentin@indt.org.br>

Removed lots of whitespaces and a few errors and
warnings reported by checkpatch.pl.

Signed-off-by: Eduardo Valentin <eduardo.valentin@indt.org.br>
---
 sound/arm/omap/omap-alsa-dma.h |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/sound/arm/omap/omap-alsa-dma.h b/sound/arm/omap/omap-alsa-dma.h
index 1cecc8a..2f0e4e8 100644
--- a/sound/arm/omap/omap-alsa-dma.h
+++ b/sound/arm/omap/omap-alsa-dma.h
@@ -1,4 +1,4 @@
-/*  
+/*
  * linux/sound/arm/omap/omap-alsa-dma.h
  *
  * Common audio DMA handling for the OMAP processors
@@ -6,7 +6,7 @@
  * Copyright (C) 2006 Mika Laitio <lamikr@cc.jyu.fi>
  *
  * Copyright (C) 2005 Instituto Nokia de Tecnologia - INdT - Manaus Brazil
- * 
+ *
  * Copyright (C) 2004 Texas Instruments, Inc.
  *
  * Copyright (C) 2000, 2001 Nicolas Pitre <nico@cam.org>
@@ -21,8 +21,9 @@
  *
  * History:
  *
- * 
- * 2004/08/12  Nishanth Menon - Modified to integrate Audio requirements on 1610,1710 platforms
+ *
+ * 2004/08/12  Nishanth Menon - Modified to integrate Audio requirements on
+ * 				1610, 1710 platforms
  *
  * 2005/07/25  INdT Kernel Team - Renamed to omap-alsa-dma.h. Ported to Alsa.
  */
@@ -30,23 +31,22 @@
 #ifndef __OMAP_AUDIO_ALSA_DMA_H
 #define __OMAP_AUDIO_ALSA_DMA_H
 
-/************************** INCLUDES *************************************/
-
 #include <asm/arch/omap-alsa.h>
 
-/************************** GLOBAL DATA STRUCTURES *********************************/
+/* Global data structures */
 
 typedef void (*dma_callback_t) (int lch, u16 ch_status, void *data);
 
-/**************** ARCH SPECIFIC FUNCIONS *******************************************/
+/* arch specific functions */
 
-void omap_clear_alsa_sound_dma(struct audio_stream * s);
+void omap_clear_alsa_sound_dma(struct audio_stream *s);
 
 int omap_request_alsa_sound_dma(int device_id, const char *device_name,
-			   void *data, int **channels);
+				void *data, int **channels);
 int omap_free_alsa_sound_dma(void *data, int **channels);
 
-int omap_start_alsa_sound_dma(struct audio_stream *s, dma_addr_t dma_ptr,  u_int dma_size);
+int omap_start_alsa_sound_dma(struct audio_stream *s, dma_addr_t dma_ptr,
+				u_int dma_size);
 
 void omap_stop_alsa_sound_dma(struct audio_stream *s);
 
-- 
1.5.5-rc3.GIT

