From: Sourav Poddar <sourav.poddar@ti.com>
Subject: [PATCHv6 0/2] Add ti qspi controller
Date: Mon, 29 Jul 2013 12:52:28 +0530
Message-ID: <1375082550-30544-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44864 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750767Ab3G2HWp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Jul 2013 03:22:45 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: broonie@kernel.org, spi-devel-general@lists.sourceforge.net, grant.likely@linaro.org
Cc: linux-omap@vger.kernel.org, rnayak@ti.com, balbi@ti.com, Sourav Poddar <sourav.poddar@ti.com>

This patch series add support for ti qspi controller.
Adapted this series on top of Mark brown series[1]:

[1]: https://patchwork.kernel.org/patch/2834694/

And some other cleanups.

Sourav Poddar (2):
  drivers: spi: Add qspi flash controller
  driver: spi: Add quad spi read support

 Documentation/devicetree/bindings/spi/ti_qspi.txt |   22 +
 drivers/spi/Kconfig                               |    8 +
 drivers/spi/Makefile                              |    1 +
 drivers/spi/spi-ti-qspi.c                         |  532 +++++++++++++++++++++
 4 files changed, 563 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/ti_qspi.txt
 create mode 100644 drivers/spi/spi-ti-qspi.c

