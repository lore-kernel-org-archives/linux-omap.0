From: Steve Sakoman <steve@sakoman.com>
Subject: [PATCH v3 0/2] Add DSS2 support on Overo
Date: Sat,  5 Mar 2011 05:58:37 -0800
Message-ID: <1299333519-11467-1-git-send-email-steve@sakoman.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gw0-f51.google.com ([74.125.83.51]:59717 "EHLO
	mail-gw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750982Ab1CEN6s (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 5 Mar 2011 08:58:48 -0500
Received: by gwb15 with SMTP id 15so1662600gwb.10
        for <linux-omap@vger.kernel.org>; Sat, 05 Mar 2011 05:58:48 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tomi.valkeinen@ti.com, Steve Sakoman <steve@sakoman.com>

This patch series adds support for the set of display devices available
for the Overo COM products: DVI, S-Video, the Samsung LTE430WQ-F0C LCD
panel, and the LG.Philips LB035Q02 panel.

Tested with applicable expansion boards for each option: Tobi, Palo43,
Chestnut43, and Palo35.

Changes from version 1: adds mutex locking to the lgphilips-lb035q02
panel enable/disable and suspend/resume functions.

Changes from version 2: add missing semicolon to lb035q02_data definition

Steve Sakoman (2):
  OMAP: DSS2: Add support for LG Philips LB035Q02 panel
  OMAP: DSS2: Add DSS2 support for Overo

 arch/arm/mach-omap2/board-overo.c                  |  239 ++++++++++++++---
 drivers/video/omap2/displays/Kconfig               |    6 +
 drivers/video/omap2/displays/Makefile              |    1 +
 .../omap2/displays/panel-lgphilips-lb035q02.c      |  279 ++++++++++++++++++++
 4 files changed, 488 insertions(+), 37 deletions(-)
 create mode 100644 drivers/video/omap2/displays/panel-lgphilips-lb035q02.c

