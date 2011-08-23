From: Hemant Pedanekar <hemantp@ti.com>
Subject: [RFC PATCH v2 0/6] TI81XX: Add clock and hwmod data
Date: Tue, 23 Aug 2011 22:43:14 +0530
Message-ID: <1314119594-22647-1-git-send-email-hemantp@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49788 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751959Ab1HWRNa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Aug 2011 13:13:30 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Hemant Pedanekar <hemantp@ti.com>

This patch set is the v2 of TI816X clock and hwmods patches sent earlier.

The clock data is currently added only for TI816X, while minimal hwmod data
common for TI816X and TI814X is added.

This patch set depends on following patches:
	TI81XX: Prepare for addition of TI814X support
	TI814X: Add cpu type macros and detection support
	TI814X: Create board support and enable build for TI8148 EVM

Please note that CHIP_IS_TI816X/CHIP_IS_TI814X are still being used and I will
send update once SoC list usage is available.	

Hemant Pedanekar (6):
  TI816X: prcm: Add module and register offsets
  TI816X: clock: Add clock data
  TI816X: clock: Add clockdomains and powerdomains data
  clock: Integrate TI816X clock data into OMAP clock framework
  TI81XX: Add minimal hwmod data
  hwmods: Integrate TI81XX hwmods

 arch/arm/mach-omap2/Makefile                     |    5 +
 arch/arm/mach-omap2/clock3xxx_data.c             |    5 +-
 arch/arm/mach-omap2/clock816x.h                  |   21 +
 arch/arm/mach-omap2/clock816x_data.c             | 1108 ++++++++++++++++++++++
 arch/arm/mach-omap2/clockdomain.h                |    1 +
 arch/arm/mach-omap2/clockdomain2xxx_3xxx.c       |   18 +-
 arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c |    1 +
 arch/arm/mach-omap2/clockdomains816x_data.c      |  196 ++++
 arch/arm/mach-omap2/cm-regbits-816x.h            |   44 +
 arch/arm/mach-omap2/cm2xxx_3xxx.c                |   35 +
 arch/arm/mach-omap2/cm2xxx_3xxx.h                |    6 +
 arch/arm/mach-omap2/cm816x.h                     |  368 +++++++
 arch/arm/mach-omap2/cm81xx.c                     |   54 ++
 arch/arm/mach-omap2/io.c                         |    3 +
 arch/arm/mach-omap2/omap_hwmod.c                 |   13 +-
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c       |  677 +++++++++++++
 arch/arm/mach-omap2/powerdomain.h                |    2 +
 arch/arm/mach-omap2/powerdomain2xxx_3xxx.c       |   27 +-
 arch/arm/mach-omap2/powerdomains3xxx_data.c      |    4 +-
 arch/arm/mach-omap2/powerdomains816x_data.c      |   84 ++
 arch/arm/mach-omap2/prm2xxx_3xxx.h               |   21 +
 arch/arm/plat-omap/include/plat/omap_hwmod.h     |    1 +
 22 files changed, 2682 insertions(+), 12 deletions(-)
 create mode 100644 arch/arm/mach-omap2/clock816x.h
 create mode 100644 arch/arm/mach-omap2/clock816x_data.c
 create mode 100644 arch/arm/mach-omap2/clockdomains816x_data.c
 create mode 100644 arch/arm/mach-omap2/cm-regbits-816x.h
 create mode 100644 arch/arm/mach-omap2/cm816x.h
 create mode 100644 arch/arm/mach-omap2/cm81xx.c
 create mode 100644 arch/arm/mach-omap2/omap_hwmod_81xx_data.c
 create mode 100644 arch/arm/mach-omap2/powerdomains816x_data.c

-- 
1.7.3.5

