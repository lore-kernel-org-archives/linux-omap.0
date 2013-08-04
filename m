From: Sourav Poddar <sourav.poddar@ti.com>
Subject: [PATCHv9 0/2] Add ti qspi controller
Date: Sun, 4 Aug 2013 14:28:08 +0530
Message-ID: <1375606690-834-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35420 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752129Ab3HDI6Z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 4 Aug 2013 04:58:25 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: broonie@kernel.org, spi-devel-general@lists.sourceforge.net, grant.likely@linaro.org
Cc: balbi@ti.com, rnayak@ti.com, linux-omap@vger.kernel.org, Sourav Poddar <sourav.poddar@ti.com>

This patch series add support for ti qspi controller.
Adapted this series on top of Mark brown series[1]:

[1]: https://patchwork.kernel.org/patch/2834694/

Sourav Poddar (2):
  drivers: spi: Add qspi flash controller
  driver: spi: Add quad spi read support

 Documentation/devicetree/bindings/spi/ti_qspi.txt |   22 +
 drivers/spi/Kconfig                               |    8 +
 drivers/spi/Makefile                              |    1 +
 drivers/spi/spi-ti-qspi.c                         |  601 +++++++++++++++++++++
 4 files changed, 632 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/ti_qspi.txt
 create mode 100644 drivers/spi/spi-ti-qspi.c

