From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH v3 0/2] pixcir_i2c_ts: Add optional wakeup irq support
Date: Thu, 23 Jul 2015 20:24:04 +0530
Message-ID: <1437663246-16049-1-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>
Cc: Roger Quadros <rogerq@ti.com>, Henrik Rydberg <rydberg@bitmath.org>, Frodo Lai <frodo.lai@gmail.com>, Jingoo Han <jg1.han@samsung.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Vignesh R <vigneshr@ti.com>
List-Id: linux-omap@vger.kernel.org



This is the v3 of the patch series to add optional wake irq support for
pixcir_i2c_tsc.

Tested on am437x-gp-evm, with some out of tree patches to support
suspend/resume on am437x.


Vignesh R (2):
  input: touchscreen: pixcir_i2c_ts: Add support for optional wakeup
    interrupt
  ARM: dts: am437x-gp-evm: Add wakeup interrupt source for
    pixcir_i2c_tsc

 arch/arm/boot/dts/am437x-gp-evm.dts       |  4 ++++
 drivers/input/touchscreen/pixcir_i2c_ts.c | 22 ++++++++++++++++++----
 include/linux/input/pixcir_ts.h           |  1 +
 3 files changed, 23 insertions(+), 4 deletions(-)

-- 
2.4.5
