From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [PATCH 0/4] Updates on mcbsp driver (take #2)
Date: Tue, 20 May 2008 14:21:28 +0300
Message-ID: <20080520142128.3498f258.jarkko.nikula@nokia.com>
References: <1210022587-7756-1-git-send-email-edubezval@gmail.com>
	<5e088bd90805190726v69f5d7coc9eebb65d915ff7a@mail.gmail.com>
	<a0580c510805190809l58f507eck62a13f659524b969@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Tue__20_May_2008_14_21_28_+0300_sXQiC650H2bMdjrw"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:28863 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756864AbYETLVg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 May 2008 07:21:36 -0400
In-Reply-To: <a0580c510805190809l58f507eck62a13f659524b969@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Eduardo Valentin <edubezval@gmail.com>
Cc: Steve Sakoman <sakoman@gmail.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Chandra shekhar <x0044955@ti.com>, Eduardo Valentin <eduardo.valentin@indt.org.br>

This is a multi-part message in MIME format.

--Multipart=_Tue__20_May_2008_14_21_28_+0300_sXQiC650H2bMdjrw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 May 2008 11:09:43 -0400
"ext Eduardo Valentin" <edubezval@gmail.com> wrote:

> Hi Steve,
> 
> This series is basically a simple transformation of currect mcbsp code
> to a platform
> driver and a separation of machine specific code.
> 
> It should work for omap1 and omap2 (what is currently supported). But
> it should add basic support  for omap3
> mcbps 1 and 2. Chandra will send his patches on top of this series to
> add more features for omap3.
> 
For those who are keen to try ASoC on OMAP3 might want to try attached
patch on top of Eduardo's set.

I'll prepare better one when there are more ports defined. E.g.
there is no need to separe omap34xx_dma_regs table since request
numbers are the same between OMAP2 and OMAP3.


Jarkko

--Multipart=_Tue__20_May_2008_14_21_28_+0300_sXQiC650H2bMdjrw
Content-Type: text/x-diff;
 name="0001-ASoC-OMAP-Add-basic-support-for-OMAP34xx-in-McBSP.patch"
Content-Disposition: attachment;
 filename="0001-ASoC-OMAP-Add-basic-support-for-OMAP34xx-in-McBSP.patch"
Content-Transfer-Encoding: 7bit

>From a1dbb6dd28e9815a307b87b8d96dcf371d6cfd58 Mon Sep 17 00:00:00 2001
From: Jarkko Nikula <jarkko.nikula@nokia.com>
Date: Mon, 19 May 2008 13:24:41 +0300
Subject: [PATCH] ASoC: OMAP: Add basic support for OMAP34xx in McBSP DAI driver

This adds support for OMAP34xx McBSP port 1 and 2.

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 sound/soc/omap/omap-mcbsp.c |   20 +++++++++++++++++++-
 1 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 40d87e6..8e6ec9d 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -99,6 +99,21 @@ static const unsigned long omap2420_mcbsp_port[][2] = {
 static const int omap2420_dma_reqs[][2] = {};
 static const unsigned long omap2420_mcbsp_port[][2] = {};
 #endif
+#if defined(CONFIG_ARCH_OMAP34XX)
+static const int omap34xx_dma_reqs[][2] = {
+	{ OMAP24XX_DMA_MCBSP1_TX, OMAP24XX_DMA_MCBSP1_RX },
+	{ OMAP24XX_DMA_MCBSP2_TX, OMAP24XX_DMA_MCBSP2_RX },
+};
+static const unsigned long omap34xx_mcbsp_port[][2] = {
+	{ OMAP34XX_MCBSP1_BASE + OMAP_MCBSP_REG_DXR2,
+	  OMAP34XX_MCBSP1_BASE + OMAP_MCBSP_REG_DRR2 },
+	{ OMAP34XX_MCBSP2_BASE + OMAP_MCBSP_REG_DXR2,
+	  OMAP34XX_MCBSP2_BASE + OMAP_MCBSP_REG_DRR2 },
+};
+#else
+static const int omap34xx_dma_reqs[][2] = {};
+static const unsigned long omap34xx_mcbsp_port[][2] = {};
+#endif
 
 static int omap_mcbsp_dai_startup(struct snd_pcm_substream *substream)
 {
@@ -169,9 +184,12 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 	} else if (cpu_is_omap2420()) {
 		dma = omap2420_dma_reqs[bus_id][substream->stream];
 		port = omap2420_mcbsp_port[bus_id][substream->stream];
+	} else if (cpu_is_omap343x()) {
+		dma = omap34xx_dma_reqs[bus_id][substream->stream];
+		port = omap34xx_mcbsp_port[bus_id][substream->stream];
 	} else {
 		/*
-		 * TODO: Add support for 2430 and 3430
+		 * TODO: Add support for 2430
 		 */
 		return -ENODEV;
 	}
-- 
1.5.5.1


--Multipart=_Tue__20_May_2008_14_21_28_+0300_sXQiC650H2bMdjrw--
