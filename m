From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH v2 0/5] Convert I2C driver to use omap_device/runtime PM
Date: Fri, 17 Sep 2010 20:07:04 +0530
Message-ID: <1284734229-16281-1-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59149 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753957Ab0IQOhP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Sep 2010 10:37:15 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o8HEbC1P005340
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 17 Sep 2010 09:37:14 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Rajendra Nayak <rnayak@ti.com>

This series makes I2C device registration use hwmod
and omap_device api's and converts the I2C driver to use
runtime PM api's.

Patches apply on the pm-core branch from Kevin's tree.

v2 has minor review comment fixes over v1 and is additionally
boot tested on a 2430sdp platform along with being tested on
3430sdp and 4430sdp.

4430sdp tests are done using the below series
http://www.spinics.net/lists/linux-omap/msg36023.html

Paul Walmsley (2):
  OMAP2xxx: hwmod: add I2C hwmods for OMAP2420, 2430
  OMAP: I2C: split device registration and convert OMAP2+ to
    omap_device

Rajendra Nayak (3):
  OMAP3: hwmod: add I2C hwmods for OMAP3430
  OMAP4: hwmod: add I2C hwmods for OMAP4430
  OMAP: I2C: Convert i2c driver to use PM runtime api's

 arch/arm/mach-omap2/omap_hwmod_2420_data.c |  138 ++++++++++++++++-
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |  144 +++++++++++++++++-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |  232 +++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  237 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/prm-regbits-34xx.h     |    3 +
 arch/arm/plat-omap/i2c.c                   |  124 ++++++---------
 arch/arm/plat-omap/include/plat/i2c.h      |   16 ++
 arch/arm/plat-omap/include/plat/l4_3xxx.h  |   24 +++
 drivers/i2c/busses/i2c-omap.c              |   67 +++------
 include/linux/i2c-omap.h                   |    5 +
 10 files changed, 865 insertions(+), 125 deletions(-)
 create mode 100644 arch/arm/plat-omap/include/plat/l4_3xxx.h

