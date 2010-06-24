From: Nishanth Menon <nm@ti.com>
Subject: [PM-SR][PATCH 0/4] Janitor series: kill sparse warnings
Date: Thu, 24 Jun 2010 16:29:22 -0500
Message-ID: <1277414966-31806-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48900 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755342Ab0FXV3b (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Jun 2010 17:29:31 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Thara Gopinath <thara@ti.com>

This series removes few of the sparse warnings I found. This series
probably should be squashed with other patches in pm-sr branch

Nishanth Menon (4):
  omap: sr: export sr_dbg_dir
  omap3: sr: sr_exit should be static
  omap3: voltage: make required variables static
  omap3: voltage: expose omap_change_voltscale_method

 arch/arm/mach-omap2/smartreflex.c             |    2 +-
 arch/arm/mach-omap2/voltage.c                 |    6 +++---
 arch/arm/mach-omap2/voltage.h                 |    1 +
 arch/arm/plat-omap/include/plat/smartreflex.h |    5 +++++
 4 files changed, 10 insertions(+), 4 deletions(-)

Regards,
Nishanth Menon

Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Thara Gopinath <thara@ti.com>
