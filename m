From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH v6 0/6] OMAP: McSPI: Hwmod adaptation + runtime conversion
Date: Wed,  2 Feb 2011 17:52:09 +0530
Message-ID: <1296649335-31756-1-git-send-email-govindraj.raja@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55839 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752853Ab1BBMEf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 2 Feb 2011 07:04:35 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, spi-devel-general@lists.sourceforge.net, linux-arm-kernel@lists.infradead.org
Cc: "Govindraj.R" <govindraj.raja@ti.com>, Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Charulatha V <charu@ti.com>

Changes invloves:
----------------
1) Addition of hwmod data for omap2/3/4.
2) McSPI driver hwmod adaptation with cleanup of base address
   macros and using omap-device API's.
3) Runtime Conversion of McSPI driver.

Changes from v5:
---------------
Rebased on top of 2.6.38-rc3 as per Kevin's comments.
http://www.spinics.net/lists/arm-kernel/msg112112.html

Changes from v4:
---------------
1) 4430 hwmod file alignment based on Benoit's comments.
   http://www.spinics.net/lists/arm-kernel/msg111215.html
   4430 Hwmod file now aligned based on:
   http://gitorious.org/omap-pm/linux/blobs/pm-wip/
   hwmods-omap4-full/arch/arm/mach-omap2/omap_hwmod_44xx_data.c

Changes from v3:
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

Testing procedure involves:
---------------------------
Loopback test based on SPI interface available from
board expansion connector.
MISO <---> MOSI

Platforms used where:
--------------------
Using the above mentioned test module we had done some
data transfer tests.
1) OMAP2430 SDP.
2) OMAP3 (OMAP3430/3630SDP, ZOOM boards zoom2/3).
3) OMAP4430 SDP.
   [Along with loopback test basic Ethernet functionality
   was checked which is over SPI interface].
   Blaze-Board(OMAP4430) Boot tested with ethernet interface.
4) Boot tested on 2420/n800.

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
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  267 ++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/mcspi.h    |   11 +
 drivers/spi/omap2_mcspi.c                  |  220 +++++++---------------
 7 files changed, 1040 insertions(+), 300 deletions(-)

