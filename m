From: Ranjith Lohithakshan <ranjithl@ti.com>
Subject: [PATCH 0/2] Introduce AM3517 EVM board support
Date: Wed, 28 Oct 2009 19:43:43 +0530
Message-ID: <1256739223-8059-1-git-send-email-ranjithl@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56082 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751707AbZJ1ONn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Oct 2009 10:13:43 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n9SEDjB6017854
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 28 Oct 2009 09:13:47 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: ranjithl@ti.com

The patch series adds minimal support for AM3517 EVM board. Only serial 
driver is supported now. More functionalities will follow up in subsequent 
patches.

The latest version of (http://marc.info/?l=linux-omap&m=125665214630267&w=2) 
along with this patch set  will let AM35xx EVM boot.
 
The patches are generated against tip of for-next branch.

Ranjith Lohithakshan (2):
  AM35xx: Add support for AM3517 EVM board
  AM35xx: Defconfig for AM3517 EVM board

 arch/arm/configs/am3517_evm_defconfig | 1058 +++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/Makefile          |    2 +
 arch/arm/mach-omap2/board-am3517evm.c |   73 +++
 3 files changed, 1133 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/configs/am3517_evm_defconfig
 create mode 100644 arch/arm/mach-omap2/board-am3517evm.c

