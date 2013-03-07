From: Sebastien Guiriec <s-guiriec@ti.com>
Subject: [PATCH 0/5] ASoC: OMAP2+: Update Audio IP with sDMA binding for DT boot
Date: Thu, 7 Mar 2013 13:43:19 +0100
Message-ID: <1362660204-27074-1-git-send-email-s-guiriec@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51407 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751787Ab3CGMoK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 Mar 2013 07:44:10 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastien Guiriec <s-guiriec@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <b-cousson@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org

This patch serie is converting OMAP Audio IPs in order to use OMAP sDMA DT
binding in case of DT boot on OMAP2+ platforms.

It is depending on the next patches:

[1] http://www.spinics.net/lists/arm-kernel/msg227836.html
[2] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg84668.html

It has been tested on:
- OMAP5 (sEVM/panda)in DT boot (McPDM/DMIC).
- OMAP4 (SDP4430/Panda) in both DT/non DT boot (McPDM/DMIC)
- OMAP3 (Beagle XM) in both DT/non DT boot (McBSP)

Sebastien Guiriec (5):
  ASoC: omap-pcm: Move to generic DMA for DT binding
  ASoC: omap-dmic: Update driver for DMA DT binding.
  ASoC: omap-mcpdm: Update driver for DMA DT binding.
  ASoC: omap-mcbsp:Update driver for DMA DT binding.
  ARM: dts: OMAP2+: Add SDMA Audio IPs bindings

 arch/arm/boot/dts/omap2420.dtsi |    6 ++++++
 arch/arm/boot/dts/omap2430.dtsi |   15 +++++++++++++++
 arch/arm/boot/dts/omap3.dtsi    |   15 +++++++++++++++
 arch/arm/boot/dts/omap4.dtsi    |   17 +++++++++++++++++
 arch/arm/boot/dts/omap5.dtsi    |   14 ++++++++++++++
 sound/soc/omap/mcbsp.c          |   26 ++++++++++++++++----------
 sound/soc/omap/omap-dmic.c      |   15 +++++++++------
 sound/soc/omap/omap-mcpdm.c     |   22 ++++++++++++++--------
 sound/soc/omap/omap-pcm.c       |   12 ++++++++++--
 sound/soc/omap/omap-pcm.h       |    1 +
 10 files changed, 117 insertions(+), 26 deletions(-)

-- 
1.7.10.4

