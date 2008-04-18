From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 11/19] Code clean-up for sound/arm/omap/omap-alsa-sx1.h
Date: Fri, 18 Apr 2008 04:00:58 -0400
Message-ID: <1208505666-13744-12-git-send-email-edubezval@gmail.com>
References: <1208505666-13744-1-git-send-email-edubezval@gmail.com>
 <1208505666-13744-2-git-send-email-edubezval@gmail.com>
 <1208505666-13744-3-git-send-email-edubezval@gmail.com>
 <1208505666-13744-4-git-send-email-edubezval@gmail.com>
 <1208505666-13744-5-git-send-email-edubezval@gmail.com>
 <1208505666-13744-6-git-send-email-edubezval@gmail.com>
 <1208505666-13744-7-git-send-email-edubezval@gmail.com>
 <1208505666-13744-8-git-send-email-edubezval@gmail.com>
 <1208505666-13744-9-git-send-email-edubezval@gmail.com>
 <1208505666-13744-10-git-send-email-edubezval@gmail.com>
 <1208505666-13744-11-git-send-email-edubezval@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:18867 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756142AbYDRIBh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Apr 2008 04:01:37 -0400
In-Reply-To: <1208505666-13744-11-git-send-email-edubezval@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <me@felipebalbi.com>, Ragner Magalhaes <ragner.magalhaes@indt.org.br>, Eduardo Valentin <eduardo.valentin@indt.org.br>

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

