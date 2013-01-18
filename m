From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 0/5] ARM: dts: OMAP3+: PWM support for TWL and selected boards
Date: Fri, 18 Jan 2013 15:36:29 +0100
Message-ID: <1358519794-13214-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58269 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751595Ab3AROgl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 Jan 2013 09:36:41 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

Hi,

Add the needed DT sections for twl4030 and twl6030 for the PWM childs.
Update the omap4-sdp to have working backlight and keypad/charging LED support.
Use the pwm-leds driver on BeagleBoard for the pmu_stat LED instead of the hacky
twl403-gpio mapped PWM.

Regards,
Peter
---
Peter Ujfalusi (5):
  ARM: dts: twl4030: Add PWM support
  ARM: dts: twl6030: Add PWM support
  ARM: dts: omap3-beagle-xm: Use pwm-leds for pmu_stat LED
  ARM: dts: omap4-sdp: Add support for pwm-leds (keypad and charging LED)
  ARM: dts: omap4-sdp: Add support for pwm-backlight

 arch/arm/boot/dts/omap3-beagle-xm.dts | 14 ++++++++++----
 arch/arm/boot/dts/omap4-sdp.dts       | 26 ++++++++++++++++++++++++++
 arch/arm/boot/dts/twl4030.dtsi        | 10 ++++++++++
 arch/arm/boot/dts/twl6030.dtsi        | 12 ++++++++++++
 4 files changed, 58 insertions(+), 4 deletions(-)

-- 
1.8.1

