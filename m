From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] OMAP: hwmod fixes and improvements for 2.6.37
Date: Thu, 23 Sep 2010 01:23:12 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1009230121290.18576@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-1478681438-1285226592=:18576"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:58633 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753242Ab0IWHXN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Sep 2010 03:23:13 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com, linux-arm-kernel@lists.infradead.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1478681438-1285226592=:18576
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE


Hi Tony,

The following changes since commit b30a3f6257ed2105259b404d419b4964e363928c=
:

  Linux 2.6.36-rc5 (2010-09-20 16:56:53 -0700)

are available in the git repository at:
  git://git.pwsan.com/linux-2.6 hwmod_2.6.37

Benoit Cousson (6):
      OMAP: hwmod: Rename dma_ch to dma_req
      OMAP: hwmod: Do not disable clocks if hwmod already in idle
      OMAP4: prcm: Add temporarily helper functions for rmw and read inside=
 the PRM
      OMAP: hwmod: Force a softreset during _setup
      OMAP: hwmod: Fix softreset status check for some new OMAP4 IPs
      OMAP: hwmod: Fix softreset for modules with optional clocks

Beno=EEt Cousson (2):
      OMAP4: PRM: add module hard reset support
      OMAP: hwmod: Add hardreset management support

Kevin Hilman (1):
      OMAP: hwmod: separate list locking and hwmod hardware locking

Liam Girdwood (1):
      OMAP: hwmod: Fix omap_hwmod_reset wrong state test

Partha Basak (1):
      OMAP: hwmod: Handle opt clocks node using clk_add_alias

Paul Walmsley (3):
      OMAP2/3: PRM: add module hard reset support
      OMAP: hwmod: add an hardreset API for use by other core code
      OMAP: hwmod: improve documentation, clean up function names

Rajeev Kulkarni (1):
      OMAP4: prcm: Fix global warm reset bit position

Rajendra Nayak (1):
      OMAP: hwmod: Enable module wakeup if in smartidle

 arch/arm/mach-omap2/Makefile                 |    4 +-
 arch/arm/mach-omap2/omap_hwmod.c             |  562 +++++++++++++++++++++-=
---
 arch/arm/mach-omap2/prcm.c                   |   29 ++-
 arch/arm/mach-omap2/prm.h                    |   18 +-
 arch/arm/mach-omap2/prm2xxx_3xxx.c           |  110 +++++
 arch/arm/mach-omap2/prm44xx.c                |  116 ++++++
 arch/arm/plat-omap/include/plat/omap_hwmod.h |   55 ++-
 arch/arm/plat-omap/include/plat/prcm.h       |    2 +
 arch/arm/plat-omap/omap_device.c             |   43 ++-
 9 files changed, 829 insertions(+), 110 deletions(-)
 create mode 100644 arch/arm/mach-omap2/prm2xxx_3xxx.c
 create mode 100644 arch/arm/mach-omap2/prm44xx.c


There may be a few more minor hwmod patches coming, but these are the=20
important ones that some of the driver hwmod conversions depend on.


- Paul

--155748971-1478681438-1285226592=:18576--
