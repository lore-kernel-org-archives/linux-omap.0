From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 0/5] gpio/omap: Cleanup and adaptation to Device Tree
Date: Wed, 15 Feb 2012 17:04:09 +0100
Message-ID: <1329321854-24490-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54982 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750907Ab2BOQE3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Feb 2012 11:04:29 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: grant.likely@secretlab.ca
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, devicetree-discuss@lists.ozlabs.org, Benoit Cousson <b-cousson@ti.com>

Hi Grant,

Here are a couple of GPIO cleanup + the DT adaptation patches.

This series is based on lo/master (a37cdd9) + for_3.4/dt_base branch to get
the needed cleanup and fixes for OMAP.

The interrupt controller support is using irq_domain_add_legacy for
the moment and will be updated next to use irqchip irq_domain.

It requires the irq_domain generalization and refinement series
available at:
  git://git.secretlab.ca/git/linux-2.6 irqdomain/next
  
But I guess you already know where to find it :-)

It requires as well Tarun's GPIO cleanup series available at:
  git://gitorious.org/~tarunkanti/omap-sw-develoment/tarunkantis-linux-omap-dev for_3.4/gpio_cleanup_fixes_v9

This series is available here for reference:
  git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git for_3.4/dt_gpio

Regards,
Benoit


Benoit Cousson (5):
  gpio/omap: Remove bank->id information and misc cleanup
  gpio/omap: Use devm_ API and add request_mem_region
  gpio/omap: Add DT support to GPIO driver
  arm/dts: OMAP4: Add gpio nodes
  arm/dts: OMAP3: Add gpio nodes

 .../devicetree/bindings/gpio/gpio-omap.txt         |   30 ++++
 arch/arm/boot/dts/omap3.dtsi                       |   54 ++++++
 arch/arm/boot/dts/omap4.dtsi                       |   54 ++++++
 arch/arm/mach-omap2/gpio.c                         |    8 +-
 drivers/gpio/gpio-omap.c                           |  175 +++++++++++++++-----
 5 files changed, 278 insertions(+), 43 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-omap.txt

