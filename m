From: Ladislav Michl <ladis@linux-mips.org>
Subject: [PATCH 0/5] Add capture functionality to OMAP pwm driver
Date: Mon, 8 Jan 2018 16:39:26 +0100
Message-ID: <20180108153926.GA3916@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-pwm-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>, tony@atomide.com, aaro.koskinen@iki.fi, thierry.reding@gmail.com, daniel.lezcano@linaro.org
Cc: grygorii.strashko@ti.com, linux-omap@vger.kernel.org, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, sebastian.reichel@collabora.co.uk, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org

Folowing patchset is based on Keerthy's "v6 omap: dmtimer: Move driver
out of plat-omap" minus last patch which is here corrected.

Keerthy, feel free to pick cleanup/bugfix patches into your serie
if you find it usefull.

Tony, I wanted to do something easy to understand as a base for
event capture interrupt, but either I do not understand hardware,
or it indeed cannot do pulse capture.

Please see comments in the last patch in the serie.

Ladislav Michl (5):
  clocksource: timer-dm: Make unexported functions static
  clocksource: timer-dm: Check prescaler value
  pwm: pwm-omap-dmtimer: Fix frequency when using prescaler
  clocksource: timer-dm: Add event capture
  pwm: pwm-omap-dmtimer: Add capture functionality

 drivers/clocksource/timer-dm.c             | 269 +++++++++++++++++------------
 drivers/pwm/pwm-omap-dmtimer.c             | 200 +++++++++++++++++----
 include/clocksource/dmtimer.h              |  24 ---
 include/linux/platform_data/dmtimer-omap.h |   8 +
 4 files changed, 334 insertions(+), 167 deletions(-)

-- 
2.15.1
