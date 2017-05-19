From: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/3] mfd: lp87565: Add lp87565 PMIC support
Date: Fri, 19 May 2017 18:12:16 +0530
Message-ID: <1495197739-17446-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: j-keerthy-l0cyMroinI0@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

The LP87565 chip is a power management IC for Portable Navigation Systems
    and Tablet Computing devices. It contains the following components:

     - Regulators.
     - Configurable General Purpose Output Signals(GPO).

PMIC interacts with the main processor through i2c. PMIC has
a bunch of regulatos (Step-Down DC-DC Converter Cores)
that can be programmed to be single phase or multi phase
regulators. PMIC also has a couple of GPOs(General Purpose Output
Signals).

The register sets and the individual bit fields of registers were
compared against lp87* PMICs. None were matching even close. Hence
came up with new drivers and is based on lp873x drivers.

Keerthy (3):
  mfd: lp87565: Add lp87565 PMIC support
  regulator: lp87565: Add support for lp87565 PMIC regulators
  regulator: tps65917: Add support for SMPS12

 Documentation/devicetree/bindings/mfd/lp87565.txt |  44 ++++
 drivers/mfd/Kconfig                               |  14 ++
 drivers/mfd/Makefile                              |   1 +
 drivers/mfd/lp87565.c                             | 103 ++++++++
 drivers/regulator/Kconfig                         |   8 +
 drivers/regulator/Makefile                        |   1 +
 drivers/regulator/lp87565-regulator.c             | 244 +++++++++++++++++++
 drivers/regulator/palmas-regulator.c              |  18 +-
 include/linux/mfd/lp87565.h                       | 275 ++++++++++++++++++++++
 include/linux/mfd/palmas.h                        |   2 +
 10 files changed, 707 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/lp87565.txt
 create mode 100644 drivers/mfd/lp87565.c
 create mode 100644 drivers/regulator/lp87565-regulator.c
 create mode 100644 include/linux/mfd/lp87565.h

-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
