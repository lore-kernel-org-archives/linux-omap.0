From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 0/2] dspbridge: 2.6.33 migration patches
Date: Thu, 18 Mar 2010 15:57:07 -0600
Message-ID: <1268949429-30368-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57167 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752374Ab0CRVmN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Mar 2010 17:42:13 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@gmail.com>, Ameya Palande <ameya.palande@nokia.com>, Guzman Lugo Fernando <x0095840@ti.com>, Hari Kanigeri <h-kanigeri2@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

These patches are required for the next rebase to 2.6.33 kernel.

They fix a warning and header locations for files moved from mach
to plat.

Omar Ramirez Luna (2):
  DSPBRIDGE: Remove autoconf.h dependency from host_os header
  DSPBRIDGE: Fix header locations mach to plat

 arch/arm/mach-omap2/dspbridge.c                |    2 +-
 arch/arm/plat-omap/include/dspbridge/host_os.h |    3 +--
 drivers/dsp/bridge/wmd/tiomap3430.c            |    2 +-
 3 files changed, 3 insertions(+), 4 deletions(-)

