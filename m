From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 11/19] Code clean-up for sound/arm/omap/omap-alsa-sx1.h
Date: Tue, 15 Apr 2008 10:02:15 -0400
Message-ID: <1208268143-8789-12-git-send-email-edubezval@gmail.com>
References: <1208268143-8789-1-git-send-email-edubezval@gmail.com>
 <1208268143-8789-2-git-send-email-edubezval@gmail.com>
 <1208268143-8789-3-git-send-email-edubezval@gmail.com>
 <1208268143-8789-4-git-send-email-edubezval@gmail.com>
 <1208268143-8789-5-git-send-email-edubezval@gmail.com>
 <1208268143-8789-6-git-send-email-edubezval@gmail.com>
 <1208268143-8789-7-git-send-email-edubezval@gmail.com>
 <1208268143-8789-8-git-send-email-edubezval@gmail.com>
 <1208268143-8789-9-git-send-email-edubezval@gmail.com>
 <1208268143-8789-10-git-send-email-edubezval@gmail.com>
 <1208268143-8789-11-git-send-email-edubezval@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:40412 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761406AbYDOOCg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Apr 2008 10:02:36 -0400
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m3FE2OtL008356
	for <linux-omap@vger.kernel.org>; Tue, 15 Apr 2008 17:02:33 +0300
In-Reply-To: <1208268143-8789-11-git-send-email-edubezval@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Eduardo Valentin <eduardo.valentin@indt.org.br>

From: Eduardo Valentin <eduardo.valentin@indt.org.br>

Removed lots of whitespaces and a few errors and
warnings reported by checkpatch.pl.

Signed-off-by: Eduardo Valentin <eduardo.valentin@indt.org.br>
---
 sound/arm/omap/omap-alsa-sx1.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/sound/arm/omap/omap-alsa-sx1.h b/sound/arm/omap/omap-alsa-sx1.h
index af7a409..9e11e0a 100644
--- a/sound/arm/omap/omap-alsa-sx1.h
+++ b/sound/arm/omap/omap-alsa-sx1.h
@@ -35,7 +35,8 @@
 #define OSC_EN				2
 
 /* Send IPC message to sound server */
-extern int cn_sx1snd_send(unsigned int cmd, unsigned int arg1, unsigned int arg2);
+extern int cn_sx1snd_send(unsigned int cmd, unsigned int arg1,
+				unsigned int arg2);
 /* cmd for IPC_GROUP_DAC */
 #define DAC_VOLUME_UPDATE		0
 #define DAC_SETAUDIODEVICE		1
-- 
1.5.5-rc3.GIT

