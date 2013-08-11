From: Sebastian Reichel <sre@debian.org>
Subject: [RFC PATCH 0/3] OMAP SSI driver
Date: Sun, 11 Aug 2013 18:13:45 +0200
Message-ID: <1376237628-1077-1-git-send-email-sre@debian.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ring0.de ([91.143.88.219]:44532 "EHLO smtp.ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754132Ab3HKQPd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 11 Aug 2013 12:15:33 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Sebastian Reichel <sre@debian.org>, linux-omap@vger.kernel.org, linus.walleij@linaro.org, Kevin Hilman <khilman@deeprootsystems.com>, Shubhrajyoti Datta <omaplinuxkernel@gmail.com>, Carlos Chinea <cch.devel@gmail.com>

Hi !

This patchset adds an OMAP SSI driver to the HSI framework.

After leaving Nokia Carlos Chinea had no more time to work on this patchset;
Thus I tried updating the driver to fix the mentioned issues.

I applied the following changes to the last patch from Carlos:

 * convert driver to use hwmod and add SSI information to hwmod database
 * convert driver to use runtime_pm
 * change platform data, so that it forwards the wake_gpio to avoid irq_to_gpio
 * move the ssi.h and rename to hsi-omap-ssi.h (multiplatform support)

The code compiles and is initialized on the RX51. I also verified, that it
does not break the boot on my Pandaboard.

The driver has been written by Carlos Chinea and has already been sent for
public review as part of the HSI framework RFC before:

 https://lkml.org/lkml/2011/6/10/280

-- Sebastian

Sebastian Reichel (3):
  ARM: OMAP2+: hwmod-data: Add SSI information
  ARM: OMAP2+: HSI: Introduce OMAP SSI driver
  ARM: OMAP2+: Add SSI driver configuration

 arch/arm/mach-omap2/Makefile                 |    4 +
 arch/arm/mach-omap2/board-rx51-peripherals.c |   10 +-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c   |  104 ++
 arch/arm/mach-omap2/ssi.c                    |   82 ++
 drivers/hsi/Kconfig                          |    1 +
 drivers/hsi/Makefile                         |    1 +
 drivers/hsi/controllers/Kconfig              |   23 +
 drivers/hsi/controllers/Makefile             |    5 +
 drivers/hsi/controllers/omap_ssi.c           | 1879 ++++++++++++++++++++++++++
 include/linux/platform_data/hsi-omap-ssi.h   |  202 +++
 10 files changed, 2310 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/mach-omap2/ssi.c
 create mode 100644 drivers/hsi/controllers/Kconfig
 create mode 100644 drivers/hsi/controllers/Makefile
 create mode 100644 drivers/hsi/controllers/omap_ssi.c
 create mode 100644 include/linux/platform_data/hsi-omap-ssi.h

-- 
1.7.10.4

