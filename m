From: Ladislav Michl <ladis@linux-mips.org>
Subject: [PATCH 0/3] omap: dmtimer: Fix and cleanup moved driver
Date: Wed, 17 Jan 2018 22:46:29 +0100
Message-ID: <20180117214629.GA11952@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-pwm@vger.kernel.org
Cc: Keerthy <j-keerthy@ti.com>, daniel.lezcano@linaro.org, thierry.reding@gmail.com, tony@atomide.com, aaro.koskinen@iki.fi, Claudiu.Beznea@microchip.com, narmstrong@baylibre.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, sebastian.reichel@collabora.co.uk, robh+dt@kernel.org, t-kristo@ti.com, grygorii.strashko@ti.com
List-Id: linux-omap@vger.kernel.org

This series is build on top od Keerthy's 'omap: dmtimer: Move driver
out of plat-omap' v7.

Ladislav Michl (3):
  clocksource: timer-dm: Check prescaler value
  pwm: pwm-omap-dmtimer: Fix frequency when using prescaler
  clocksource: timer-dm: Make unexported functions static

 drivers/clocksource/timer-dm.c |  222 ++++++++++++++++++++---------------------
 drivers/pwm/pwm-omap-dmtimer.c |   92 +++++++++-------
 include/clocksource/dmtimer.h  |   24 ----
 3 files changed, 164 insertions(+), 174 deletions(-)
