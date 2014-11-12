From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v7 00/20] Rework OMAP4+ HDMI audio support
Date: Wed, 12 Nov 2014 12:49:02 +0200
Message-ID: <cover.1415786458.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50944 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752064AbaKLKtd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 Nov 2014 05:49:33 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, tomi.valkeinen@ti.com, Jyri Sarha <jsarha@ti.com>

The patches are based on:
git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git for-next

The base, the patches, and couple of additional not-to-be-merged
omap2plus_defconfig patches can be found here:
https://github.com/jsarha/linux.git omap-hdmi-audio

It would make the most sense to get these in trough fbdev tree. So it
would be nice to get acked-bys (if the patches are Ok) for ASoC side
changes from appropriate maintainers.

Changes since v6:
- "ASoC: omap-hdmi-audio: Add platform device for OMAP HDMI audio support"
  - Fix Kconfig help text
  - Remove #include <sound/simple_card.h>
  - Use snd-soc-dummy codec instead of hdmi-audio-codec
- Add: OMAPDSS: hdmi_wp: Protect reserved bits in hdmi_wp_audio_config_format()
- Add: OMAPDSS: hdmi5_core: Initialize mandatory sample_order parameter
- Add: "OMAPDSS: omapdss.h: Remove audio_state member of struct omap_dss_device"
- "OMAPDSS: hdmi4: Register ASoC platform device for omap hdmi audio"
  - Register "omap-hdmi-audio" with PLATFORM_DEVID_AUTO
- "OMAPDSS: hdmi5: Register ASoC platform device for omap hdmi audio"
  - Register "omap-hdmi-audio" with PLATFORM_DEVID_AUTO
- Add: "OMAPDSS: hdmi5: Change hdmi_wp idlemode to to no_idle for audio playback"

Jyri Sarha (20):
  OMAPDSS: hdmi_wp: Protect reserved bits in
    hdmi_wp_audio_config_format()
  OMAPDSS: hdmi5_core: Initialize mandatory sample_order parameter
  OMAPDSS: hdmi.h: Add HDMI_AUDIO_LAYOUT_6CH enum value
  OMAPDSS: hdmi: Remove most of OMAP[45]_DSS_HDMI_AUDIO ifdefs
  OMAPDSS: hdmi4_core: Remove unused hdmi4_audio_get_dma_port()
  OMAPDSS: omapdss.h: Remove audio_state member of struct
    omap_dss_device
  OMAPDSS: hdmi_wp: Add function for getting audio dma address
  OMAPDSS: hdmi: Make hdmi structure public
  OMAPDSS: hdmi: Add pdev pointer for audio_pdev in HDMI DRV data
  ASoC: omap-hdmi-audio: Add platform device for OMAP HDMI audio
    support
  OMAPDSS: Kconfig: Remove HDMI audio booleans from Kconfig
  OMAPDSS: hdmi: Make hdmi_mode_has_audio() more user friedly
  OMAPDSS: hdmi.h: Add members to hdmi drvdata for audio implementation
  OMAPDSS: hdmi4: Remove callbacks for the old ASoC DAI driver
  OMAPDSS: hdmi4: Register ASoC platform device for omap hdmi audio
  OMAPDSS: hdmi5: Remove callbacks for the old ASoC DAI driver
  OMAPDSS: hdmi5: Register ASoC platform device for omap hdmi audio
  ASoC: omap: Remove obsolete HDMI audio code and Kconfig options
  OMAPDSS: Remove all references to obsolete HDMI audio callbacks
  OMAPDSS: hdmi5: Change hdmi_wp idlemode to to no_idle for audio
    playback

 .../fbdev/omap2/displays-new/connector-hdmi.c      |   99 -----
 .../fbdev/omap2/displays-new/encoder-tpd12s015.c   |   56 ---
 drivers/video/fbdev/omap2/dss/Kconfig              |    7 -
 drivers/video/fbdev/omap2/dss/hdmi.h               |   38 +-
 drivers/video/fbdev/omap2/dss/hdmi4.c              |  269 +++++++------
 drivers/video/fbdev/omap2/dss/hdmi4_core.c         |   14 -
 drivers/video/fbdev/omap2/dss/hdmi4_core.h         |    4 -
 drivers/video/fbdev/omap2/dss/hdmi5.c              |  265 ++++++-------
 drivers/video/fbdev/omap2/dss/hdmi5_core.c         |    9 +-
 drivers/video/fbdev/omap2/dss/hdmi5_core.h         |    2 -
 drivers/video/fbdev/omap2/dss/hdmi_common.c        |    2 -
 drivers/video/fbdev/omap2/dss/hdmi_wp.c            |   16 +-
 include/sound/omap-hdmi-audio.h                    |   43 +++
 include/video/omapdss.h                            |   40 --
 sound/soc/omap/Kconfig                             |   26 +-
 sound/soc/omap/Makefile                            |    6 +-
 sound/soc/omap/omap-hdmi-audio.c                   |  407 ++++++++++++++++++++
 sound/soc/omap/omap-hdmi-card.c                    |   87 -----
 sound/soc/omap/omap-hdmi.c                         |  364 -----------------
 sound/soc/omap/omap-hdmi.h                         |   38 --
 20 files changed, 781 insertions(+), 1011 deletions(-)
 create mode 100644 include/sound/omap-hdmi-audio.h
 create mode 100644 sound/soc/omap/omap-hdmi-audio.c
 delete mode 100644 sound/soc/omap/omap-hdmi-card.c
 delete mode 100644 sound/soc/omap/omap-hdmi.c
 delete mode 100644 sound/soc/omap/omap-hdmi.h

-- 
1.7.9.5

