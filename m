From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v3 00/14] Rework OMAP4+ HDMI audio support
Date: Fri, 8 Aug 2014 16:23:41 +0300
Message-ID: <cover.1407503813.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42270 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756649AbaHHNYR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Aug 2014 09:24:17 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, tomi.valkeinen@ti.com, detheridge@ti.com, Jyri Sarha <jsarha@ti.com>

Question to ASoC maintainers:
  Do feel it is Ok to put ASoC code outside sound/soc the way I do
  in these patches (in patch 0006 particularly)?

The patches are based on:
git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git for-next

The base, the patches, and couple of additional not-to-be-merged
omap2plus_defconfig patches can be found here:

git://git.ti.com/~jyrisarha/ti-linux-kernel/jyrisarhas-audio-video-linux-feature-tree.git omap-hdmi-audio

Changes since v2 version of the patches:
- Add "OMAPDSS: hdmi_common: hdmi_compute_acr is needed for OMAP5 HDMI audio too"
- Fix "OMAPDSS: hdmi: Make hdmi structure public". There was no need to make
  "core"-member a pointer.
- Make functional division between hdmi_audio.c and hdmi[45].c more clear.
  hdmi_audio.c does not touch anything but "audio"-member in omap_hdmi struct
  that is stored in drvdata.

The patch set fixes OMAP4+ HDMI audio. The structure of the
implementation looks a bit different than before. Instead of creating
a driver specific API for a separate ASoC component driver to connect
to, this implementation integrates an the ASoC cpu-dai component
driver into the HDMI driver. Also the other ASoC component drivers
needed for operational audio are automatically registered by the HDMI
driver. There is no need to add anything to the device tree as long as
the nodes needed for HDMI video are there.

Big part of the HDMI audio code is still unchanged and there is a need
for a cleanup there. Also there is still probably something wrong with
speaker mapping of multi-channel streams. I will get back to cleaning
up these issues later.

Best regards,
Jyri

Jyri Sarha (14):
  ARM: OMAP2+: Remove non working OMAP HDMI audio initialization
  OMAPDSS: hdmi.h: Add HDMI_AUDIO_LAYOUT_6CH enum value
  OMAPDSS: hdmi_common: hdmi_compute_acr is needed for OMAP5 HDMI audio
    too
  OMAPDSS: hdmi_wp: Add function for getting audio dma address
  OMAPDSS: hdmi: Make hdmi structure public
  OMAPDSS: hdmi_audio: Integrated ASoC DAI component driver
    implementation
  OMAPDSS: Kconfig: Update OMAP4_DSS_HDMI_AUDIO option
  OMAPDSS: hdmi4: Register HDMI audio ASoC drivers from HDMI driver
  OMAPDSS: Kconfig: Update OMAP5_DSS_HDMI_AUDIO option
  OMAPDSS: hdmi5: Register HDMI audio ASoC drivers from HDMI driver
  ASoC: omap: Remove obsolete HDMI audio code and Kconfig options
  OMAPDSS: hdmi4: Remove callbacks for an external ASoC DAI driver
  OMAPDSS: hdmi5: Remove callbacks for an external ASoC DAI driver
  OMAPDSS: Remove all references to obsolete HDMI audio callbacks

 arch/arm/mach-omap2/devices.c                      |   28 --
 .../fbdev/omap2/displays-new/connector-hdmi.c      |   99 ------
 .../fbdev/omap2/displays-new/encoder-tpd12s015.c   |   56 ---
 drivers/video/fbdev/omap2/dss/Kconfig              |   29 +-
 drivers/video/fbdev/omap2/dss/Makefile             |    1 +
 drivers/video/fbdev/omap2/dss/hdmi.h               |   61 +++-
 drivers/video/fbdev/omap2/dss/hdmi4.c              |  231 +++++--------
 drivers/video/fbdev/omap2/dss/hdmi5.c              |  213 +++++-------
 drivers/video/fbdev/omap2/dss/hdmi_audio.c         |  298 ++++++++++++++++
 drivers/video/fbdev/omap2/dss/hdmi_common.c        |    2 +-
 drivers/video/fbdev/omap2/dss/hdmi_wp.c            |    6 +
 include/video/omapdss.h                            |   31 --
 sound/soc/omap/Kconfig                             |   13 -
 sound/soc/omap/Makefile                            |    4 -
 sound/soc/omap/omap-hdmi-card.c                    |   87 -----
 sound/soc/omap/omap-hdmi.c                         |  364 --------------------
 sound/soc/omap/omap-hdmi.h                         |   38 --
 17 files changed, 567 insertions(+), 994 deletions(-)
 create mode 100644 drivers/video/fbdev/omap2/dss/hdmi_audio.c
 delete mode 100644 sound/soc/omap/omap-hdmi-card.c
 delete mode 100644 sound/soc/omap/omap-hdmi.c
 delete mode 100644 sound/soc/omap/omap-hdmi.h

-- 
1.7.9.5

