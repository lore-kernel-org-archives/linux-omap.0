From: Steve Sakoman <steve@sakoman.com>
Subject: [PATCH 0/2] Add DSS2 support on Overo
Date: Thu,  3 Mar 2011 15:46:18 -0800
Message-ID: <1299195980-17057-1-git-send-email-steve@sakoman.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:58376 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758886Ab1CCXqf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Mar 2011 18:46:35 -0500
Received: by ewy6 with SMTP id 6so540285ewy.19
        for <linux-omap@vger.kernel.org>; Thu, 03 Mar 2011 15:46:34 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tomi.valkeinen@ti.com, Steve Sakoman <steve@sakoman.com>

This patch series adds support for the set of display devices available
for the Overo COM products: DVI, S-Video, the Samsung LTE430WQ-F0C LCD
panel, and the LG.Philips LB035Q02 panel.

Tested with applicable expansion boards for each option: Tobi, Palo43,
Chestnut43, and Palo35.

Steve Sakoman (2):
  OMAP: DSS2: Add support for LG Philips LB035Q02 panel
  OMAP: DSS2: Add DSS2 support for Overo

 arch/arm/mach-omap2/board-overo.c                  |  239 +++++++++++++++++---
 drivers/video/omap2/displays/Kconfig               |    6 +
 drivers/video/omap2/displays/Makefile              |    1 +
 .../omap2/displays/panel-lgphilips-lb035q02.c      |  236 +++++++++++++++++++
 4 files changed, 445 insertions(+), 37 deletions(-)
 create mode 100644 drivers/video/omap2/displays/panel-lgphilips-lb035q02.c

