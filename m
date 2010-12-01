From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH 0/7 v2] OMAP: McSPI: Hwmod adaptation + runtime conversion
Date: Wed, 1 Dec 2010 19:31:12 +0530 (IST)
Message-ID: <33183.10.24.255.18.1291212072.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44534 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754954Ab0LAOB1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 1 Dec 2010 09:01:27 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, spi-devel-general <spi-devel-general@lists.sourceforge.net>, linux-arm-kernel@lists.infradead.org
Cc: Charulatha V <charu@ti.com>, Cousson@dbdmail.itg.ti.com, Benoit <b-cousson@ti.com>

Changes invloves:
----------------
1) Addition of hwmod data for omap2/3/4.
1) McSPI driver hwmod adaptation with cleanup of base address
   macros and using omap-device API's.
2) Runtime Conversion of McSPI driver

Changes from v1:
---------------
1) Fixing patch 5/5 comments for hwmod+runtime
   Split the patch 5/5 to hwmod adaptation
   and then runtime conversion
   http://www.mail-archive.com/linux-omap@vger.kernel.org/msg33387.html

Testing Updates:
----------------
Was tested using data transfer test module available at:
http://dev.omapzoom.org/?p=richo/device_driver_test.git;a=blob;f=mcspi/test_code/
utils/mcspi_modules/omap_mcspi_datatest.c;
h=e42ec10c5c844abdde6a7175a268b379fbbdb655;
hb=5d9a755d50e58de861c5e8991f2f607bc49b5dc3

System wide suspend and ret/off counts observation,
ensured that no behavioral difference with and without
this patch series.

Benoit Cousson (1):
  OMAP4: hwmod data: Add McSPI

Charulatha V (5):
  OMAP2420: hwmod data: Add McSPI
  OMAP2430: hwmod data: Add McSPI
  OMAP3: hwmod data: Add McSPI
  OMAP3: clocks: Update clock domain name for mcspi fck
  OMAP: devices: Modify McSPI device to adapt to hwmod framework

Govindraj.R (1):
  OMAP: runtime: McSPI driver runtime conversion

 arch/arm/mach-omap2/clock3xxx_data.c       |    4 +
 arch/arm/mach-omap2/devices.c              |  189 ++++---------------
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |  156 ++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |  219 ++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |  280 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  267 ++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/mcspi.h    |   11 +
 drivers/spi/omap2_mcspi.c                  |  225 +++++++---------------
 8 files changed, 1051 insertions(+), 300 deletions(-)


