From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: [PATCH 0/3] htcherald: Add board support for HTC Herald
Date: Sat, 3 Oct 2009 21:57:09 -0700
Message-ID: <6cb013310910032157j1e9de2c3t41d8c3699209290c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f212.google.com ([209.85.217.212]:56282 "EHLO
	mail-gx0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751201AbZJDE6G (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 4 Oct 2009 00:58:06 -0400
Received: by gxk4 with SMTP id 4so2853692gxk.8
        for <linux-omap@vger.kernel.org>; Sat, 03 Oct 2009 21:57:29 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This series of patches introduces board support for the HTC
Herald (T-Mobile Wing, etc.) series of OMAP850-based smart
phones.  The changes here are an update to my previous posting,
taking into account the comments by michael.

Cory Maccarrone (3):
  [OMAP] htcherald: Add board support and LCD for HTC Herald
  [OMAP] htcherald: Modify Makefiles and Kconfig for HTC Herald
  [OMAP] htcherald: Add default kernel configuration for Herald

 arch/arm/configs/htcherald_defconfig  | 1146 +++++++++++++++++++++++++++++++++
 arch/arm/mach-omap1/Kconfig           |    6 +
 arch/arm/mach-omap1/Makefile          |    1 +
 arch/arm/mach-omap1/board-htcherald.c |  203 ++++++
 drivers/video/omap/Makefile           |    1 +
 drivers/video/omap/lcd_htcherald.c    |  166 +++++
 6 files changed, 1523 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/configs/htcherald_defconfig
 create mode 100644 arch/arm/mach-omap1/board-htcherald.c
 create mode 100644 drivers/video/omap/lcd_htcherald.c
