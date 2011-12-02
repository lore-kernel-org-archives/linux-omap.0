From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 0/5] ASoC: OMAP4: Device tree support for DMIC, McPDM
Date: Fri,  2 Dec 2011 11:52:55 +0200
Message-ID: <1322819580-7424-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:39270 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753218Ab1LBJxP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Dec 2011 04:53:15 -0500
Received: by mail-fx0-f47.google.com with SMTP id a19so1801129faa.20
        for <linux-omap@vger.kernel.org>; Fri, 02 Dec 2011 01:53:14 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>
Cc: Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

Hello,

The following series adds device tree support for omap-dmic, omap-mcpdm ASoC
DAI drivers.

The OMAP4 platform patches have dependency on the DMIC driver series:
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg59161.html

Regards,
Peter
---
Peter Ujfalusi (5):
  ASoC: omap-dmic: Add device tree bindings
  ASoC: omap-mcpdm: Add device tree bindings
  OMAP4: devices: Do not create dmic device if the dtb has been
    provided
  OMAP4: devices: Do not create mcpdm device if the dtb has been
    provided
  ARM: OMAP4: DTS: Support for dmic, and McPDM in device tree

 .../bindings/sound/soc/omap/omap-dmic.txt          |   13 +++++++++++++
 .../bindings/sound/soc/omap/omap-mcpdm.txt         |   13 +++++++++++++
 arch/arm/boot/dts/omap4-panda.dts                  |    4 ++++
 arch/arm/boot/dts/omap4.dtsi                       |    9 +++++++++
 arch/arm/mach-omap2/devices.c                      |    8 ++++++++
 sound/soc/omap/omap-dmic.c                         |    8 ++++++++
 sound/soc/omap/omap-mcpdm.c                        |    8 ++++++++
 7 files changed, 63 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/soc/omap/omap-dmic.txt
 create mode 100644 Documentation/devicetree/bindings/sound/soc/omap/omap-mcpdm.txt

-- 
1.7.8.rc4

