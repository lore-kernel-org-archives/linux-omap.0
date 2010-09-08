From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: [PATCH] OMAP: McBSP: Fix static function warning
Date: Wed,  8 Sep 2010 08:53:43 +0530
Message-ID: <1283916223-23567-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37206 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753194Ab0IHDZg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Sep 2010 23:25:36 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: alsa-devel@alsa-project.org, Jarkko Nikula <jhnikula@gmail.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>

This patch fixes sparse warning due non declaration of static function

sound/soc/omap/omap-mcbsp.c:783:5: warning: symbol 'omap_mcbsp_st_info_volsw' was not declared. Should it be static?

Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
Cc: alsa-devel@alsa-project.org
Cc: Jarkko Nikula <jhnikula@gmail.com>
Cc: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
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

