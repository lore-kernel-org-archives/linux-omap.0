From: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 0/4]  tps65917: Drivers for TPS65917 PMIC
Date: Tue, 20 May 2014 14:41:35 +0530
Message-ID: <1400577099-8743-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, ian-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The TPS65917 chip is a power management IC for Portable Navigation Systems
and Tablet Computing devices. It contains the following components:

 - Regulators.
 - GPADC.
 - Over Temperature warning and Shut down.

This patch series adds support for TPS65917 mfd device. At this time only
the regulator functionality is made available.

The closest drivers are PALMAS series drivers.
The register set is changed. Bit-field defenitions are changed.
Hence based on the PALMAS drivers and created a new set of drivers
with code changes as required.

The patches are boot tested on DRA72-EVM.

Keerthy (4):
  MFD: DT bindings for the TPS65917 family MFD
  Regulators: Add TPS65917 Bindings
  mfd: tps65917: Add driver for the TPS65917 PMIC
  regulator: tps65917: Add Regulator driver for TPS65917 PMIC

 Documentation/devicetree/bindings/mfd/tps65917.txt |   35 +
 .../bindings/regulator/tps65917-pmic.txt           |   67 +
 drivers/mfd/Kconfig                                |   12 +
 drivers/mfd/Makefile                               |    1 +
 drivers/mfd/tps65917.c                             |  573 ++++++++
 drivers/regulator/Kconfig                          |   12 +
 drivers/regulator/Makefile                         |    1 +
 drivers/regulator/tps65917-regulator.c             |  810 +++++++++++
 include/linux/mfd/tps65917.h                       | 1509 ++++++++++++++++++++
 9 files changed, 3020 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/tps65917.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/tps65917-pmic.txt
 create mode 100644 drivers/mfd/tps65917.c
 create mode 100644 drivers/regulator/tps65917-regulator.c
 create mode 100644 include/linux/mfd/tps65917.h

-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
