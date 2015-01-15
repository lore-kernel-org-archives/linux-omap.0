From: =?UTF-8?q?Thomas=20Niederpr=C3=BCm?= <niederp@physik.uni-kl.de>
Subject: [PATCH] ASoC: OMAP: mcbsp: ensure that CLKX and CLKR are not used as ouput pins when they are used as input clock for the SRG.
Date: Thu, 15 Jan 2015 23:28:21 +0100
Message-ID: <1421360901-20671-1-git-send-email-niederp@physik.uni-kl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailgw1.uni-kl.de ([131.246.120.220]:53297 "EHLO
	mailgw1.uni-kl.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753086AbbAOWiv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Jan 2015 17:38:51 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: peter.ujfalusi@ti.com, jarkko.nikula@bitmer.com
Cc: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, =?UTF-8?q?Thomas=20Niederpr=C3=BCm?= <niederp@physik.uni-kl.de>

This patch fixes faulty behaviour in a setup where the input clock for
the SRG is fed through the CLKR pin but the McBSP is configured to be
master (SND_SOC_DAIFMT_CBS_CFS). In that case of course CLKR must not b=
e
configured as output pin. Otherwise the input clock is messed up
horribly. The same reasoning applies if CLKX is configured as input for
the SRG.

Signed-off-by: Thomas Niederpr=C3=BCm <niederp@physik.uni-kl.de>
---
 sound/soc/omap/omap-mcbsp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index bd3ef2a..c89f562 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -530,8 +530,12 @@ static int omap_mcbsp_dai_set_dai_sysclk(struct sn=
d_soc_dai *cpu_dai,
=20
 	case OMAP_MCBSP_SYSCLK_CLKX_EXT:
 		regs->srgr2	|=3D CLKSM;
+		regs->pcr0	|=3D SCLKME;
+		regs->pcr0	&=3D ~CLKXM;
+		break;
 	case OMAP_MCBSP_SYSCLK_CLKR_EXT:
 		regs->pcr0	|=3D SCLKME;
+		regs->pcr0	&=3D ~CLKRM;
 		break;
 	default:
 		err =3D -ENODEV;
--=20
2.1.1

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
