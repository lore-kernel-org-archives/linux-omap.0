From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 0/2] OMAP3: introduce DPLL4 Jtype
Date: Tue, 20 Oct 2009 05:48:56 -0500
Message-ID: <1256035738-17571-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45893 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751802AbZJTKs5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Oct 2009 06:48:57 -0400
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n9KAn2T1005156
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 20 Oct 2009 05:49:02 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Nishanth Menon <nm@ti.com>

The patchset introduces jtype DPLLs which as a first stage
introduces it for 3630. 3430 has a previous version of DPLL
and process changes in 3630 neccessitates this for DPLL4

Patchset has been created for linux-omap - tmlind tree

Nishanth Menon (1):
  OMAP3: move check_revision above check_features

Richard Woodruff (1):
  OMAP3:clk - introduce DPLL4 jtype support

 arch/arm/mach-omap2/clock34xx.c         |   45 ++++++++++++++++++++++++++++++-
 arch/arm/mach-omap2/cm-regbits-34xx.h   |    6 +++-
 arch/arm/mach-omap2/id.c                |    5 +++-
 arch/arm/plat-omap/include/plat/clock.h |    3 ++
 arch/arm/plat-omap/include/plat/cpu.h   |    2 +
 5 files changed, 58 insertions(+), 3 deletions(-)

Regards,
Nishanth Menon
