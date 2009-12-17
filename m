From: hvaibhav@ti.com
Subject: [PATCH 0/5] Enable DSS2 for OMAP3EVM & AM3517
Date: Thu, 17 Dec 2009 20:48:03 +0530
Message-ID: <1261063083-19822-1-git-send-email-hvaibhav@ti.com>
References: <hvaibhav@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56979 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965131AbZLQPS0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Dec 2009 10:18:26 -0500
In-Reply-To: <hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com
Cc: linux-omap@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, linux-fbdev@vger.kernel.org, Vaibhav Hiremath <hvaibhav@ti.com>

From: Vaibhav Hiremath <hvaibhav@ti.com>

Patch series adds following features -

	- Enable DSS2/Fbdev on OMAP3EVM
	- Add LQ043T1DG01 panel file
	- Enable DSS2/Fbdev on AM3517EVM
	- Warning message fix in dss-core
	- Kconfig option added to choose between S-Video and CVBS output

TODO -
	- V4L2 Display driver ontop of DSS2 (will post in couple of days)
	- regulator_get for panel-generic.c, which is required to get DVI colors
	  properly

Vaibhav Hiremath (5):
  dss2-core:Warning Fix: core_dump_clocks enclosed under DEBUG_FS
  OMAP: DSS2: Add Sharp LQ043T1DG01 panel drivers
  OMAP: Enable DSS2 for OMAP3EVM board
  AM3517: Enable DSS2 for AM3517EVM board
  OMAP3EVM: Kconfig option added for selection between SVIDEO and CVBS

 arch/arm/configs/am3517_evm_defconfig              |   53 ++++-
 arch/arm/configs/omap3_evm_defconfig               |   51 ++++-
 arch/arm/mach-omap2/board-am3517evm.c              |  142 +++++++++++
 arch/arm/mach-omap2/board-omap3evm.c               |  250 +++++++++++++++++++-
 drivers/video/omap2/displays/Kconfig               |    6 +
 drivers/video/omap2/displays/Makefile              |    1 +
 .../video/omap2/displays/panel-sharp-lq043t1dg01.c |  120 ++++++++++
 drivers/video/omap2/dss/Kconfig                    |   15 ++
 drivers/video/omap2/dss/core.c                     |    2 +
 9 files changed, 627 insertions(+), 13 deletions(-)
 create mode 100644 drivers/video/omap2/displays/panel-sharp-lq043t1dg01.c

