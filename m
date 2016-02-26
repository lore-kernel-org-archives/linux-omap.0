From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH 0/7] mfd: Drop IRQF_EARLY_RESUME flag
Date: Fri, 26 Feb 2016 17:42:50 +0200
Message-ID: <1456501377-16871-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Alessandro Zummo <a.zummo@towertech.it>, MyungJoo Ham <myungjoo.ham@samsung.com>, Lars-Peter Clausen <lars@metafoo.de>
Cc: rtc-linux@googlegroups.com, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com, linux-omap@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Chanwoo Choi <cw00.choi@samsung.com>, Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald <pmeerw@pmeerw.net>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, Laxman Dewangan <ldewangan@nvidia.com>
List-Id: linux-omap@vger.kernel.org

The IRQF_EARLY_RESUME flag is not required for nested irqs anymore,
since commit 3c646f2c6aa9 ("genirq: Don't suspend nested_thread irqs
over system suspend") was merged.
Hence, this flag can be dropped for MFD cell's devices where MFD interrupt
controller defines nested IRQs as nested threaded IRQs.

Cc: Lee Jones <lee.jones@linaro.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: Laxman Dewangan <ldewangan@nvidia.com>

Grygorii Strashko (7):
  extcon: palmas: Drop IRQF_EARLY_RESUME flag
  rtc: palmas: Drop IRQF_EARLY_RESUME flag
  rtc: tps6586x: Drop IRQF_EARLY_RESUME flag
  rtc: tps65910: Drop IRQF_EARLY_RESUME flag
  rtc: tps80031: Drop IRQF_EARLY_RESUME flag
  rtc: as3722: Drop IRQF_EARLY_RESUME flag
  iio: adc: palmas: Drop IRQF_EARLY_RESUME flag

 drivers/extcon/extcon-palmas.c | 4 ++--
 drivers/iio/adc/palmas_gpadc.c | 6 +++---
 drivers/rtc/rtc-as3722.c       | 2 +-
 drivers/rtc/rtc-palmas.c       | 3 +--
 drivers/rtc/rtc-tps6586x.c     | 2 +-
 drivers/rtc/rtc-tps65910.c     | 2 +-
 drivers/rtc/rtc-tps80031.c     | 2 +-
 7 files changed, 10 insertions(+), 11 deletions(-)

-- 
2.7.2
