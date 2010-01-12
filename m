From: Thomas Weber <weber@corscience.de>
Subject: [PATCH] ASoC: TWL4030: Fix typo in comment in header file
Date: Tue, 12 Jan 2010 09:54:47 +0100
Message-ID: <1263286487-27471-1-git-send-email-weber@corscience.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:51700 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753368Ab0ALIzJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Jan 2010 03:55:09 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Thomas Weber <weber@corscience.de>

Signed-off-by: Thomas Weber <weber@corscience.de>
---
 sound/soc/codecs/twl4030.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/twl4030.h b/sound/soc/codecs/twl4030.h
index dd6396e..f206d24 100644
--- a/sound/soc/codecs/twl4030.h
+++ b/sound/soc/codecs/twl4030.h
@@ -25,7 +25,7 @@
 /* Register descriptions are here */
 #include <linux/mfd/twl4030-codec.h>
 
-/* Sgadow register used by the audio driver */
+/* Shadow register used by the audio driver */
 #define TWL4030_REG_SW_SHADOW		0x4A
 #define TWL4030_CACHEREGNUM	(TWL4030_REG_SW_SHADOW + 1)
 
-- 
1.6.4.4

