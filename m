From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [pm-wip/uart][PATCH 0/6]: Serial HWMOD updation and cleanup.
Date: Thu, 20 May 2010 19:07:50 +0530 (IST)
Message-ID: <47398.192.168.10.88.1274362670.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39857 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753220Ab0ETNhw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 20 May 2010 09:37:52 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>

Patch series is based on remotes/origin/pm-wip/govindraj
branch from Kevin's PM tree.

Patches are tested with 3430SDP.
Have updated 2420/2430 hwmod data files
it would be great if some one can test the same.

Govindraj.R (6):
  Serial: Clean up set_uart_globals.
  Serial: Add UART4 hwmod data.
  Serial: Modify OMAP3 hwmod data file with uart data.
  Serial: Add UART hwmod data for 2420.
  Serial: Add UART hwmod data for 2430.
  Serial: Update UART HWMOD layer.

 arch/arm/mach-omap2/omap_hwmod_2420_data.c |  184 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |  184 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   66 +++++++++-
 arch/arm/mach-omap2/prcm-common.h          |    2 +
 arch/arm/mach-omap2/serial.c               |   38 +++----
 arch/arm/plat-omap/common.c                |   17 ---
 arch/arm/plat-omap/include/plat/common.h   |    1 -
 arch/arm/plat-omap/include/plat/dma.h      |    2 +
 arch/arm/plat-omap/include/plat/irqs.h     |    2 +
 9 files changed, 449 insertions(+), 47 deletions(-)


