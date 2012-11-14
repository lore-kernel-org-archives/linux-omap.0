From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH 1/3] ASoC: OMAP: HDMI: Update machine driver name
Date: Tue, 13 Nov 2012 20:30:47 -0600
Message-ID: <1352860249-26348-2-git-send-email-ricardo.neri@ti.com>
References: <1352860249-26348-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50873 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932471Ab2KNCbz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Nov 2012 21:31:55 -0500
In-Reply-To: <1352860249-26348-1-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: broonie@opensource.wolfsonmicro.com, lrg@ti.com
Cc: s-guiriec@ti.com, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, Ricardo Neri <ricardo.neri@ti.com>

Being the name of a machine driver, it aims to describe the connection between
the HDMI IP of the processor and the companion chip it uses to connect to the
outside world. This name tries to follow the same naming convention as in
the OMAP-ABE-TWL6040 machine driver.

TPD12S015 is an HDMI companion chip for DC-DC step-up, I2C level shifter and
low-capacitance ESD protection. This chip is used on all OMAP4 Pandaboards an
SDPs as well as in OMAP5 EVMs.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
---
 sound/soc/omap/omap-hdmi-card.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/omap/omap-hdmi-card.c b/sound/soc/omap/omap-hdmi-card.c
index eaa2ea0..184180e 100644
--- a/sound/soc/omap/omap-hdmi-card.c
+++ b/sound/soc/omap/omap-hdmi-card.c
@@ -27,7 +27,7 @@
 #include <asm/mach-types.h>
 #include <video/omapdss.h>
 
-#define DRV_NAME "omap-hdmi-audio"
+#define DRV_NAME "omap-hdmi-tpd12s015-audio"
 
 static struct snd_soc_dai_link omap_hdmi_dai = {
 	.name = "HDMI",
-- 
1.7.5.4

