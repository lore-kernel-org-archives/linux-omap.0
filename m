From: Mike Rapoport <mike@compulab.co.il>
Subject: [PATCH 0/2 v3] ARM: OMAP3: add support for cm-t35 board
Date: Wed, 21 Oct 2009 08:28:40 +0200
Message-ID: <cover.1256106054.git.mike@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:56290 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752023AbZJUG2k (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Oct 2009 02:28:40 -0400
Received: from [62.90.235.247] (helo=zimbra-mta.compulab.co.il)
	by compulab.site5.com with esmtp (Exim 4.69)
	(envelope-from <mike@compulab.co.il>)
	id 1N0Ugf-0006yB-3x
	for linux-omap@vger.kernel.org; Wed, 21 Oct 2009 01:28:45 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbra-mta.compulab.co.il (Postfix) with ESMTP id 2B0939A0359
	for <linux-omap@vger.kernel.org>; Wed, 21 Oct 2009 08:28:44 +0200 (IST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Mike Rapoport <mike@compulab.co.il>

The following patches add support for CompuLab CM-T35 board.
--
v3 changes:
   address Tony comments
   remove unneeded (yet) tdo24.h include
--

Changes since commit 012abeea669ea49636cf952d13298bb68654146a:
  Linus Torvalds (1):
  	  Linux 2.6.32-rc5

Mike Rapoport (2):
  ARM: OMAP3: add CompuLab CM-T35 module
  ARM: OMAP3: cm-t35: add defconfig

 arch/arm/configs/cm_t35_defconfig  | 1733 ++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/Kconfig        |    4 +
 arch/arm/mach-omap2/Makefile       |    2 +
 arch/arm/mach-omap2/board-cm-t35.c |  458 ++++++++++
 4 files changed, 2197 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/configs/cm_t35_defconfig
 create mode 100644 arch/arm/mach-omap2/board-cm-t35.c

