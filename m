From: Thomas Weber <weber@corscience.de>
Subject: [PATCH V2 0/4] OMAP2: Board support for DevKit8000
Date: Thu,  4 Feb 2010 17:18:56 +0100
Message-ID: <1265300336-1749-1-git-send-email-weber@corscience.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:55274 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758245Ab0BDQS6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Feb 2010 11:18:58 -0500
Received: from localhost.localdomain (unknown [192.168.0.2])
	by corscience.de (Postfix) with ESMTP id AA29951CF7
	for <linux-omap@vger.kernel.org>; Thu,  4 Feb 2010 17:18:56 +0100 (CET)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tomi.Valkeinen@nokia.com, jhnikula@gmail.com, tony@atomide.com, felipe.balbi@nokia.com

These patches add support for Timll DevKit8000. The DevKit8000 is 
a beagle board clone with ethernet and lcd. The patches based on
work from embest, Kim Botherway and many others.

Changelog
V2
	Add minimal support for DevKit8000
		Add correct position of led3.
		Replace path with board manufacturer in header.
		Still only one nand resource. :(
		Comments removed from ads7846_config.
		Blank lines removed.
		DM9000 end initialization removed.
		Add DSS2 support.
				
	Add devkit8000_defconfig
		Update to new configuration.
	
	Add ASoC support for Devkit8000
		Expand omap3beagle sound soc for DevKit8000 support.
	
	OMAP: DSS: Add Innolux 7" display for DevKit8000
		Add 7 inch panel Innolux AT070TN83.

Thomas Weber (4):
  Add minimal support for DevKit8000
  Add devkit8000_defconfig
  Add ASoC support for Devkit8000
  OMAP: DSS: Add Innolux 7" display for DevKit8000

 arch/arm/configs/devkit8000_defconfig              | 1889 ++++++++++++++++++++
 arch/arm/mach-omap2/Kconfig                        |    4 +
 arch/arm/mach-omap2/Makefile                       |    2 +
 arch/arm/mach-omap2/board-devkit8000.c             |  691 +++++++
 drivers/video/omap2/displays/Kconfig               |    8 +-
 drivers/video/omap2/displays/Makefile              |    1 +
 .../video/omap2/displays/panel-innolux-at070tn83.c |  109 ++
 sound/soc/omap/Kconfig                             |    8 +-
 sound/soc/omap/omap3beagle.c                       |    6 +-
 9 files changed, 2711 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm/configs/devkit8000_defconfig
 create mode 100644 arch/arm/mach-omap2/board-devkit8000.c
 create mode 100644 drivers/video/omap2/displays/panel-innolux-at070tn83.c

