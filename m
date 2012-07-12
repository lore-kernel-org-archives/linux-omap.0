From: Guillaume Gardet <guillaume.gardet@free.fr>
Subject: [PATCH V2] Add missing modules aliases to get sound working on omap
 devices
Date: Thu, 12 Jul 2012 15:08:16 +0200
Message-ID: <4FFECC40.5020502@free.fr>
Reply-To: guillaume.gardet@free.fr
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010601050203030403070601"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp6.tech.numericable.fr ([82.216.111.42]:39654 "EHLO
	smtp6.tech.numericable.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753420Ab2GLNIU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Jul 2012 09:08:20 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: alsa-devel@alsa-project.org, peter.ujfalusi@ti.com, mans.rullgard@linaro.org, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>

This is a multi-part message in MIME format.
--------------010601050203030403070601
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch add missing modules aliases to get sound working on omap devices.

Tested on Beagleboard xM rev. B.

This patch is against 3.5-rc6 vanilla.

Signed-off-by: Guillaume GARDET <guillaume.gardet@free.fr>
Signed-off-by: Mans Rullgard <mans.rullgard@linaro.org>



--------------010601050203030403070601
Content-Type: text/x-patch;
 name="0001-Add-missing-modules-aliases-to-fix-audio-on-omap-dev.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-Add-missing-modules-aliases-to-fix-audio-on-omap-dev.pa";
 filename*1="tch"

>From 18b1ba8becc3dd256bdaad2d825f46b551debda3 Mon Sep 17 00:00:00 2001
From: Guillaume GARDET <guillaume.gardet@oliseo.fr>
Date: Tue, 10 Jul 2012 13:47:16 +0200
Subject: [PATCH] Add missing modules aliases to fix audio on omap devices

---
 sound/soc/omap/omap-mcbsp.c |    1 +
 sound/soc/omap/omap-pcm.c   |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 1046083..acdd3ef 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -820,3 +820,4 @@ module_platform_driver(asoc_mcbsp_driver);
 MODULE_AUTHOR("Jarkko Nikula <jarkko.nikula@bitmer.com>");
 MODULE_DESCRIPTION("OMAP I2S SoC Interface");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:omap-mcbsp");
diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
index 5a649da..f0feb06 100644
--- a/sound/soc/omap/omap-pcm.c
+++ b/sound/soc/omap/omap-pcm.c
@@ -441,3 +441,4 @@ module_platform_driver(omap_pcm_driver);
 MODULE_AUTHOR("Jarkko Nikula <jarkko.nikula@bitmer.com>");
 MODULE_DESCRIPTION("OMAP PCM DMA module");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:omap-pcm-audio");
-- 
1.7.7


--------------010601050203030403070601--
