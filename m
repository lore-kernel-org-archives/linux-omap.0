From: Dmitry Lifshitz <lifshitz@compulab.co.il>
Subject: [PATCH 0/9] ARM: dts: sbc-t3x: add more features support
Date: Tue, 18 Nov 2014 11:13:15 +0200
Message-ID: <1416302004-22199-1-git-send-email-lifshitz@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:50593 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753883AbaKRJNt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 18 Nov 2014 04:13:49 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Dmitry Lifshitz <lifshitz@compulab.co.il>

Add support for more SBC-T3x single board computers features:

* CM-T3x CoM and SB-T35 baseboard EEPROMs
* TV out
* Touchscreen
* CM-T3x30 audio
* CM-T3x30 keypad

Dmitry Lifshitz (9):
  ARM: dts: cm-t3x: cleanup comments indentation
  ARM: dts: cm-t3x: add ADS7846 touchscreen support
  ARM: OMAP2+: remove cm-t3x touchscreen pdata quirk
  ARM: dts: cm-t3x: add EEPROM support
  ARM: dts: sb-t35: add EEPROM support
  ARM: dts: cm-t3x: add TV out support
  ARM: dts: sbc-t3x: add TV out display alias
  ARM: dts: sbc-t3x30: add audio support
  ARM: dts: cm-t3x30: add keypad support

 arch/arm/boot/dts/omap3-cm-t3x.dtsi   |  119 +++++++++++++++++++++++++++++++--
 arch/arm/boot/dts/omap3-cm-t3x30.dtsi |   31 +++++++++
 arch/arm/boot/dts/omap3-sb-t35.dtsi   |   36 ++++++++++
 arch/arm/boot/dts/omap3-sbc-t3517.dts |    1 +
 arch/arm/boot/dts/omap3-sbc-t3530.dts |    1 +
 arch/arm/boot/dts/omap3-sbc-t3730.dts |    1 +
 arch/arm/mach-omap2/pdata-quirks.c    |    3 -
 7 files changed, 183 insertions(+), 9 deletions(-)

-- 
1.7.5.4

