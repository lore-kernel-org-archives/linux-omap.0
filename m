From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH v2 0/4] lis3: lis3lv02d_i2c: Add device tree support
Date: Fri, 14 Sep 2012 13:36:52 +0530
Message-ID: <1347610016-10123-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46294 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757398Ab2INIHn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 14 Sep 2012 04:07:43 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arnd@arndb.de
Cc: gregkh@linuxfoundation.org, eric.piel@tremplin-utc.net, jic23@cam.ac.uk, greg@kroah.com, akpm@linux-foundation.org, broonie@opensource.wolfsonmicro.com, dmitry.torokhov@gmail.com, tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca, AnilKumar Ch <anilkumar@ti.com>

Adds device tree support to lis3lv02d_i2c driver. Along with this
DT init is moved from core driver to individual drivers, with the
current implementation some pdata is missing in lis3lv02d_i2c driver.

Also adds platform data for lis331dlh driver to am335x-EVM. These
patches were tested on AM335x-EVM.

Changes from v1:
	- Moved lis3lv02d_init_dt to individual drivers with
	  some code clean-up.
	- Added lis331dlh compatible entry for lis331dlh parts

AnilKumar Ch (4):
  lis3: lis3lv02d: remove lis3lv02d driver DT init
  lis3: lis3lv02d_spi: Add lis3lv02d device tree init
  lis3: lis3lv02d_i2c: Add lis3lv02d device tree init
  ARM: dts: AM33XX: Add lis331dlh device tree data to am335x-evm

 arch/arm/boot/dts/am335x-evm.dts       |   42 ++++++++++++++++++++++++++++++++
 drivers/misc/lis3lv02d/lis3lv02d.c     |    8 ++----
 drivers/misc/lis3lv02d/lis3lv02d.h     |    1 +
 drivers/misc/lis3lv02d/lis3lv02d_i2c.c |   19 +++++++++++++++
 drivers/misc/lis3lv02d/lis3lv02d_spi.c |    8 +++---
 5 files changed, 69 insertions(+), 9 deletions(-)

-- 
1.7.9.5

