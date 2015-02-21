From: =?UTF-8?q?Thomas=20Niederpr=C3=BCm?= <niederp@physik.uni-kl.de>
Subject: [PATCH v2 RESEND] ASoC: OMAP: mcbsp: ensure that CLKX and CLKR are not used as ouput pins when they are used as input clock for the SRG.
Date: Sat, 21 Feb 2015 18:11:29 +0100
Message-ID: <1424538689-6330-1-git-send-email-niederp@physik.uni-kl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailgw1.uni-kl.de ([131.246.120.220]:44192 "EHLO
	mailgw1.uni-kl.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751359AbbBURJD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 21 Feb 2015 12:09:03 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: broonie@kernel.org, peter.ujfalusi@ti.com, jarkko.nikula@bitmer.com
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, =?UTF-8?q?Thomas=20Niederpr=C3=BCm?= <niederp@physik.uni-kl.de>

This patch fixes faulty behaviour in a setup where the input clock for =
the
SRG is fed through the CLKR/CLKX pin but the McBSP is configured to be
master (SND_SOC_DAIFMT_CBS_CFS). In that case of course CLKR/CLKX must
not be configured as output pin. Otherwise the input clock is messed up
horribly.

This patch makes it possible to use the CLKR/CLKX pin rather than CLKS =
to
inject a reference clock in setups where McBSP is master and not both
rx and tx are used. However for this to work it has to be ensured that
set_dai_sysclk() is called after set_dai_fmt().

This was tested on a beagleboard-xm using McBSP1 to drive a i2s DAC thr=
ough
the tx lines (CLKX,FSX,DX). Using this patch the CLKR pin is used to in=
ject
an external reference clock.

Signed-off-by: Thomas Niederpr=C3=BCm <niederp@physik.uni-kl.de>
Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
changes since v1:
- added comments explaining the bit masking to disable output on CLKR/C=
LKX

 sound/soc/omap/omap-mcbsp.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index bd3ef2a..662269c 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -530,8 +530,19 @@ static int omap_mcbsp_dai_set_dai_sysclk(struct sn=
d_soc_dai *cpu_dai,
=20
 	case OMAP_MCBSP_SYSCLK_CLKX_EXT:
 		regs->srgr2	|=3D CLKSM;
+		regs->pcr0	|=3D SCLKME;
+		/*
+		 * If McBSP is master but yet the CLKX/CLKR pin drives the SRG,
+		 * disable output on those pins. This enables to inject the
+		 * reference clock through CLKX/CLKR. For this to work
+		 * set_dai_sysclk() _needs_ to be called after set_dai_fmt().
+		 */
+		regs->pcr0	&=3D ~CLKXM;
+		break;
 	case OMAP_MCBSP_SYSCLK_CLKR_EXT:
 		regs->pcr0	|=3D SCLKME;
+		/* Disable ouput on CLKR pin in master mode */
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
