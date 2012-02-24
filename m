From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH v2 0/6] gpio/omap: Cleanup and adaptation to Device Tree
Date: Fri, 24 Feb 2012 23:21:25 +0100
Message-ID: <1330122091-28113-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59240 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754817Ab2BXWVi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Feb 2012 17:21:38 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: grant.likely@secretlab.ca
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>

Hi Grant,

Here are a couple of GPIO cleanup + the DT adaptation patches.
This update (compared to v1 [1]) is adding an extra fix for SPARSE_IRQ support
and add the second cell in the binding for GPIO IRQ type that was missing
previously whereas the driver does support it.

This series is based on 3.3-rc4 + for_3.4/dt_base branch to get
the needed cleanup and fixes for OMAP.

The interrupt controller support is using irq_domain_add_legacy for
the moment and will be updated next to use irqchip irq_domain.

It requires the irq_domain generalization and refinement series
available at:
  git://git.secretlab.ca/git/linux-2.6 irqdomain/next
  
It requires as well Tarun's GPIO cleanup series available at:
  git://gitorious.org/~tarunkanti/omap-sw-develoment/tarunkantis-linux-omap-dev for_3.4/gpio_cleanup_fixes_v9

This series is available here for reference:
  git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git for_3.4/dt_gpio

Regards,
Benoit

[1] http://www.spinics.net/lists/linux-omap/msg64694.html


Benoit Cousson (6):
  gpio/omap: Remove bank->id information and misc cleanup
  gpio/omap: Use devm_ API and add request_mem_region
  gpio/omap: Add DT support to GPIO driver
  gpio/omap: Fix IRQ handling for SPARSE_IRQ
  arm/dts: OMAP4: Add gpio nodes
  arm/dts: OMAP3: Add gpio nodes

 .../devicetree/bindings/gpio/gpio-omap.txt         |   36 ++++
 arch/arm/boot/dts/omap3.dtsi                       |   54 +++++
 arch/arm/boot/dts/omap4.dtsi                       |   54 +++++
 arch/arm/mach-omap2/gpio.c                         |    8 +-
 arch/arm/plat-omap/include/plat/gpio.h             |   22 +--
 drivers/gpio/gpio-omap.c                           |  208 ++++++++++++++------
 6 files changed, 304 insertions(+), 78 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-omap.txt

