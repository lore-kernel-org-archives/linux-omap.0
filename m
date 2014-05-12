From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH 00/19] Rework OMAP4+ HDMI audio support
Date: Mon, 12 May 2014 12:12:11 +0300
Message-ID: <cover.1399884780.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37954 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751000AbaELJMm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 May 2014 05:12:42 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, bcousson@baylibre.com, tomi.valkeinen@ti.com, detheridge@ti.com, Jyri Sarha <jsarha@ti.com>

Since RFC version of the patch set: 
- Split callbacks removal patch away from "Integrated ASoC DAI
  component driver implementation" patches for easier reading

This set of patches fixes OMAP4+ HDMI audio. The structure of the
implementatin looks a bit different than before. Instead of creating a
driver specific API for a separate ASoC component driver to connect
to, this implementation integrates an the component driver into the
HDMI driver.

The idea is to use an existing ASoC component driver API instead of
creating a new custom API for each HDMI IP and to avoid splitting the
driver to half for separate video and audio parts connected with the
API.

The new implementation also uses simple-audio-card for a machine
driver instead of having its own HW specific machine driver.

The patches are based on 3.15-rc2 merged with
git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
and
git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git work/dss-dt-omap5

Everything is pushed here here:
git://git.ti.com/~jyrisarha/ti-linux-kernel/jyrisarhas-audio-video-linux-feature-tree.git omap-hdmi-audio

Best regards,
Jyri

Jyri Sarha (19):
  ASoC: omap-pcm: Move omap-pcm under include/sound
  OMAPDSS: hdmi-common: Add hdmi_dss_audio_from_hw_params()
  OMAPDSS: hdmi4: Remove callbacks for an external ASoC DAI driver
  OMAPDSS: hdmi4: Integrated ASoC DAI component driver implementation
  OMAPDSS: Kconfig: Add depencies and help section to
    OMAP4_DSS_HDMI_AUDIO
  OMAPDSS: hdmi.h: Add HDMI_AUDIO_LAYOUT_6CH enum value
  OMAPDSS: hdmi5_core: Fix compilation with OMAP5_DSS_HDMI_AUDIO
  OMAPDSS: hdmi5: Remove callbacks for an external ASoC DAI driver
  OMAPDSS: hdmi5: Integrated ASoC DAI component driver implementation
  OMAPDSS: Kconfig: Add depencies and help section to
    OMAP5_DSS_HDMI_AUDIO
  ASoC: omap: Remove obsolete HDMI audio code and Kconfig options
  OMAPDSS: Remove obsolete audio code
  ARM: omap4.dtsi: Add audio related parametes to hdmi node
  ARM: omap4-panda-common.dtsi: Add HDMI audio nodes
  ARM: omap5.dtsi: Add audio related parameters to hdmi node
  ARM: omap5-uevm.dts: Add hdmi audio related nodes
  ARM: omap2plus_defconfig: Build DSS HDMI support for OMAP4 in kernel
  ARM: omap2plus_defconfig: Enable OMAP5 HDMI support
  ARM: omap2plus_defconfig: Enable OMAP4+ HDMI audio support

 .../devicetree/bindings/video/ti,omap4-dss.txt     |    4 +
 .../devicetree/bindings/video/ti,omap5-dss.txt     |    4 +
 arch/arm/boot/dts/omap4-panda-common.dtsi          |   21 +-
 arch/arm/boot/dts/omap4.dtsi                       |    2 +
 arch/arm/boot/dts/omap5-uevm.dts                   |   19 +
 arch/arm/boot/dts/omap5.dtsi                       |    2 +
 arch/arm/configs/omap2plus_defconfig               |   20 +-
 .../fbdev/omap2/displays-new/connector-hdmi.c      |   99 ------
 .../fbdev/omap2/displays-new/encoder-tpd12s015.c   |   56 ---
 drivers/video/fbdev/omap2/dss/Kconfig              |   19 +-
 drivers/video/fbdev/omap2/dss/hdmi.h               |    8 +-
 drivers/video/fbdev/omap2/dss/hdmi4.c              |  216 ++++++++----
 drivers/video/fbdev/omap2/dss/hdmi5.c              |  216 ++++++++----
 drivers/video/fbdev/omap2/dss/hdmi5_core.c         |    2 +-
 drivers/video/fbdev/omap2/dss/hdmi_common.c        |  117 ++++++-
 include/sound/omap-pcm.h                           |   30 ++
 include/video/omapdss.h                            |   31 --
 sound/soc/davinci/davinci-mcasp.c                  |    2 +-
 sound/soc/omap/Kconfig                             |   13 -
 sound/soc/omap/Makefile                            |    4 -
 sound/soc/omap/omap-dmic.c                         |    2 +-
 sound/soc/omap/omap-hdmi-card.c                    |   87 -----
 sound/soc/omap/omap-hdmi.c                         |  364 --------------------
 sound/soc/omap/omap-hdmi.h                         |   38 --
 sound/soc/omap/omap-mcbsp.c                        |    2 +-
 sound/soc/omap/omap-mcpdm.c                        |    2 +-
 sound/soc/omap/omap-pcm.h                          |   30 --
 27 files changed, 540 insertions(+), 870 deletions(-)
 create mode 100644 include/sound/omap-pcm.h
 delete mode 100644 sound/soc/omap/omap-hdmi-card.c
 delete mode 100644 sound/soc/omap/omap-hdmi.c
 delete mode 100644 sound/soc/omap/omap-hdmi.h
 delete mode 100644 sound/soc/omap/omap-pcm.h

-- 
1.7.9.5

