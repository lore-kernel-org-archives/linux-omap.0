From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 0/3] ARM: OMAP3/4: Correct support for PWM LEDs/backlight
Date: Thu, 3 Jan 2013 12:49:25 +0100
Message-ID: <1357213768-21266-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50002 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753024Ab3ACLte (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Jan 2013 06:49:34 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

Hi,

The pwm-leds driver update is going for 3.9:
https://lkml.org/lkml/2012/12/21/99

This series will make sure that in 3.9 we are going to have working LEDs and
backlight on these boards.

As a note: 4430SDP never had working backlight and the charger led did not
worked for couple of releases already due to wrong pwm_id.

On BeagleBoard we will be able to adjust the brighness of pmu_stat LED instead
of full on/off.

Zoom2 will have working keypad light and the backlight will be moved to be
handled by the generic pwm-backlight driver.

This series will also fix a compile error in board-zoom-display.c caused by the
changes in twl-core - which I missed :(

The DT support for these are going to be sent later.

Tony: can you apply this - if it looks OK - so it will hit linux-next before the
second batch of twl-core update?

Regards,
Peter
---
Peter Ujfalusi (3):
  ARM: OMAP: board-4430sdp: Proper support for TWL6030 PWM LED/Backlight
  ARM: OMAP: omap3beagle: Use the pwm_leds driver to control the PMU_STAT led
  ARM: OMAP: zoom: Use pwm stack for lcd and keyboard backlight

 arch/arm/mach-omap2/board-4430sdp.c          | 31 ++++++++++++++-
 arch/arm/mach-omap2/board-omap3beagle.c      | 39 +++++++++++++++----
 arch/arm/mach-omap2/board-zoom-display.c     | 56 ----------------------------
 arch/arm/mach-omap2/board-zoom-peripherals.c | 53 +++++++++++++++++++++++++-
 4 files changed, 113 insertions(+), 66 deletions(-)

-- 
1.8.0.2

