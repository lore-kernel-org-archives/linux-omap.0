From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH 0/3] ARM: OMAP: Add platform devices for ASoC HDMI drivers
Date: Tue, 17 Apr 2012 19:40:43 -0500
Message-ID: <1334709646-8468-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40554 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751903Ab2DRAk6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Apr 2012 20:40:58 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, broonie@opensource.wolfsonmicro.com, lrg@ti.com
Cc: s-guiriec@ti.com, peter.ujfalusi@ti.com, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, Ricardo Neri <ricardo.neri@ti.com>

This set of patches is intended to add the platform devices for the ASoC
HDMI drivers when not using device tree. For this, I took an approach similar
to DMIC and McPDM by creating a dedicated functions to create the devices.

I included the device for the CPU DAI driver, omap-hdmi-audio-dai, and the
device for the machine driver, omap-hdmi-audio, in devices.c to reflect the
fact that any OMAP4 (and OMAP5 in the future) has HDMI IP. I put the device
for the codec in the board file to reflect the fact that not necessarily all
the boards with OMAP4/5 have the HDMI output wired.

Best regards

Ricardo

Ricardo Neri (3):
  ARM: OMAP: devices: Register platform devices for HDMI audio
  ARM: OMAP4: board-4430sdp: Register platform device for HDMI audio
    codec
  ARM: OMAP4: board-omap4panda: Register platform device for HDMI audio
    codec

 arch/arm/mach-omap2/board-4430sdp.c    |    6 ++++++
 arch/arm/mach-omap2/board-omap4panda.c |    6 ++++++
 arch/arm/mach-omap2/devices.c          |   31 +++++++++++++++++++++++++++++++
 3 files changed, 43 insertions(+), 0 deletions(-)

-- 
1.7.5.4

