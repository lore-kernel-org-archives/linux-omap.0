From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] ARM: OMAP: I2C: prepare to use hwmod reset in driver
Date: Fri, 16 Dec 2011 02:55:54 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1112160254320.12660@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47154 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750900Ab1LPJzz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Dec 2011 04:55:55 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Tony

The following changes since commit dc47ce90c3a822cd7c9e9339fe4d5f61dcb26b50:

  Linux 3.2-rc5 (2011-12-09 15:09:32 -0800)

are available in the git repository at:
  git://git.pwsan.com/linux-2.6 i2c_reset_devel_3.3

Shubhrajyoti D (2):
      ARM: OMAP: omap_device: add omap_device_reset to reset all the hwmods in the device
      ARM: OMAP: I2C: Reset support

 arch/arm/plat-omap/i2c.c                      |    2 ++
 arch/arm/plat-omap/include/plat/omap_device.h |    1 +
 arch/arm/plat-omap/omap_device.c              |   22 ++++++++++++++++++++++
 include/linux/i2c-omap.h                      |    1 +
 4 files changed, 26 insertions(+), 0 deletions(-)
