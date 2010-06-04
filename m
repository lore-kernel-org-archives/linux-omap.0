From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [pm-wip/uart][PATCH 0/4] Serial HWMOD updation and uart4 support
     for 3630
Date: Fri, 4 Jun 2010 19:13:13 +0530 (IST)
Message-ID: <52880.192.168.10.88.1275658993.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40520 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755981Ab0FDNnS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Jun 2010 09:43:18 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>

Patch series is based on remotes/origin/pm-wip/uart
branch from Kevin's PM tree.

1.) Add support for UART4 for 3630.
2.) Modify Serial hwmod to avoid hwmod lookup using name string.


Govindraj.R (4):
  OMAP3: PRCM: Consider UART4 for 3630 chip in prcm_setup_regs
  OMAP3: serial: Fix uart4 handling for 3630
  Serial: Avoid using hwmod lookup using name string.
  OMAP3: PM: Add prepare idle and resume idle call for uart4

 arch/arm/mach-omap2/cm-regbits-34xx.h  |    2 +
 arch/arm/mach-omap2/pm34xx.c           |   17 +++++-
 arch/arm/mach-omap2/prcm-common.h      |    2 +
 arch/arm/mach-omap2/prm-regbits-34xx.h |    1 +
 arch/arm/mach-omap2/serial.c           |  106 +++++++++++++++++++------------
 5 files changed, 85 insertions(+), 43 deletions(-)



