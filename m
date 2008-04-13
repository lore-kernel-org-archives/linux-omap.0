From: Carlos Aguiar <carlos.aguiar@indt.org.br>
Subject: [PATCH 1/1] [ALSA] Remove useless sound/driver.h
Date: Sun, 13 Apr 2008 19:49:32 -0400
Message-ID: <48029C0C.7090708@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:16795 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753121AbYDMXtq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 13 Apr 2008 19:49:46 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

From: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>

This patch removes useless include/sound/driver.h from sound/arm/omap/ files.

Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>
---
 sound/arm/omap/eac.c                     |    1 -
 sound/arm/omap/omap-alsa-aic23-mixer.c   |    1 -
 sound/arm/omap/omap-alsa-aic23.c         |    1 -
 sound/arm/omap/omap-alsa-aic23.h         |    1 -
 sound/arm/omap/omap-alsa-tsc2102-mixer.c |    1 -
 sound/arm/omap/omap-alsa.c               |    1 -
 6 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/sound/arm/omap/eac.c b/sound/arm/omap/eac.c
index c4bbf61..6ae2677 100644
--- a/sound/arm/omap/eac.c
+++ b/sound/arm/omap/eac.c
@@ -42,7 +42,6 @@
 #include <asm/io.h>
 #include <asm/arch/eac.h>
 
-#include <sound/driver.h>
 #include <sound/core.h>
 #include <sound/initval.h>
 
diff --git a/sound/arm/omap/omap-alsa-aic23-mixer.c b/sound/arm/omap/omap-alsa-aic23-mixer.c
index 38be650..ce55824 100644
--- a/sound/arm/omap/omap-alsa-aic23-mixer.c
+++ b/sound/arm/omap/omap-alsa-aic23-mixer.c
@@ -39,7 +39,6 @@
 
 #include <linux/kernel.h>
 
-#include <sound/driver.h>
 #include <asm/arch/aic23.h>
 
 #include <asm/arch/omap-alsa.h>
diff --git a/sound/arm/omap/omap-alsa-aic23.c b/sound/arm/omap/omap-alsa-aic23.c
index 1e8a101..4d67fa3 100644
--- a/sound/arm/omap/omap-alsa-aic23.c
+++ b/sound/arm/omap/omap-alsa-aic23.c
@@ -17,7 +17,6 @@
  * option) any later version.
  */
 
-#include <sound/driver.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/initval.h>
diff --git a/sound/arm/omap/omap-alsa-aic23.h b/sound/arm/omap/omap-alsa-aic23.h
index 63907c4..e2e2d59 100644
--- a/sound/arm/omap/omap-alsa-aic23.h
+++ b/sound/arm/omap/omap-alsa-aic23.h
@@ -18,7 +18,6 @@
 #ifndef __OMAP_ALSA_AIC23_H
 #define __OMAP_ALSA_AIC23_H
 
-#include <sound/driver.h>
 #include <asm/arch/dma.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
diff --git a/sound/arm/omap/omap-alsa-tsc2102-mixer.c b/sound/arm/omap/omap-alsa-tsc2102-mixer.c
index d1c8b65..99b1a1d 100644
--- a/sound/arm/omap/omap-alsa-tsc2102-mixer.c
+++ b/sound/arm/omap/omap-alsa-tsc2102-mixer.c
@@ -32,7 +32,6 @@
 
 #include <asm/arch/omap-alsa.h>
 
-#include <sound/driver.h>
 #include <sound/initval.h>
 #include <sound/control.h>
 
diff --git a/sound/arm/omap/omap-alsa.c b/sound/arm/omap/omap-alsa.c
index 8d0f394..30c7942 100644
--- a/sound/arm/omap/omap-alsa.c
+++ b/sound/arm/omap/omap-alsa.c
@@ -46,7 +46,6 @@
 #ifdef CONFIG_PM
 #include <linux/pm.h>
 #endif
-#include <sound/driver.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 
-- 1.5.3.GIT

