From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: [PATCH 0/6] Convert I2C driver to hwmod + omap-device
Date: Fri, 19 Feb 2010 17:56:25 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB03215B1582@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37274 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752371Ab0BSM0c convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Feb 2010 07:26:32 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Hilman, Kevin" <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>

Hi,

This series converts I2C driver to use hwmod + omap_device api's.
Patches apply on the pm-wip/hwmods branch from Kevin's tree.
git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git

I have tested the patches on the 3430sdp platform. For omap2 the
patches are not boot tested, but only compile tested.

regards,
Rajendra

Paul Walmsley (2):
  OMAP2xxx: hwmod: add I2C hwmods for OMAP2420, 2430
  OMAP: I2C: split device registration; convert OMAP2+ to omap_device

Rajendra Nayak (4):
  OMAP2: hwmod: Fix MMC hwmod structs for 2430
  OMAP3: hwmod: add I2C hwmods for OMAP3430
  OMAP: I2C: Convert i2c driver to use omap_device/omap_hwmod
  OMAP: Fix compile break in serial with CONFIG_PM disabled

 arch/arm/mach-omap1/i2c.c                 |  103 +++++++++++++
 arch/arm/mach-omap2/i2c.c                 |   67 +++++++++
 arch/arm/mach-omap2/omap_hwmod_2420.h     |  134 +++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_2430.h     |  166 +++++++++++++++++++--
 arch/arm/mach-omap2/omap_hwmod_34xx.h     |  228 +++++++++++++++++++++++++++++
 arch/arm/mach-omap2/prm-regbits-34xx.h    |    9 +-
 arch/arm/mach-omap2/serial.c              |    7 +-
 arch/arm/plat-omap/i2c.c                  |  144 ++++++------------
 arch/arm/plat-omap/include/plat/i2c.h     |   37 +++++
 arch/arm/plat-omap/include/plat/l4_3xxx.h |    7 +
 drivers/i2c/busses/i2c-omap.c             |   75 ++++------
 11 files changed, 814 insertions(+), 163 deletions(-)

