From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 0/7] omap1 sparse warning fixes
Date: Tue, 18 Jan 2011 09:52:38 +0200
Message-ID: <1295337165-22934-1-git-send-email-aaro.koskinen@iki.fi>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri1.pp.htv.fi ([213.243.153.184]:44464 "EHLO
	filtteri1.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752283Ab1ARHwf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Jan 2011 02:52:35 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Here's some trivial omap1 sparse warning fixes.

Aaro Koskinen (7):
  arm: plat-omap: dma: make omap_dma_in_1510_mode() static
  arm: mach-omap1: board-h2: make h2_nand_platdata static
  arm: mach-omap1: board-innovator: make innovator_mmc_init() static
  arm: mach-omap1: board-htcherald: make htcpld_chips and htcpld_pfdata static
  arm: mach-omap1: board-h3: make nand_platdata static
  arm: plat-omap: system.h: move voiceblue definitions into the board header
  arm: mach-omap1: board-voiceblue: add missing include

 arch/arm/mach-omap1/board-h2.c                    |    2 +-
 arch/arm/mach-omap1/board-h3.c                    |    2 +-
 arch/arm/mach-omap1/board-htcherald.c             |    4 ++--
 arch/arm/mach-omap1/board-innovator.c             |    2 +-
 arch/arm/mach-omap1/board-voiceblue.c             |    1 +
 arch/arm/plat-omap/dma.c                          |    2 +-
 arch/arm/plat-omap/include/plat/board-voiceblue.h |    6 ++++++
 arch/arm/plat-omap/include/plat/system.h          |    7 +------
 8 files changed, 14 insertions(+), 12 deletions(-)

