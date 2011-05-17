From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH 0/2] OMAP4: Add devices for HDMI audio
Date: Mon, 16 May 2011 22:14:37 -0500
Message-ID: <1305602079-3852-1-git-send-email-ricardo.neri@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52636 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751382Ab1EQDQI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 May 2011 23:16:08 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, b-cousson@ti.com, paul@pwsan.com
Cc: Ricardo Neri <ricardo.neri@ti.com>

The addition of two new audio devices is proposed. These two devices are
needed for the ASoC CPU and machine drivers for HDMI audio on
OMAP4.

Implementation of ASoC HDMI audio drivers can be found here:
 http://mailman.alsa-project.org/pipermail/alsa-devel/2011-May/039758.html

Implementation of DSS patches to support HDMI audio can be found here:
 http://www.mail-archive.com/linux-omap@vger.kernel.org/msg49011.html

This implementation is based on on:
* OMAP4: DSS2: Add dss_dss_clk opt clock for OMAP4, by Sumit Semwal
 (http://gitorious.org/linux-omap-dss2/linux/commit/0da5637569bb9bf93e6930cd1c3b452eede50ba2)
* Kernel 2.6.39-rc7
 (git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git v2.6.39-rc7)
 
The complete implementation, with devices, DSS and ASoC parts, is available at:
 git://gitorious.org/omap-audio/linux-audio.git ricardon/topic/hdmi-audio-v2
 
Validation was performed on HDMI TV. Penguins were present on the display
and audio playback was performed with aplay at 32, 44.1 and 48kHz with S16_LE
and S24_LE sample formats. Validation was performed on SDP4430 ES2.1 and ES2.2
and Panda ES2.1 and ES2.0.

Ricardo Neri (2):
  OMAP4: HDMI: Add OMAP device for HDMI audio CPU DAI
  OMAP4: Add device for HDMI OMAP4 audio for ASoC machine driver

 arch/arm/mach-omap2/devices.c |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

