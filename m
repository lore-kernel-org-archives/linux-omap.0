From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: [PATCH 0/4 RFC]OMAP:GPIO: Make GPIO an early init device
Date: Fri, 12 Feb 2010 19:07:27 +0530
Message-ID: <1265981851-11970-1-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46443 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752942Ab0BLNib (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Feb 2010 08:38:31 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o1CDcSXC021758
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 12 Feb 2010 07:38:30 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Charulatha V <charu@ti.com>

From: Charulatha V <charu@ti.com>

This patch series splits OMAP GPIO into OMAP1 and OMAP2 components. 
Then coverts OMAP2 OMAP3 and OMAP4 GPIO module to use device registration
model and makes GPIO an early init device. This is in preparation for
the omap_device conversion of the GPIO portions.

This patch series requires early driver register support patch
sent by Thara Gopinath (http://patchwork.kernel.org/patch/77926/).
These patches are generated on top of pm branch. These patches are
boot tested on SDP 3430 and compile tested for OMAP 2420 and 2430.

Charulatha V (4):
  OMAP2: Fix compile errors
  OMAP GPIO: split omap1 and omap2+
  OMAP: Convert GPIO into a early driver
  OMAP GPIO: Convert all printk's to pr_* in gpio

 arch/arm/mach-omap1/Makefile                  |    2 +-
 arch/arm/mach-omap1/gpio.c                    | 1255 ++++++++++++
 arch/arm/mach-omap2/Makefile                  |    2 +-
 arch/arm/mach-omap2/board-2430sdp.c           |    3 +-
 arch/arm/mach-omap2/board-3430sdp.c           |    3 +-
 arch/arm/mach-omap2/board-3630sdp.c           |    3 +-
 arch/arm/mach-omap2/board-4430sdp.c           |    3 +-
 arch/arm/mach-omap2/board-am3517evm.c         |    4 +-
 arch/arm/mach-omap2/board-apollon.c           |    3 +-
 arch/arm/mach-omap2/board-ldp.c               |    3 +-
 arch/arm/mach-omap2/board-omap3beagle.c       |    3 +-
 arch/arm/mach-omap2/board-omap3evm.c          |    3 +-
 arch/arm/mach-omap2/board-omap3pandora.c      |    3 +-
 arch/arm/mach-omap2/board-omap3touchbook.c    |    3 +-
 arch/arm/mach-omap2/board-overo.c             |    3 +-
 arch/arm/mach-omap2/board-rx51.c              |    3 +-
 arch/arm/mach-omap2/board-zoom2.c             |    3 +-
 arch/arm/mach-omap2/board-zoom3.c             |    3 +-
 arch/arm/mach-omap2/gpio.c                    | 2254 ++++++++++++++++++++++
 arch/arm/mach-omap2/io.c                      |    2 +
 arch/arm/mach-omap2/serial.c                  |    1 +
 arch/arm/plat-omap/Makefile                   |    2 +-
 arch/arm/plat-omap/gpio.c                     | 2521 -------------------------
 arch/arm/plat-omap/i2c.c                      |    2 +
 arch/arm/plat-omap/include/plat/gpio.h        |  145 ++
 25 files changed, 3671 insertions(+), 2555 deletions(-)
 create mode 100644 arch/arm/mach-omap1/gpio.c
 create mode 100644 arch/arm/mach-omap2/gpio.c
 delete mode 100644 arch/arm/plat-omap/gpio.c

