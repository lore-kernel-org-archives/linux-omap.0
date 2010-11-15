From: Nishanth Menon <nm@ti.com>
Subject: [PATCH v3 0/3] OMAP: Add opp data
Date: Mon, 15 Nov 2010 13:27:38 -0600
Message-ID: <1289849261-29767-1-git-send-email-nm@ti.com>
References: <[PATCH 0/3 v2] omap: opp: Add opp data>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54326 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757919Ab0KOT1o (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 15 Nov 2010 14:27:44 -0500
In-Reply-To: <[PATCH 0/3 v2] omap: opp: Add opp data>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Tony <tony@atomide.com>

Series version 3 incorporating changes for the comments
for using device_initcall to initialize the opp layer

patches based on kernel.org 2.6.37-rc1

V2: http://marc.info/?t=128753665300003&r=1&w=2

Kevin Hilman (1):
  OMAP3: remove OPP interfaces from OMAP PM layer

Nishanth Menon (2):
  omap: opp: add OMAP3 OPP table data and common init
  omap4: opp: add OPP table data

 Documentation/arm/OMAP/omap_pm            |   26 +++++
 arch/arm/mach-omap2/Kconfig               |    2 +
 arch/arm/mach-omap2/Makefile              |    2 +
 arch/arm/mach-omap2/io.c                  |    3 +-
 arch/arm/mach-omap2/opp.c                 |  172 +++++++++++++++++++++++++++++
 arch/arm/mach-omap2/opp3xxx_data.h        |   82 ++++++++++++++
 arch/arm/mach-omap2/opp4xxx_data.h        |   37 ++++++
 arch/arm/mach-omap2/pm.h                  |   14 +++
 arch/arm/plat-omap/include/plat/omap-pm.h |   31 ++----
 arch/arm/plat-omap/omap-pm-noop.c         |   11 +--
 10 files changed, 347 insertions(+), 33 deletions(-)
 create mode 100644 arch/arm/mach-omap2/opp.c
 create mode 100644 arch/arm/mach-omap2/opp3xxx_data.h
 create mode 100644 arch/arm/mach-omap2/opp4xxx_data.h

 Regards,
 Nishanth Menon
