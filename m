From: jean.pihet@newoldbits.com
Subject: [PATCH 0/2] ARM: OMAP: SmartReflex: pass device dependent data via platform data
Date: Thu,  4 Oct 2012 18:47:09 +0200
Message-ID: <1349369231-25204-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:40343 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932263Ab2JDQq4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Oct 2012 12:46:56 -0400
Received: by mail-wi0-f172.google.com with SMTP id hq12so4587302wib.1
        for <linux-omap@vger.kernel.org>; Thu, 04 Oct 2012 09:46:55 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, Kevin Hilman <khilman@ti.com>, Anton Vorontsov <cbou@mail.ru>
Cc: J Keerthy <j-keerthy@ti.com>, Jean Pihet <j-pihet@ti.com>

From: Jean Pihet <j-pihet@ti.com>

Remove the device dependent code (ex. cpu_is_xxx()) and settings
from the driver code and instead pass them via the platform
data. This allows a clean separation of the driver code and the platform
code, as required by the move of the platform header files to
include/linux/platform_data.

Note about the smartreflex functional clocks: the smartreflex fclks
are derived from sys_clk and have the same name as the main_clk from
the hwmod entry, in order for the SmartReflex driver to request the
fclk (using clk_get(dev, "fck")).

Based on mainline 3.6.0. Boot tested on OMAP3&4 platforms.

Jean Pihet (2):
  ARM: OMAP: hwmod: align the SmartReflex fck names
  ARM: OMAP: SmartReflex: pass device dependent data via platform data

 arch/arm/mach-omap2/clock33xx_data.c       |   12 +++----
 arch/arm/mach-omap2/clock3xxx_data.c       |   12 +++----
 arch/arm/mach-omap2/clock44xx_data.c       |    6 ++--
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    8 ++---
 arch/arm/mach-omap2/sr_device.c            |   13 +++++++
 drivers/power/avs/smartreflex.c            |   54 +++++++++-------------------
 include/linux/power/smartreflex.h          |   14 ++++++--
 7 files changed, 61 insertions(+), 58 deletions(-)

-- 
1.7.10.4

