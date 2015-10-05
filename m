From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v2 0/3] Add Palmas iio gpadc
Date: Mon,  5 Oct 2015 08:14:51 +0200
Message-ID: <cover.1444025625.git.hns@goldelico.com>
References: <86F849CB-1A50-4BEB-99C6-79FF97971DCB@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <86F849CB-1A50-4BEB-99C6-79FF97971DCB@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Marek Belisko <marek@goldelico.com>, Pradeep Goudagunta <pgoudagunta@nvidia.com>, "H. Nikolaus Schaller" <hns@goldelico.com>, Laxman Dewangan <ldewangan@nvidia.com>, gg@slimlogic.co.uk, jic23@jic23.retrosnub.co.uk
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-iio@vger.kernel.org, Grazvydas Ignotas <notasas@gmail.com>
List-Id: linux-omap@vger.kernel.org

V2 changes:
- worked in review comments by Peter Meerwald
- made channels 1 and 3 report (raw) temperature values
- moved PALMAS_GPADC_TRIMINVALID to driver core
- worked in review comments by Jonathan Cameron
- iio_map removed

Add iio driver for the TI Palmas (twl6035, 6037) including device tree bindings.
It enables the gpadc for the OMAP5 uevm.

This patch series is based on original code taken from Android Tegra kernels:
(https://android.googlesource.com/kernel/tegra/+/aaabb2e045f31e5a970109ffdaae900dd403d17e/drivers/staging/iio/adc)

Tegra code was developed by:
Pradeep Goudagunta <pgoudagunta@nvidia.com>
Laxman Dewangan <ldewangan@nvidia.com>

Edited and extended for mainline by:
H. Nikolaus Schaller <hns@goldelico.com>
Marek Belisko <marek@goldelico.com>


H. Nikolaus Schaller (2):
  iio:adc: add iio driver for Palmas (twl6035/7) gpadc
  ARM: dts: omap5-uevm: enable iio gpadc for Palmas

Marek Belisko (1):
  iio:adc:palmas: add DT support

 .../devicetree/bindings/iio/adc/palmas-gpadc.txt   |  46 ++
 arch/arm/boot/dts/omap5-uevm.dts                   |   9 +
 drivers/iio/adc/Kconfig                            |   9 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/palmas_gpadc.c                     | 860 +++++++++++++++++++++
 include/linux/mfd/palmas.h                         |  75 +-
 6 files changed, 976 insertions(+), 24 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/palmas-gpadc.txt
 create mode 100644 drivers/iio/adc/palmas_gpadc.c

-- 
2.5.1
