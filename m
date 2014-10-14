From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v6 00/18] Rework OMAP4+ HDMI audio support
Date: Tue, 14 Oct 2014 20:29:19 +0300
Message-ID: <cover.1413306131.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36069 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753241AbaJNR3r (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Oct 2014 13:29:47 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, tomi.valkeinen@ti.com, detheridge@ti.com, Jyri Sarha <jsarha@ti.com>

The patches are based on:
git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git for-next

The base, the patches, and couple of additional not-to-be-merged
omap2plus_defconfig patches can be found here:
https://github.com/jsarha/linux.git

It would make the most sense to get these in trough fbdev tree. So it
would be nice to get acked-bys (if the patches are Ok) for ASoC side
changes from appropriate maintainers.

Changes since v5:
Still lot of changes, most of them were suggested by Tomi
Valkeinen. The most significant changes:
- Fix HDMI unplugging crashes when playing audio etc.
- Don't use simple-card but implement bare minimum ASoC card under pdev
- Register cpu-dai under OMAPDSS HDMI device and get dai drvdata
  trough card drvdata via snd_pcm_substream
- Some more cleaning up

Changes since v4:
- Turn ASoC parts into a platform device driver
- Some cleaning up
- reorder the patches to keep bisect working

Changes since v3:
- Move ASoC parts into library module under sound/soc/omap
- Come up with API for the library 
- Some cleaning up

The patch set fixes OMAP4+ HDMI audio. The structure of the
implementation looks a bit different than before. Instead of creating
a driver specific API for a separate ASoC component driver to connect
to, these patches implement a platform device driver under
sound/soc/omap for ASoC side implementation. This driver should only
be registered from OMAPDSS HDMI code. 

The ASoC side driver implements cpu-dai component using the callbacks
provided by OMAPDSS and registers the component under DSS HDMI
device. Omap-pcm is registered for platform component, dummy
hdmi-audio-codec is registered for codec component, and ASoC driver
implements also a bare minimum card driver and registeres it under
itself.

Big part of the HDMI audio code is still unchanged and there is a need
for a cleanup there. Also there is still probably something wrong with
speaker mapping of multi-channel streams. I will get back to cleaning
up these issues later.

Best regards,
Jyri

  OMAPDSS: hdmi.h: Add HDMI_AUDIO_LAYOUT_6CH enum value
  OMAPDSS: hdmi: Remove most of OMAP[45]_DSS_HDMI_AUDIO ifdefs
  OMAPDSS: hdmi4_core: Remove unused hdmi4_audio_get_dma_port()
  OMAPDSS: hdmi_wp: Add function for getting audio dma address
  OMAPDSS: hdmi: Make hdmi structure public
  OMAPDSS: hdmi: Add pdev pointer for audio_pdev in HDMI DRV data
  ASoC: codecs/hdmi: Mark the maximum significant bits to HDMI codec
  ASoC: codecs/hdmi: HDMI codec doesn't benefit from pmdown delay
  ASoC: omap-hdmi-audio: Add platfrom device for OMAP HDMI audio
    support
  OMAPDSS: Kconfig: Remove HDMI audio booleans from Kconfig
  OMAPDSS: hdmi: Make hdmi_mode_has_audio() more user friedly
  OMAPDSS: hdmi.h: Add members to hdmi drvdata for audio implementation
  OMAPDSS: hdmi4: Remove callbacks for the old ASoC DAI driver
  OMAPDSS: hdmi4: Register ASoC platfrom device for omap hdmi audio
  OMAPDSS: hdmi5: Remove callbacks for the old ASoC DAI driver
  OMAPDSS: hdmi5: Register ASoC platfrom device for omap hdmi audio
  ASoC: omap: Remove obsolete HDMI audio code and Kconfig options
  OMAPDSS: Remove all references to obsolete HDMI audio callbacks

 .../fbdev/omap2/displays-new/connector-hdmi.c      |   99 -----
 .../fbdev/omap2/displays-new/encoder-tpd12s015.c   |   56 ---
 drivers/video/fbdev/omap2/dss/Kconfig              |    7 -
 drivers/video/fbdev/omap2/dss/hdmi.h               |   37 +-
 drivers/video/fbdev/omap2/dss/hdmi4.c              |  268 ++++++-------
 drivers/video/fbdev/omap2/dss/hdmi4_core.c         |   14 -
 drivers/video/fbdev/omap2/dss/hdmi4_core.h         |    4 -
 drivers/video/fbdev/omap2/dss/hdmi5.c              |  257 ++++++------
 drivers/video/fbdev/omap2/dss/hdmi5_core.c         |    6 -
 drivers/video/fbdev/omap2/dss/hdmi5_core.h         |    2 -
 drivers/video/fbdev/omap2/dss/hdmi_common.c        |    2 -
 drivers/video/fbdev/omap2/dss/hdmi_wp.c            |    8 +-
 include/sound/omap-hdmi-audio.h                    |   43 ++
 include/video/omapdss.h                            |   31 --
 sound/soc/codecs/hdmi.c                            |    2 +
 sound/soc/omap/Kconfig                             |   21 +-
 sound/soc/omap/Makefile                            |    6 +-
 sound/soc/omap/omap-hdmi-audio.c                   |  420 ++++++++++++++++++++
 sound/soc/omap/omap-hdmi-card.c                    |   87 ----
 sound/soc/omap/omap-hdmi.c                         |  364 -----------------
 sound/soc/omap/omap-hdmi.h                         |   38 --
 21 files changed, 772 insertions(+), 1000 deletions(-)
 create mode 100644 include/sound/omap-hdmi-audio.h
 create mode 100644 sound/soc/omap/omap-hdmi-audio.c
 delete mode 100644 sound/soc/omap/omap-hdmi-card.c
 delete mode 100644 sound/soc/omap/omap-hdmi.c
 delete mode 100644 sound/soc/omap/omap-hdmi.h

-- 
1.7.9.5

