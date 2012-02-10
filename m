From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: Fix build error in sound/soc/omap/n810.c
Date: Fri, 10 Feb 2012 14:54:37 +0800
Message-ID: <1328856877.27353.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:59054 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752440Ab2BJG7K (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Feb 2012 01:59:10 -0500
Received: by daed14 with SMTP id d14so2120517dae.19
        for <linux-omap@vger.kernel.org>; Thu, 09 Feb 2012 22:59:09 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-omap@vger.kernel.org

Fix below build error which is introduced by
commit 022658 "ASoC: core: Add support for DAI and machine kcontrols".

  CC [M]  sound/soc/omap/n810.o
sound/soc/omap/n810.c: In function 'n810_set_input':
sound/soc/omap/n810.c:194: error: 'codec' undeclared (first use in this function)
sound/soc/omap/n810.c:194: error: (Each undeclared identifier is reported only once
sound/soc/omap/n810.c:194: error: for each function it appears in.)
sound/soc/omap/n810.c:188: warning: unused variable 'card'
make[3]: *** [sound/soc/omap/n810.o] Error 1
make[2]: *** [sound/soc/omap] Error 2
make[1]: *** [sound/soc] Error 2
make: *** [sound] Error 2

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/omap/n810.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/omap/n810.c b/sound/soc/omap/n810.c
index 1490227..c292bf0 100644
--- a/sound/soc/omap/n810.c
+++ b/sound/soc/omap/n810.c
@@ -191,7 +191,7 @@ static int n810_set_input(struct snd_kcontrol *kcontrol,
 		return 0;
 
 	n810_dmic_func = ucontrol->value.integer.value[0];
-	n810_ext_control(codec);
+	n810_ext_control(&card->dapm);
 
 	return 1;
 }
-- 
1.7.5.4



