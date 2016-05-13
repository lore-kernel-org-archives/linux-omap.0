From: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v3 0/2] mfd: lp873x: Add lp873x PMIC support
Date: Fri, 13 May 2016 09:18:08 +0530
Message-ID: <1463111290-12377-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, j-keerthy-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

The LP873X chip is a power management IC for Portable Navigation Systems
    and Tablet Computing devices. It contains the following components:

     - Regulators.
     - Configurable General Purpose Output Signals(GPO).

PMIC interacts with the main processor through i2c. PMIC has
couple of LDOs(Linear Regulators), couple of BUCKs (Step-Down DC-DC
Converter Cores) and GPOs(General Purpose Output Signals). At this
time only the regulator functionality is made available.

The regulator patch is already queued:
http://marc.info/?l=linux-kernel&m=146298767110771&w=2

Hence posting the remaining patches of the series with
the comments fixed on mfd driver. 

Keerthy (2):
  Documentation: mfd: LP873X: Add information for the mfd and regulator
    drivers
  mfd: lp873x: Add lp873x PMIC support

 Documentation/devicetree/bindings/mfd/lp873x.txt |  55 +++++
 drivers/mfd/Kconfig                              |  14 ++
 drivers/mfd/Makefile                             |   2 +
 drivers/mfd/lp873x.c                             |  96 +++++++++
 include/linux/mfd/lp873x.h                       | 264 +++++++++++++++++++++++
 5 files changed, 431 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/lp873x.txt
 create mode 100644 drivers/mfd/lp873x.c
 create mode 100644 include/linux/mfd/lp873x.h

-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
