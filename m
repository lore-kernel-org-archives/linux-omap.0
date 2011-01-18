From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH v4 0/6] OMAP: McSPI: Hwmod adaptation + runtime conversion
Date: Tue, 18 Jan 2011 19:22:33 +0530
Message-ID: <1295358759-11731-1-git-send-email-govindraj.raja@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45248 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751018Ab1ARNhl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 18 Jan 2011 08:37:41 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, spi-devel-general@lists.sourceforge.net, linux-arm-kernel@lists.infradead.org
Cc: grant.likely@secretlab.ca, charu@ti.com, b-cousson@ti.com, paul@pwsan.com, khilman@ti.com, tony@atomide.com, "Govindraj.R" <govindraj.raja@ti.com>

Changes invloves:
----------------
1) Addition of hwmod data for omap2/3/4.
2) McSPI driver hwmod adaptation with cleanup of base address
   macros and using omap-device API's.
3) Runtime Conversion of McSPI driver.

Changes fomr v3:
---------------
1) Updated proper Author for all patches which was missed
   in v2. 
2) Modified 4430 hwmod data file so that mcspi data gets
   updated in proper alphabetical order.
3) Update omap2/3 hwmod dat files with SYSS_HAS_RESET_STATUS
   flag.

Changes from v2:
---------------
1) Fixing minor comments and adding ack from Grant Likely.
	https://patchwork.kernel.org/patch/371321/
	https://patchwork.kernel.org/patch/371331/

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
This test basically involves MISO <--> MOSI lines looped and data transfer test
done using the above test module.
System wide suspend and ret/off counts observation, ensured that no behavioral
difference with and without this patch series.

Benoit Cousson (1):
  OMAP4: hwmod data: Add McSPI

Charulatha V (4):
  OMAP2420: hwmod data: Add McSPI
  OMAP2430: hwmod data: Add McSPI
  OMAP3: hwmod data: Add McSPI
  OMAP: devices: Modify McSPI device to adapt to hwmod framework

Govindraj.R (1):
  OMAP: runtime: McSPI driver runtime conversion

 arch/arm/mach-omap2/devices.c              |  187 ++++---------------
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |  156 ++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |  219 ++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |  280 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  266 ++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/mcspi.h    |   11 +
 drivers/spi/omap2_mcspi.c                  |  224 +++++++---------------
 7 files changed, 1043 insertions(+), 300 deletions(-)

