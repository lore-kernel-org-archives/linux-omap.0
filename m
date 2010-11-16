From: Nishanth Menon <nm@ti.com>
Subject: [PATCH v4 0/3] OMAP: Add opp data
Date: Tue, 16 Nov 2010 12:54:18 -0600
Message-ID: <1289933661-19505-1-git-send-email-nm@ti.com>
References: <[PATCH v3 1/3] omap: opp: add OMAP3 OPP table data and common init>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33556 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755798Ab0KPSy0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Nov 2010 13:54:26 -0500
In-Reply-To: <[PATCH v3 1/3] omap: opp: add OMAP3 OPP table data and common init>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Tony <tony@atomide.com>, Kevin <khilman@deeprootsystems.com>, Thomas <thomas.petazzoni@free-electrons.com>

Major changes in V4:
	Rename of oppxxx_data.h to data.c, move device_init there
	omap_init_opp_table now will return -EEXIST if
	it was called previously.

V3: http://marc.info/?l=linux-omap&m=128984926812800&w=2
V2: http://marc.info/?t=128753665300003&r=1&w=2

Kevin Hilman (1):
  OMAP3: remove OPP interfaces from OMAP PM layer

Nishanth Menon (2):
  omap: opp: add OMAP3 OPP table data and common init
  omap4: opp: add OPP table data

 Documentation/arm/OMAP/omap_pm            |   26 ++++++
 arch/arm/mach-omap2/Kconfig               |    2 +
 arch/arm/mach-omap2/Makefile              |    2 +
 arch/arm/mach-omap2/io.c                  |    3 +-
 arch/arm/mach-omap2/opp.c                 |  135 +++++++++++++++++++++++++++++
 arch/arm/mach-omap2/opp3xxx_data.c        |   98 +++++++++++++++++++++
 arch/arm/mach-omap2/opp4xxx_data.c        |   49 +++++++++++
 arch/arm/mach-omap2/pm.h                  |   14 +++
 arch/arm/plat-omap/include/plat/omap-pm.h |   31 ++-----
 arch/arm/plat-omap/omap-pm-noop.c         |   11 +--
 10 files changed, 338 insertions(+), 33 deletions(-)
 create mode 100644 arch/arm/mach-omap2/opp.c
 create mode 100644 arch/arm/mach-omap2/opp3xxx_data.c
 create mode 100644 arch/arm/mach-omap2/opp4xxx_data.c

 Regards,
 Nishanth Menon
