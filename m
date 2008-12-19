From: "Lopez Cruz, Misael" <x0052729@ti.com>
Subject: SoC: OMAP: Initialize XCCR and RCCR registers in McBSP DAI driver
Date: Thu, 18 Dec 2008 20:54:20 -0600
Message-ID: <2C7D3DF36ADFFC479B44490D912B616705A484AAD7@dlee07.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56226 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752047AbYLSCyc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Dec 2008 21:54:32 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>, Jarkko Nikula <jarkko.nikula@nokia.com>

This patch explicitly initializes McBSP Transmit Configuration
Control Register (XCCR) and Receive Configuration Control
Register (RCCR) to their reset values. Reset values are 26 ns
of DX delay and Transmit DMA disabled for XCCR register;
receive full cycle mode enabled and Receive DMA disabled for
RCCR register.

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
