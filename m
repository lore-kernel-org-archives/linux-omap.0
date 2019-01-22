From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/3] pwm-omap-dmtimer regression fixes
Date: Tue, 22 Jan 2019 09:57:14 -0800
Message-ID: <20190122175717.13428-1-tony@atomide.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Andy Shevchenko <andy.shevchenko@gmail.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, "H. Nikolaus Schaller" <hns@goldelico.com>, Keerthy <j-keerthy@ti.com>, Ladislav Michl <ladis@linux-mips.org>, Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>, Tero Kristo <t-kristo@ti.com>, Thierry Reding <thierry.reding@gmail.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-omap@vger.kernel.org

Hi all,

The Pyra handheld PWM LCD regression in v5.0-rc1 reported by Nikolaus
goes back to v4.19 for pwm-omap-dmtimer. Here are patches against v4.19
to fix the issue that also makes pwm-vibra working again for droid 4.

Regards,

Tony


Tony Lindgren (3):
  clocksource: timer-ti-dm: Fix pwm dmtimer usage of fck reparenting
  bus: ti-sysc: Fix timer handling with drop pm_runtime_irq_safe()
  ARM: dts: Configure clock parent for pwm vibra

 arch/arm/boot/dts/omap4-droid4-xt894.dts | 11 +++++++++++
 drivers/bus/ti-sysc.c                    |  4 ++--
 drivers/clocksource/timer-ti-dm.c        |  5 ++++-
 3 files changed, 17 insertions(+), 3 deletions(-)

-- 
2.20.1
