From: Neil Armstrong <narmstrong@baylibre.com>
Subject: [RFC PATCH 0/4] Fix dmtimer parent clock setup
Date: Mon, 16 Jul 2018 22:38:58 +0200
Message-ID: <1531773542-15736-1-git-send-email-narmstrong@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, daniel.lezcano@linaro.org
Cc: Neil Armstrong <narmstrong@baylibre.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, aford173@gmail.com, drivshin@awxrd.com
List-Id: linux-omap@vger.kernel.org

With the move to clocksource, the omap_dm_timer_of_set_source() broke
because the "fclk" clock is now defined in the DT.
The omap_dm_timer_of_set_source() was using the first clock declared in the
timer node, but now this clock must be named as "src" and clk_get() use
"src" as clock name to permit specifiying the parent clock of the timer "fclk".

The 3 first patches adds the "fck" clocks to all timer nodes of SoCs using
the Clock Framework to pass this clock to the dmtimer driver.

Adam, David, can you check if this solves the issue reported at [1] ?

[1] https://www.spinics.net/lists/linux-clk/msg27638.html

Neil Armstrong (4):
  ARM: dts: am33xx: Add all fck timer clocks
  ARM: dts: am4372: Add all fck timer clocks
  ARM: dts: dm816x: Add all fck timer clocks
  timer-ti-dm: Fix omap_dm_timer_of_set_source()

 arch/arm/boot/dts/am33xx.dtsi     | 10 ++++++++++
 arch/arm/boot/dts/am4372.dtsi     | 18 ++++++++++++++++++
 arch/arm/boot/dts/dm816x.dtsi     | 10 ++++++++++
 drivers/clocksource/timer-ti-dm.c |  2 +-
 4 files changed, 39 insertions(+), 1 deletion(-)

-- 
2.7.4
