From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 00/14] thermal: ti-soc-thermal: simplify the driver a bit
Date: Mon, 14 May 2018 13:42:07 +0200
Message-ID: <1526298141-14045-1-git-send-email-b.zolnierkie@samsung.com>
References: <CGME20180514114255epcas1p438ea8d32c2b7fd40b86afb25c9c8f2cf@epcas1p4.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Keerthy <j-keerthy@ti.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-omap@vger.kernel.org

Hi,

This patchset contains few fixups and cleanups for TI thermal driver
(this is the result of my attempt to understand the driver operation).

Highlights:
* Fix TALERT IRQ handling for DRA752 SoC.
* Reuse most of OMAP5 SoC code for DRA752 SoC.
* Reduce size of *_adc_to_temp[] conversion tables.
* Remove duplicated code.
* Remove SoC family config options.

The patchset is based on top of:
- "[PATCH v2] thermal: ti-soc-thermal: fix incorrect entry in
  omap5430_adc_to_temp[]" (https://lkml.org/lkml/2018/5/2/433)
- "[PATCH] thermal: ti-soc-thermal: remove dead code"
  (https://lkml.org/lkml/2018/5/2/367)

Please consider applying.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


Bartlomiej Zolnierkiewicz (14):
  thermal: ti-soc-thermal: fix TALERT IRQ handling for DRA752
  thermal: ti-soc-thermal: fix comment in omap5xxx-bandgap.h
  thermal: ti-soc-thermal: fix comments in omap4-thermal-data.c
  thermal: ti-soc-thermal: cleanup COUNTER feature handling for OMAP5
  thermal: ti-soc-thermal: remove redundant methods from struct
    ti_bandgap_data
  thermal: ti-soc-thermal: remove ->threshold_[thot,tcold]_mask fields
  thermal: ti-soc-thermal: remove ->tshut_[hot,cold]_mask fields
  thermal: ti-soc-thermal: use common struct temp_sensor_data for OMAP5
  thermal: ti-soc-thermal: use common struct temp_sensor_data for DRA752
  thermal: ti-soc-thermal: use OMAP5 defines for DRA752
  thermal: ti-soc-thermal: use OMAP5 register tables for DRA752
  thermal: ti-soc-thermal: add ->adc_to_mcelsius method
  thermal: ti-soc-thermal: use short int for *_adc_to_temp[] conversion
    tables
  thermal: ti-soc-thermal: remove SoC family config options

 drivers/thermal/ti-soc-thermal/Kconfig             |  63 +----
 drivers/thermal/ti-soc-thermal/Makefile            |   8 +-
 drivers/thermal/ti-soc-thermal/dra752-bandgap.h    | 109 +------
 .../thermal/ti-soc-thermal/dra752-thermal-data.c   | 313 ++++-----------------
 .../thermal/ti-soc-thermal/omap3-thermal-data.c    |  70 +++--
 .../thermal/ti-soc-thermal/omap4-thermal-data.c    | 132 ++++-----
 drivers/thermal/ti-soc-thermal/omap4xxx-bandgap.h  |   8 -
 .../thermal/ti-soc-thermal/omap5-thermal-data.c    | 171 ++++-------
 drivers/thermal/ti-soc-thermal/omap5xxx-bandgap.h  |  47 +---
 drivers/thermal/ti-soc-thermal/ti-bandgap.c        |  61 ++--
 drivers/thermal/ti-soc-thermal/ti-bandgap.h        |  45 +--
 11 files changed, 265 insertions(+), 762 deletions(-)

-- 
1.9.1
