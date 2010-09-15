From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 0/4] OMAP OPP layer for 2.6.37
Date: Wed, 15 Sep 2010 14:56:35 -0700
Message-ID: <1284587799-9637-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:37069 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751727Ab0IOV4m (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Sep 2010 17:56:42 -0400
Received: by pvg2 with SMTP id 2so195722pvg.19
        for <linux-omap@vger.kernel.org>; Wed, 15 Sep 2010 14:56:41 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

This series introduces a layer to manage Operating Performance Points (OPPs)
for OMAP SoCs.

Special thanks to Nishanth for doing the bulk of the work on this
series and to Thara for doing significant review, testing and updates.

Kevin Hilman (1):
  OMAP3: remove OPP interfaces from OMAP PM layer

Nishanth Menon (2):
  OMAP: introduce OPP layer for device-specific OPPs
  OMAP3: OPP: add OPP table data and initialization

Paul Walmsley (1):
  OMAP: OPP: twl/tps: Introduce TWL/TPS-specific code

 Documentation/arm/OMAP/omap_pm                |   83 +++++
 arch/arm/mach-omap2/Makefile                  |    2 +
 arch/arm/mach-omap2/io.c                      |    3 +-
 arch/arm/mach-omap2/opp3xxx_data.c            |  126 +++++++
 arch/arm/mach-omap2/pm.c                      |    6 +
 arch/arm/mach-omap2/pm.h                      |    1 +
 arch/arm/plat-omap/Makefile                   |    6 +
 arch/arm/plat-omap/include/plat/omap-pm.h     |   31 +--
 arch/arm/plat-omap/include/plat/opp.h         |  145 ++++++++
 arch/arm/plat-omap/include/plat/opp_twl_tps.h |   21 ++
 arch/arm/plat-omap/omap-pm-noop.c             |   11 +-
 arch/arm/plat-omap/opp.c                      |  461 +++++++++++++++++++++++++
 arch/arm/plat-omap/opp_twl_tps.c              |   41 +++
 13 files changed, 904 insertions(+), 33 deletions(-)
 create mode 100644 arch/arm/mach-omap2/opp3xxx_data.c
 create mode 100644 arch/arm/plat-omap/include/plat/opp.h
 create mode 100644 arch/arm/plat-omap/include/plat/opp_twl_tps.h
 create mode 100644 arch/arm/plat-omap/opp.c
 create mode 100644 arch/arm/plat-omap/opp_twl_tps.c

-- 
1.7.2.1

