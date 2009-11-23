From: Anuj Aggarwal <anuj.aggarwal@ti.com>
Subject: [PATCH 0/4] AM3517: MMC: Add support for HSMMC
Date: Mon, 23 Nov 2009 23:54:57 +0530
Message-ID: <1259000697-32175-1-git-send-email-anuj.aggarwal@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52120 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752241AbZKWSY4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Nov 2009 13:24:56 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id nANIP0E3012986
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 23 Nov 2009 12:25:02 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Anuj Aggarwal <anuj.aggarwal@ti.com>

This patch series adds support for HSMMC for AM3517 platform.
It also enables the HSMMC driver in the AM3517 defconfig.

Anuj Aggarwal (4):
  AM3517: MMC: Add low-level init code for HSMMC controller
  AM3517: MMC: Modifying board-evm file to add mmc_init
  AM3517: MMC: Modifying Makefile to enable MMC init
  AM3517: MMC: Make HSMMC driver built-in

 arch/arm/configs/am3517_evm_defconfig |   21 +++-
 arch/arm/mach-omap2/Makefile          |    3 +-
 arch/arm/mach-omap2/board-am3517evm.c |   22 +++
 arch/arm/mach-omap2/mmc-am3517evm.c   |  267 +++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/mmc-am3517evm.h   |   22 +++
 5 files changed, 333 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/mach-omap2/mmc-am3517evm.c
 create mode 100644 arch/arm/mach-omap2/mmc-am3517evm.h

