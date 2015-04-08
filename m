From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 0/2] ARM: dts: am57xx-beagle-x15: Fixes for RTC
Date: Wed, 8 Apr 2015 18:56:25 -0500
Message-ID: <1428537387-18776-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>
Cc: Grygorii Strashko <Grygorii.Strashko@linaro.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

Couple of fixes for MCP79410 RTC on BeagleBoard-X15 platform. This is
not urgent enough for 4.0 material, but will be good to have it on one
of 4.1 rcs. tested on next-20150407:
http://pastebin.ubuntu.com/10777733/
(NOTE: I believe DRA7 rtc still needs reset driver to be done before it can be fully functional).

Grygorii Strashko (1):
  ARM: dts: am57xx-beagle-x15: Fix IRQ type for mcp7941x

Nishanth Menon (1):
  ARM: dts: am57xx-beagle-x15: Fix RTC aliases

 arch/arm/boot/dts/am57xx-beagle-x15.dts |    3 ++-
 arch/arm/boot/dts/dra7.dtsi             |    2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

Regards,
Nishanth Menon
-- 
1.7.9.5
