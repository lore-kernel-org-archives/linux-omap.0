From: "Hemanth V" <hemanthv@ti.com>
Subject: [PATCH V2 0/3] McSPI Slave, FIFO support on OMAP
Date: Wed, 3 Feb 2010 15:51:28 +0530 (IST)
Message-ID: <9542.10.24.255.17.1265192488.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39010 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756942Ab0BCKVk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Feb 2010 05:21:40 -0500
References: 
In-Reply-To: 
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: spi-devel-general@lists.sourceforge.net
Cc: linux-omap@vger.kernel.org, dbrownell@users.sourceforge.net, grant.likely@secretlab.ca

This patch series adds support for slave, FIFO for McSPI on OMAP.

DMA and FIFO could be enabled together for better throughput. Platform config
parameters have been added to enable these features on any particular McSPI
controller.

FIFO can be enabled by defining fifo_depth parameter. fifo_depth needs to be a
multiple of buffer size that is used for read/write.

These features are useful when you have high throughput devices on SPI.

This patch incorporates review comments

PATCH[1/3]: Update Platform files for SPI
PATCH[2/3]: Adds support for FIFO
PATCH[3/3]: Adds support for Slave mode

Signed-off-by: Hemanth V <hemanthv@ti.com>
---
 arch/arm/mach-omap2/devices.c           |    5 +
 arch/arm/plat-omap/include/mach/mcspi.h |   16 ++
 drivers/spi/omap2_mcspi.c               |  345 +++++++++++++++++++++++++++---
3 files changed, 331 insertions(+), 35 deletions(-)








