From: Mike Rapoport <mike@compulab.co.il>
Subject: [PATCH 0/2] ARM: OMAP3: add support for cm-t35 board
Date: Tue, 13 Oct 2009 18:16:09 +0200
Message-ID: <cover.1255449748.git.mike@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:56124 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760154AbZJMQQv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Oct 2009 12:16:51 -0400
Received: from [62.90.235.247] (helo=zimbra-mta.compulab.co.il)
	by compulab.site5.com with esmtp (Exim 4.69)
	(envelope-from <mike@compulab.co.il>)
	id 1Mxk2p-0007UB-3q
	for linux-omap@vger.kernel.org; Tue, 13 Oct 2009 11:16:15 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Mike Rapoport <mike@compulab.co.il>

The following patches add support for CompuLab CM-T35 board.

Mike Rapoport (2):
  ARM: OMAP3: add CompuLab CM-T35 module
  ARM: OMAP3: cm-t35: add defconfig

 arch/arm/configs/cm_t35_defconfig  | 1733 ++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/Kconfig        |    4 +
 arch/arm/mach-omap2/Makefile       |    2 +
 arch/arm/mach-omap2/board-cm-t35.c |  476 ++++++++++
 4 files changed, 2215 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/configs/cm_t35_defconfig
 create mode 100644 arch/arm/mach-omap2/board-cm-t35.c

