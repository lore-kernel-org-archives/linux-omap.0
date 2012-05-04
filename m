From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH v2 00/14] OMAPDSS: HDMI: Prepare for DSS dev driver audio support and OMAP5
Date: Thu, 3 May 2012 20:43:54 -0500
Message-ID: <1336095848-6923-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37432 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757246Ab2EDBob (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 May 2012 21:44:31 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, mythripk@ti.com
Cc: s-chereau@ti.com, x0055901@ti.com, vaibhav.bedia@ti.com, s-guiriec@ti.com, lrg@ti.com, peter.ujfalusi@ti.com, agraf@suse.de, research@ottomaneng.com, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, Ricardo Neri <ricardo.neri@ti.com>

Hi,

This set of patches is intended to prepare the HDMI driver to implement the DSS
device driver interface for audio proposed here:
  http://www.mail-archive.com/linux-omap@vger.kernel.org/msg67804.html

In preparation for that, it removes the current ASoC HDMI codec driver and
decouples HDMI audio build configuration from ASoC. Instead, a config option
may be selected by the parties interested in the HDMI audio functionality. While
the ASoC HDMI codec is removed, HDMI audio functionality restored in the last
patch of the series in the form of DSS audio support.

Also, this set prepares the HDMI driver for the introduction of the OMAP5 HDMI
audio functionality by further abstracting the portions of code that are
generic to all HDMI implementations (e.g, N/CTS params calculation). Also, an
IP-dependent audio configuration function is introduced as an HDMI IP operation;
this function takes IP-independent parameters and applies them as required by
the IP.

For the specific case of OMAP4, the configuration of the IEC-60958 channel
status word is expanded to provide more flexibility. Also, some duplicated
IEC-60958 definitions are removed to, instead, reuse the definitions provided
by ALSA. Please note that this patches depend on the following patch adding
CEA-861 definitions:
  http://www.spinics.net/lists/linux-omap/msg68246.html.
Without such patch, the patches in this series will not compile.

The changes for OMAP4 configuration expand the current support to cover more
audio sample rates: 32, 44.1, 48, 88.2, 176.4 and 192 kHz. Audio sample world
length of 16 through 24 bits as well as up to 8 audio channels.

These changes are based on the 3.4-rc5 kernel.

Validation was performed using Onkyo TX-SR508 and Yamaha RX-V367 AV receivers.

These are the changes with respect to v1:
*The DSS dev driver audio operations are, at the moment, protected using a
 hardirq-safe spinlock. Except for the audio_start/stop functions, it was
 concluded that a mutex could be used in the future is needed.
*In audio configuration, instead of parsing the IEC-60958 channel status word,
 and setting bits individually, the word is passed directly to the IP. This
 saves code, makes it more readable and fully configurable by the user.
*Split HDMI video_enable, audio_enable and audio_start into two separate
 functions to enable/disable and start/stop. Also, update their return values.
*Audio channels are remapped to match the order preferred by ALSA's speaker-test.
*Remove OMAP4 HDMI IP configuration regarding High Bitrate audio and I2S
 word select polarity, as this is not supported according to updated TI's
 documentation.
*Rename the lock of the HDMI panel.
*Remove unneeded header files.
*Rephrase the description of several patches.

BR,

Ricardo

Axel Castaneda Gonzalez (1):
  OMAPDSS: HDMI: Decouple wrapper enable/disable and audio start/stop

Ricardo Neri (13):
  OMAPDSS: HDMI: Split audio_enable into audio_enable/disable
  OMAPDSS: HDMI: Split video_enable into video_enable/disable
  OMAPDSS: HDMI: Remove ASoC codec
  OMAPDSS: HDMI: OMAP4: Remove CEA-861 audio infoframe and IEC-60958
    enums
  OMAPDSS: HDMI: OMAP4: Remove invalid I2S settings
  OMAPDSS: HDMI: Decouple HDMI audio from ASoC
  OMAPDSS: HDMI: OMAP4: Expand configuration for IEC-60958 audio
  OMAPDSS: HDMI: Relocate N/CTS calculation
  OMAPDSS: HDMI: Add support for more audio sample rates in N/CTS
    calculation
  OMAPDSS: HDMI: Add an audio configuration function
  OMAPDSS: HDMI: OMAP4: Remap speaker order to match ALSA order
  OMAPDSS: HDMI: Panel: Simplify the name of the HDMI mutex
  OMAPDSS: HDMI: Implement DSS driver interface for audio

 drivers/video/omap2/dss/Kconfig           |    4 +
 drivers/video/omap2/dss/dss.h             |    8 +
 drivers/video/omap2/dss/dss_features.c    |    8 +-
 drivers/video/omap2/dss/hdmi.c            |  355 +++++++++++------------------
 drivers/video/omap2/dss/hdmi_panel.c      |  141 ++++++++++--
 drivers/video/omap2/dss/ti_hdmi.h         |   32 ++-
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c |  316 +++++++++++++++++++------
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h |  104 +---------
 8 files changed, 537 insertions(+), 431 deletions(-)

-- 
1.7.5.4

