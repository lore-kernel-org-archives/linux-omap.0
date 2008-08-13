From: "Hunter, Jon" <jon-hunter@ti.com>
Subject: [PATCH] OMAP5912: Fix omap5912 osk alsa driver [2/2]
Date: Tue, 12 Aug 2008 22:07:31 -0500
Message-ID: <7B4574D56E4ADF438756313E9A172A870D5F0E59@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36465 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752788AbYHMDHi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Aug 2008 23:07:38 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id m7D37WNb004958
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 12 Aug 2008 22:07:37 -0500
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id m7D37WHD006016
	for <linux-omap@vger.kernel.org>; Tue, 12 Aug 2008 22:07:32 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Corrected header file path in file sound/arm/omap/omap-alsa-dma.c.


Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 sound/arm/omap/omap-alsa-dma.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/arm/omap/omap-alsa-dma.c b/sound/arm/omap/omap-alsa-dma.c
index d263933..baafacf 100644
--- a/sound/arm/omap/omap-alsa-dma.c
+++ b/sound/arm/omap/omap-alsa-dma.c
@@ -64,9 +64,9 @@
 #include <linux/dma-mapping.h>
 #include <linux/io.h>
 #include <linux/uaccess.h>
+#include <linux/semaphore.h>

 #include <asm/hardware.h>
-#include <asm/semaphore.h>
 #include <asm/arch/dma.h>
 #include <asm/arch/mcbsp.h>
 #include <asm/arch/omap-alsa.h>
--
1.4.4.4
