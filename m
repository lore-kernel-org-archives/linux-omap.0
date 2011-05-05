From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH 0/5] OMAP4: DSS2: HDMI: Add support for audio
Date: Thu,  5 May 2011 02:01:29 -0500
Message-ID: <1304578894-23967-1-git-send-email-ricardo.neri@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39628 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751384Ab1EEHB0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 May 2011 03:01:26 -0400
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p4571P0j001233
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 5 May 2011 02:01:25 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tomi.valkeinen@ti.com, mythripk@ti.com
Cc: Ricardo Neri <ricardo.neri@ti.com>

This is to add support for HDMI audio on OMAP4 chips. This work has two
parts: DSS implementation and ASoC implementation. This set of patches
presents the DSS implementation. The approach is to utilize the DSS
HDMI driver to act as an ASoC codec. Then, functionality and data
structures are added to the DSS HDMI driver to configure parameters
relevant to audio such as sample rate and frequency and DMA.
The ASoC implementation adds an HDMI audio card that will utilize this
HDMI ASoC codec. The ASoC implementation is also under review in the
alsa-devel list.

This implementation is for Basic Audio as defined in CEA-861-D: 16 bit/sample
linear PCM 2-channel audio with sample rates of 32, 44.1 and 48kHz. As
described in the HDMI specification, support for Basic Audio is mandatory
for HDMI sinks and does not require of EDID parsing.

Additionally, this implementation supports 24-bit samples in 32-bit words.
Further audio capabilities such as more sample rates and multichannel audio
will be added in the future when EDID parsing is available for HDMI driver.

This implementation is based on on:
* OMAP4: DSS2: Add dss_dss_clk opt clock for OMAP4, by Sumit Semwal
 (http://gitorious.org/linux-omap-dss2/linux/commit/0da5637569bb9bf93e6930cd1c3b452eede50ba2)
* Kernel 2.6.39-rc6
 (git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git v2.6.39-rc6)

In order to validate functionality, it is necessary to utilize the ASoC
HDMI CPU and machine drivers for HDMI on OMAP4. The complete implementation,
DSS and ASoC parts, is available at:
 git://gitorious.org/omap-audio/linux-audio.git ricardon/topic/hdmi-audio-v1

Verification: Penguins on HDMI display with audio playback with sample
rates of 32, 44.1 and 48kHz and 16-bit and 24-bit (in 32-bit word) sample
format. Audio playback verified using ALSA aplay. Validation was performed on
SDP4430 ES2.1 and Panda ES2.1 and ES2.0.

Ricardo Neri (5):
  OMAP4: DSS2: Create a DSS features structure for OMAP4430 ES1.0
  OMAP4: DSS2: HDMI: Add DSS feature for CTS calculation
  OMAP4: DSS2: HDMI: Add enums and structures for audio
  OMAP4: DSS2: HDMI: Add functionality for audio configuration
  OMAP4: DSS2: HDMI: Implement ASoC Codec driver for HDMI audio

 drivers/video/omap2/dss/dss_features.c |   29 ++-
 drivers/video/omap2/dss/dss_features.h |    1 +
 drivers/video/omap2/dss/hdmi.c         |  432 ++++++++++++++++++++++++++++++++
 drivers/video/omap2/dss/hdmi.h         |  220 ++++++++++++++++-
 4 files changed, 678 insertions(+), 4 deletions(-)

