From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: [PATCHv4 17/20] ASoC: Add runtime check for RFIG and XFIG
Date: Mon, 17 Aug 2009 14:51:16 +0300
Message-ID: <1250509879-6703-18-git-send-email-eduardo.valentin@nokia.com>
References: <1250509879-6703-1-git-send-email-eduardo.valentin@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:23263 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757914AbZHQMFX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Aug 2009 08:05:23 -0400
In-Reply-To: <1250509879-6703-1-git-send-email-eduardo.valentin@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>, Jarkko Nikula <jhnikula@gmail.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Eero Nurkkala <ext-eero.nurkkala@nokia.com>

From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>

This is, no RFIG or XFIG (Not defined in 34xx), correct
initiliazation of rccr and xccr.

Signed-off-by: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
---
 sound/soc/omap/omap-mcbsp.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 6a837ff..a7b0961 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -321,8 +321,11 @@ static int omap_mcbsp_dai_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 	/* Generic McBSP register settings */
 	regs->spcr2	|= XINTM(3) | FREE;
 	regs->spcr1	|= RINTM(3);
-	regs->rcr2	|= RFIG;
-	regs->xcr2	|= XFIG;
+	/* RFIG and XFIG are not defined in 34xx */
+	if (!cpu_is_omap34xx()) {
+		regs->rcr2	|= RFIG;
+		regs->xcr2	|= XFIG;
+	}
 	if (cpu_is_omap2430() || cpu_is_omap34xx()) {
 		regs->xccr = DXENDLY(1) | XDMAEN;
 		regs->rccr = RFULL_CYCLE | RDMAEN;
-- 
1.6.2.GIT

