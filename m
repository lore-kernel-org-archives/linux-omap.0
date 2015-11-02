From: Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 0/3] pwm: omap: Add PWM support using dual-mode timers
Date: Mon, 2 Nov 2015 12:14:08 +0100
Message-ID: <56374580.2070704@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Sender: linux-pwm-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Grant Erickson <marathon96@gmail.com>, NeilBrown <neilb@suse.de>, Joachim Eastwood <manabian@gmail.com>
List-Id: linux-omap@vger.kernel.org

This patch is based on an earlier patch by NeilBrown which is based on
a older patch from Grant Erickson which provided PWM devices using
the 'legacy' interface.

The pwm driver was renamed to not be confused with the OMAP4 PWM dedicated
hardware and was cleaned with the review from Thierry Reding.

The first patch introduces a way to select to dmtimer clock source via a
clocks binding and a dedicated function wit the legacy fallback.

In order to prepare for the future form of the dmtimer (clksource or whatever),
and less rely on specific bindings the first patch introduces the PWM driver
with all the dmtimer calls into a platform data structure.

The structure is then filled in plat-omap and added as auxdata for the
ti,pwm-dmtimer-omap compatible nodes.

Suggested-by: Tony Lindgren <tony@atomide.com>

RFC Thread : http://lkml.kernel.org/r/562505DB.3010402@baylibre.com

Neil Armstrong (3):
  arm: plat-omap: dmtimer: Add clock source from DT
  pwm: Add PWM driver for OMAP using dual-mode timers
  arm: plat-omap: Add PWM dmtimer platform data quirks

 .../devicetree/bindings/pwm/pwm-omap-dmtimer.txt   |  18 ++
 arch/arm/mach-omap2/pdata-quirks.c                 |  23 ++
 arch/arm/plat-omap/dmtimer.c                       |  31 +-
 drivers/pwm/Kconfig                                |   9 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-omap-dmtimer.c                     | 322 +++++++++++++++++++++
 include/linux/platform_data/pwm_omap_dmtimer.h     |  69 +++++
 7 files changed, 472 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-omap-dmtimer.txt
 create mode 100644 drivers/pwm/pwm-omap-dmtimer.c
 create mode 100644 include/linux/platform_data/pwm_omap_dmtimer.h

-- 
1.9.1
