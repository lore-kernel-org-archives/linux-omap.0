From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 0/3] OMAP4/ASoC: New McPDM driver
Date: Thu, 7 Jul 2011 15:27:49 +0300
Message-ID: <1310041672-18634-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35700 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755716Ab1GGM2F (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 Jul 2011 08:28:05 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, Misael Lopez Cruz <misael.lopez@ti.com>, Sebastien Guiriec <s-guiriec@ti.com>, Benoit Coussoni <b-cousson@ti.com>

Hello,

The following series replaces the current driver for McPDM port.
The current McPDM driver design is not suitable to support both
the ABE and Legacy DMA operating modes. Therefore remove most
of the old driver (and mcpdm.c) and replace it with a
re-designed driver to support both Legacy and ABE modes of operation.

As part of the work the McPDM driver has been converted to omap device,
and from now on it is going to use hwmod.

Patch 2, and 3 was originated from Jorge, and Margarita, but their @ti.com
mail address does not work anymore, so I took those two patch under my name,
but added them as s-o-b without e-mail address.

For the McPDM driver replacement, I forced git to create a complete rewrite
patch to help with the review.

Regards,
Peter

---
Misael Lopez Cruz (1):
  ASoC: omap-mcpdm: Replace legacy driver

Peter Ujfalusi (2):
  OMAP: McPDM: Convert McPDM device to omap_device
  OMAP4: hwmod: enable mcpdm hwmod device.

 arch/arm/mach-omap2/devices.c              |   33 ++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    2 +-
 arch/arm/plat-omap/devices.c               |   36 --
 sound/soc/omap/Makefile                    |    2 +-
 sound/soc/omap/mcpdm.c                     |  470 ----------------
 sound/soc/omap/mcpdm.h                     |  153 -----
 sound/soc/omap/omap-mcpdm.c                |  828 +++++++++++++++++++---------
 sound/soc/omap/omap-mcpdm.h                |  109 ++++
 sound/soc/omap/sdp4430.c                   |    4 +-
 9 files changed, 702 insertions(+), 935 deletions(-)
 delete mode 100644 sound/soc/omap/mcpdm.c
 delete mode 100644 sound/soc/omap/mcpdm.h
 rewrite sound/soc/omap/omap-mcpdm.c (42%)
 create mode 100644 sound/soc/omap/omap-mcpdm.h

-- 
1.7.6

