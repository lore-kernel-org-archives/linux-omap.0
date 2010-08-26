From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: [PATCH 06/11] OMAP: McBSP: Fix static function warning
Date: Fri, 27 Aug 2010 02:26:44 +0530
Message-ID: <1282856209-15645-7-git-send-email-manjugk@ti.com>
References: <1282856209-15645-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35378 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752993Ab0HZU6J (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Aug 2010 16:58:09 -0400
In-Reply-To: <1282856209-15645-1-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Manjunatha GK <manjugk@ti.com>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>

From: Manjunatha GK <manjugk@ti.com>

This patch fixes sparse warning due non declaration of static function

sound/soc/omap/omap-mcbsp.c:783:5: warning: symbol 'omap_mcbsp_st_info_volsw' was not declared. Should it be static?

Signed-off-by: Manjunatha GK <manjugk@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Nishanth Menon <nm@ti.com>
---
 sound/soc/omap/omap-mcbsp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 86f2139..5768381 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -780,7 +780,7 @@ struct snd_soc_dai omap_mcbsp_dai[] = {
 
 EXPORT_SYMBOL_GPL(omap_mcbsp_dai);
 
-int omap_mcbsp_st_info_volsw(struct snd_kcontrol *kcontrol,
+static int omap_mcbsp_st_info_volsw(struct snd_kcontrol *kcontrol,
 			struct snd_ctl_elem_info *uinfo)
 {
 	struct soc_mixer_control *mc =
-- 
1.7.0.4

