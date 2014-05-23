From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH 00/13] Fix OMAP4+ HDMI audio
Date: Fri, 23 May 2014 22:07:49 +0300
Message-ID: <cover.1400871999.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46895 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751056AbaEWTIV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 May 2014 15:08:21 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, bcousson@baylibre.com, tomi.valkeinen@ti.com, detheridge@ti.com, Jyri Sarha <jsarha@ti.com>

This patch set fixes the resource sharing problems between
omap-hdmi-dai driver and OMAPDSS HDMI driver. It does it by
registering the OMAP HDMI audio related ASoC drivers from OMAPDSS HDMI
driver. Platform data structs have been added for omap-hdmi-dai and
omap-hdmi-card drivers to pass the information and resources from
OMAPDSS HDMI driver.

The idea of this patch set is to fix HDMI audio for the next release
after it got broken by OMAPDSS DT changes. It does not mean that I
have abandoned the patch set that integrates the omap-hdmi-dai driver
into OMAPDSS HDMI driver. The OMAPDSS side of those patches just had
some dependencies to the recent ASoC side patches that would have
caused problems in the next merge. I'll mail a revised and rebased
version of those patches soon.

Best regards,
Jyri

Jyri Sarha (13):
  ARM: omap4.dtsi: Add audio related parametes to hdmi node
  ARM: omap5.dtsi: Add audio related parameters to hdmi node
  ARM: OMAP2+: Remove non working OMAP HDMI audio initialization
  OMAPDSS: hdmi_wp: Add function for getting hdmi_wp physical base
    address
  OMAPDSS: hdmi_audio: Add hdmi_audio.c for registering HDMI audio
    support
  ASoC: omap-hdmi-dai: Add platform data struct for omap-hdmi-dai
    driver
  ASoC: omap-hdmi-card: Add platform data stuct for omap-hdmi-card
    driver
  ASoC: omap-hdmi: Changes for registeing the driver from OMAPDSS
  ASoC: omap-hdmi-card: Changes for registeing the driver from OMAPDSS
  OMAPDSS: hdmi4: Register HDMI audio ASoC drivers from HDMI driver
  OMAPDSS: hdmi.h: Add HDMI_AUDIO_LAYOUT_6CH enum value
  OMAPDSS: hdmi5: Register HDMI audio ASoC drivers from HDMI driver
  ASoC: omap: Add Kconfig option for OMAP5 HDMI audio

 arch/arm/boot/dts/omap4.dtsi               |    2 +
 arch/arm/boot/dts/omap5.dtsi               |    2 +
 arch/arm/mach-omap2/devices.c              |   28 ---------
 drivers/video/fbdev/omap2/dss/Makefile     |    2 +-
 drivers/video/fbdev/omap2/dss/hdmi.h       |   17 ++++-
 drivers/video/fbdev/omap2/dss/hdmi4.c      |   15 +++++
 drivers/video/fbdev/omap2/dss/hdmi5.c      |   15 +++++
 drivers/video/fbdev/omap2/dss/hdmi_audio.c |   92 ++++++++++++++++++++++++++++
 drivers/video/fbdev/omap2/dss/hdmi_wp.c    |    6 ++
 include/sound/omap-hdmi-card-pdata.h       |   28 +++++++++
 include/sound/omap-hdmi-dai-pdata.h        |   31 ++++++++++
 sound/soc/omap/Kconfig                     |   13 +++-
 sound/soc/omap/omap-hdmi-card.c            |   20 ++++--
 sound/soc/omap/omap-hdmi.c                 |   65 +++++---------------
 14 files changed, 253 insertions(+), 83 deletions(-)
 create mode 100644 drivers/video/fbdev/omap2/dss/hdmi_audio.c
 create mode 100644 include/sound/omap-hdmi-card-pdata.h
 create mode 100644 include/sound/omap-hdmi-dai-pdata.h

-- 
1.7.9.5

