From: Mike Rapoport <mike@compulab.co.il>
Subject: [PATCH 0/3] omap3: cm-t35: enable display subsystem
Date: Tue,  1 Dec 2009 13:22:09 +0200
Message-ID: <cover.1259666203.git.mike@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:47782 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753265AbZLAL0g (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 1 Dec 2009 06:26:36 -0500
Received: from mail.linux-boards.com ([192.114.83.142] helo=zimbra-mta.compulab.co.il)
	by compulab.site5.com with esmtp (Exim 4.69)
	(envelope-from <mike@compulab.co.il>)
	id 1NFQsV-000882-5p
	for linux-omap@vger.kernel.org; Tue, 01 Dec 2009 05:26:43 -0600
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbra-mta.compulab.co.il (Postfix) with ESMTP id 624DA9A035A
	for <linux-omap@vger.kernel.org>; Tue,  1 Dec 2009 13:26:42 +0200 (IST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Mike Rapoport <mike@compulab.co.il>

This patchset adds display support for CM-T35 board.

The following changes since commit 82f1d8f22f2c65e70206e40a6f17688bf64a892c:
  Tony Lindgren (1):
        Merge branch 'for-next' of git://gitorious.org/linux-omap-dss2/linux

Mike Rapoport (3):
  OMAP: DSS2: add Toppoly TDO35S panel
  omap3: cm-t35: add DSS2 display support
  omap3: cm-t35: update defconfig for DSS2

 arch/arm/configs/cm_t35_defconfig                  |   82 +++++++-
 arch/arm/mach-omap2/board-cm-t35.c                 |  234 +++++++++++++++++++-
 drivers/video/omap2/displays/Kconfig               |    6 +
 drivers/video/omap2/displays/Makefile              |    1 +
 .../video/omap2/displays/panel-toppoly-tdo35s.c    |  112 ++++++++++
 5 files changed, 430 insertions(+), 5 deletions(-)
 create mode 100644 drivers/video/omap2/displays/panel-toppoly-tdo35s.c

