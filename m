From: Mike Rapoport <mike@compulab.co.il>
Subject: [PATCH 0/2] omap3: cm-t35: enable display subsystem
Date: Mon, 14 Dec 2009 10:01:06 +0200
Message-ID: <cover.1260777313.git.mike@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:42002 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754872AbZLNIB0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 Dec 2009 03:01:26 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com
Cc: linux-omap@vger.kernel.org, Mike Rapoport <mike@compulab.co.il>

The below patches add display support for CM-T35 board.

The following changes since commit f40542532e96dda5506eb76badea322f2ae4731c:
  Linus Torvalds (1):
        Merge branch 'ixp4xx' of git://git.kernel.org/.../chris/linux-2.6

Mike Rapoport (2):
  OMAP: DSS2: add Toppoly TDO35S panel
  omap3: cm-t35: add DSS2 display support

 arch/arm/mach-omap2/board-cm-t35.c                 |  239 +++++++++++++++++++-
 drivers/video/omap2/displays/Kconfig               |    6 +
 drivers/video/omap2/displays/Makefile              |    1 +
 .../video/omap2/displays/panel-toppoly-tdo35s.c    |  112 +++++++++
 4 files changed, 357 insertions(+), 1 deletions(-)
 create mode 100644 drivers/video/omap2/displays/panel-toppoly-tdo35s.c

