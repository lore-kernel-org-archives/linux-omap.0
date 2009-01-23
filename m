From: "Lopez Cruz, Misael" <x0052729@ti.com>
Subject: [PATCH] SoC: OMAP: Initialize XCCR and RCCR registers in McBSP DAI
 driver
Date: Fri, 23 Jan 2009 15:06:34 -0600
Message-ID: <2C7D3DF36ADFFC479B44490D912B616705D5C1E137@dlee07.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47708 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753730AbZAWVGn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Jan 2009 16:06:43 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "alsa-devel-request@alsa-project.org" <alsa-devel-request@alsa-project.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

This patch explicitly initializes McBSP Transmit Configuration
Control Register (XCCR) and Receive Configuration Control
Register (RCCR) to their reset values. Reset values are 26 ns
of DX delay and Transmit DMA disabled for XCCR register;
receive full cycle mode enabled and Receive DMA disabled for
RCCR register.

This patch requires a counterpart in OMAP McBSP driver before
to apply it. The required changes in McBSP were sent and approved
in linux-omap mailing list and patch is going upstream
(commit 3456ef483b5322ba4a7647f024e2c5b7846cd7e3 from linux-omap-2.6
tree).

Signed-off-by: Misael Lopez Cruz <x0052729@ti.com>
---
 sound/soc/omap/omap-mcbsp.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 8485a8a..f50cbaf 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -295,6 +295,10 @@ static int omap_mcbsp_dai_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 	regs->spcr1	|= RINTM(3);
 	regs->rcr2	|= RFIG;
 	regs->xcr2	|= XFIG;
+	if (cpu_is_omap2430() || cpu_is_omap34xx()) {
+		regs->xccr = DXENDLY(1) | XDMAEN;
+		regs->rccr = RFULL_CYCLE | RDMAEN;
+	}
 
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
-- 
1.5.4.3
