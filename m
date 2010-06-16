From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [pm-wip/uart][PATCH 0/5 v2] Serial HWMOD updation and uart4
     support for 3630
Date: Wed, 16 Jun 2010 19:43:38 +0530 (IST)
Message-ID: <2134.10.24.255.18.1276697618.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43685 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754271Ab0FPONk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Jun 2010 10:13:40 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>

Changes from v1:
* Incorporated : OMAP clock: Add uart4_ick/fck definitions for 3630
* using omap_mux_request_signal to retreive padconf offset
  as per Tony's comments.
  http://marc.info/?l=linux-omap&m=127609369220618&w=2
  This patch series as a dependecy on the patch
  for "omap_mux_request_signal" posted earlier
  https://patchwork.kernel.org/patch/105962/
* Clean up certain comments.
  http://www.mail-archive.com/linux-omap@vger.kernel.org/msg30348.html

Patch series is based on remotes/origin/pm-wip/uart
branch from Kevin's PM tree.

1.) Add support for UART4 for 3630.
2.) Modify Serial hwmod to avoid hwmod lookup using name string.

Govindraj.R (5):
  OMAP clock: Add uart4_ick/fck definitions for 3630
  OMAP3: PRCM: Consider UART4 for 3630 chip in prcm_setup_regs
  OMAP3: serial: Fix uart4 handling for 3630
  OMAP3: PM: Add prepare idle and resume idle call for uart4
  Serial: Avoid using hwmod lookup using name string.

 arch/arm/mach-omap2/clock3xxx_data.c   |   22 ++++++
 arch/arm/mach-omap2/cm-regbits-34xx.h  |    2 +
 arch/arm/mach-omap2/pm34xx.c           |   17 ++++-
 arch/arm/mach-omap2/prcm-common.h      |    2 +
 arch/arm/mach-omap2/prm-regbits-34xx.h |    1 +
 arch/arm/mach-omap2/serial.c           |  114 +++++++++++++++++++-------------
 6 files changed, 111 insertions(+), 47 deletions(-)




