From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 0/5] 32k sync timer meets hwmod
Date: Tue, 19 Oct 2010 12:22:11 +0300
Message-ID: <1287480136-2046-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39037 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754337Ab0JSJWc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Oct 2010 05:22:32 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

Hi all,

Converted 32k-sync timer to platform_driver
and now using pm_runtime and hwmod.

Tested on 3430 by me and 4430 by Tarun

If someone could test on 2430 and 2420, I would
be really glad.

Felipe Balbi (5):
  arm: omap1/2/3/4: convert 32k-sync driver to a platform_driver
  arm: omap: counter-32k: convert to pm_runtime API
  clocksource: move omap 32k timer to drivers/clocksource
  arm: omap: introduce 32k timer hwmod for omap2/3/4
  arm: omap: 32k: move to omap_device_build

 arch/arm/mach-omap1/devices.c              |   24 +++
 arch/arm/mach-omap2/clock2420_data.c       |    2 +-
 arch/arm/mach-omap2/clock2430_data.c       |    2 +-
 arch/arm/mach-omap2/clock3xxx_data.c       |    2 +-
 arch/arm/mach-omap2/devices.c              |   36 +++++
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |   52 ++++++
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |   52 ++++++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   51 ++++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   61 ++++++++
 arch/arm/plat-omap/Makefile                |    2 +-
 arch/arm/plat-omap/counter_32k.c           |  183 ----------------------
 drivers/clocksource/Makefile               |    1 +
 drivers/clocksource/omap-32k.c             |  231 ++++++++++++++++++++++++++++
 13 files changed, 512 insertions(+), 187 deletions(-)
 delete mode 100644 arch/arm/plat-omap/counter_32k.c
 create mode 100644 drivers/clocksource/omap-32k.c

-- 
1.7.3.1.120.g38a18

