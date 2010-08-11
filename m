From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 0/4] OMAP OPP layer
Date: Tue, 10 Aug 2010 17:09:13 -0700
Message-ID: <1281485357-20791-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:45250 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756157Ab0HKAJT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Aug 2010 20:09:19 -0400
Received: by pwj7 with SMTP id 7so1960878pwj.19
        for <linux-omap@vger.kernel.org>; Tue, 10 Aug 2010 17:09:19 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This series introduces a layer to manage Operating Performance Points (OPPs)
for OMAP SoCs.

Special thanks to Nishanth for doing the bulk of the grunt work for
this series and to Thara for doing significant review, testing and
updates.

Kevin Hilman (1):
  omap3: pm: remove OPP interfaces from OMAP PM layer

Nishanth Menon (1):
  OMAP: introduce OPP layer for device-specific OPPs

Paul Walmsley (1):
  omap: opp: twl/tps: Introduce TWL/TPS-specific code

Thara Gopinath (1):
  OMAP: Remove dependency of generic opp layer on cpufreq.

 Documentation/arm/OMAP/omap_pm                |   93 +++++
 arch/arm/mach-omap2/io.c                      |    3 +-
 arch/arm/plat-omap/Makefile                   |    8 +-
 arch/arm/plat-omap/include/plat/omap-pm.h     |   31 +-
 arch/arm/plat-omap/include/plat/opp.h         |  160 ++++++++
 arch/arm/plat-omap/include/plat/opp_twl_tps.h |   21 +
 arch/arm/plat-omap/omap-pm-noop.c             |   11 +-
 arch/arm/plat-omap/opp.c                      |  513 +++++++++++++++++++++++++
 arch/arm/plat-omap/opp_twl_tps.c              |   41 ++
 9 files changed, 847 insertions(+), 34 deletions(-)
 create mode 100644 arch/arm/plat-omap/include/plat/opp.h
 create mode 100644 arch/arm/plat-omap/include/plat/opp_twl_tps.h
 create mode 100644 arch/arm/plat-omap/opp.c
 create mode 100644 arch/arm/plat-omap/opp_twl_tps.c

-- 
1.7.2.1

