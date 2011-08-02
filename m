From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 0/4] ASoC: OMAP4: McPDM: Fix legacy support
Date: Tue, 2 Aug 2011 14:34:13 +0300
Message-ID: <1312284857-1774-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51866 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751953Ab1HBLe1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 2 Aug 2011 07:34:27 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, Misael Lopez Cruz <misael.lopez@ti.com>, Benoit Cousson <b-cousson@ti.com>, Sebastien Guiriec <s-guiriec@ti.com>

Hello,

The OMAP4 McPDM driver in upstream has been broken for some time...
This series fixes that, and enables basic audio playback/capture over the
mcpdm interface.

Two patch in this series has been taken from the "OMAP4/ASoC: New McPDM driver"
series (patch 1, and 2) [1]. Since I was on holiday, I did not had time to
rewrite the driver rewrite patch, but I feel that fixing the basic audio support
for OMAP4 is needed.
The aim here is to have working audio in upstream kernel for 3.1, and have the
new McPDM driver stack up for the 3.2 release.

[1] http://mailman.alsa-project.org/pipermail/alsa-devel/2011-July/041687.html

Br,
Peter

---
Peter Ujfalusi (4):
  OMAP: McPDM: Convert McPDM device to omap_device
  OMAP4: hwmod: enable mcpdm hwmod device.
  ASoC: omap-mcpdm: Fix threshold and dma configuration
  ASoC: OMAP4: McPDM: Convert to hwmod/omap_device

 arch/arm/mach-omap2/devices.c              |   33 ++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    2 +-
 arch/arm/plat-omap/devices.c               |   36 --------------------------
 sound/soc/omap/mcpdm.c                     |   38 +++++++++++++++------------
 sound/soc/omap/mcpdm.h                     |    1 -
 sound/soc/omap/omap-mcpdm.c                |   19 +++++++++----
 sound/soc/omap/sdp4430.c                   |    2 +-
 7 files changed, 69 insertions(+), 62 deletions(-)

-- 
1.7.6

