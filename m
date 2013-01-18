From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 0/8] ARM: OMAP: Audio support via omap-twl4030 and pwm support
Date: Fri, 18 Jan 2013 15:31:48 +0100
Message-ID: <1358519516-13165-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58043 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756108Ab3AROcD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 Jan 2013 09:32:03 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

I have combined the two previous series for easier handling.

audio via omap-twl4030 for Zoom2 and sdp3430:
http://lists.infradead.org/pipermail/linux-arm-kernel/2012-December/139128.html

PWM support for few boards:
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-January/139409.html

>From the PWM series I have left out the zoom patch since it is going to conflict
with a patch going via MFD. I'll send that later.

Notes for the audio part:
omap-twl4030 ASoC machine driver can support more boards with the following
series:
http://mailman.alsa-project.org/pipermail/alsa-devel/2012-December/058119.html

Rework the omap-twl4030 audio support code in arch/arm/mach-omap2/ to take
advantages of this. The same machine driver can support the zoom2 and sdp3430
boards as well.

Notes for the PWM part:
This series will make sure that in 3.9 we are going to have working LEDs and
backlight on these boards.

As a note: 4430SDP never had working backlight and the charger led did not
worked for couple of releases already due to wrong pwm_id.

On BeagleBoard we will be able to adjust the brighness of pmu_stat LED instead
of full on/off.

Regards,
Peter
---
Peter Ujfalusi (8):
  ARM: OMAP: 3430sdp: Enable extmute functionality for audio
  ARM: OMAP: zoom: Zoom2 does not have extmute functionality
  ARM: OMAP2+: twl-common: Add default twl4030 audio configuration
  ARM: OMAP2+: twl-common: Allow boards to customize the twl4030 audio setup
  ARM: OMAP: zoom: Audio support via the common omap-twl4030 machine driver
  ARM: OMAP: sdp3430: Audio support via the common omap-twl4030 machine driver
  ARM: OMAP: board-4430sdp: Proper support for TWL6030 PWM LED/Backlight
  ARM: OMAP: omap3beagle: Use the pwm_leds driver to control the PMU_STAT led

 arch/arm/mach-omap2/board-3430sdp.c          | 20 ++++++++++++++
 arch/arm/mach-omap2/board-4430sdp.c          | 30 +++++++++++++++++++-
 arch/arm/mach-omap2/board-cm-t35.c           |  2 +-
 arch/arm/mach-omap2/board-devkit8000.c       |  2 +-
 arch/arm/mach-omap2/board-igep0020.c         |  2 +-
 arch/arm/mach-omap2/board-omap3beagle.c      | 41 ++++++++++++++++++++++------
 arch/arm/mach-omap2/board-omap3evm.c         |  2 +-
 arch/arm/mach-omap2/board-overo.c            |  2 +-
 arch/arm/mach-omap2/board-zoom-peripherals.c | 29 ++++++++++++++------
 arch/arm/mach-omap2/twl-common.c             | 17 ++++++++----
 arch/arm/mach-omap2/twl-common.h             |  3 +-
 11 files changed, 120 insertions(+), 30 deletions(-)

-- 
1.8.1

