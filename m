From: Mike Rapoport <mike@compulab.co.il>
Subject: [PATCH 0/2 v2] ARM: OMAP3: add support for cm-t35 board
Date: Wed, 14 Oct 2009 09:48:54 +0200
Message-ID: <cover.1255505874.git.mike@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:32841 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751269AbZJNHte (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Oct 2009 03:49:34 -0400
Received: from mail.linux-boards.com ([192.114.83.142] helo=zimbra-mta.compulab.co.il)
	by compulab.site5.com with esmtp (Exim 4.69)
	(envelope-from <mike@compulab.co.il>)
	id 1MxybS-0002hf-1E
	for linux-omap@vger.kernel.org; Wed, 14 Oct 2009 02:48:58 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Mike Rapoport <mike@compulab.co.il>

The following patches add support for CompuLab CM-T35 board.
--
v2 changes:
 remove EHCI-related code
 move usb_musb_init to cm_t35_init
--

Changes since commit 2caa731819a633bec5a56736e64c562b7e193666:
  Linus Torvalds (1):
          Merge branch 'for-linus' of git://git.kernel.org/.../jbarnes/pci-2.6

Mike Rapoport (2):
  ARM: OMAP3: add CompuLab CM-T35 module
  ARM: OMAP3: cm-t35: add defconfig

 arch/arm/configs/cm_t35_defconfig  | 1733 ++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/Kconfig        |    4 +
 arch/arm/mach-omap2/Makefile       |    2 +
 arch/arm/mach-omap2/board-cm-t35.c |  459 ++++++++++
 4 files changed, 2198 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/configs/cm_t35_defconfig
 create mode 100644 arch/arm/mach-omap2/board-cm-t35.c

