From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: [GIT PULL] ARM: OMAP: GPIO cleanup and device tree adaptation
Date: Fri, 9 Mar 2012 17:33:31 +0100
Message-ID: <4F5A30DB.7060004@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40324 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757566Ab2CIQdo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 Mar 2012 11:33:44 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Hilman, Kevin" <khilman@ti.com>

Hi Grant,

Please pull the patches for OMAP GPIO DT support.
It is based on your current gpio/next branch.

Thanks,
Benoit


The following changes since commit e4e449e82871c53ef3b22bd3a50fceabc0638926:
  Mark Brown (1):
        gpiolib: Add comments explaining the _cansleep() WARN_ON()s

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git for_grant/for_3.4/dt_gpio

Benoit Cousson (4):
      gpio/omap: Remove bank->id information and misc cleanup
      gpio/omap: Use devm_ API and add request_mem_region
      gpio/omap: Add DT support to GPIO driver
      gpio/omap: Fix IRQ handling for SPARSE_IRQ

 .../devicetree/bindings/gpio/gpio-omap.txt         |   36 ++++
 arch/arm/plat-omap/include/plat/gpio.h             |   22 +--
 drivers/gpio/gpio-omap.c                           |  208 ++++++++++++++------
 3 files changed, 190 insertions(+), 76 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-omap.txt
