From: Steve Sakoman <steve@sakoman.com>
Subject: [PATCH v2 0/2] Add DSS2 support on Overo
Date: Fri,  4 Mar 2011 12:52:18 -0800
Message-ID: <1299271940-4286-1-git-send-email-steve@sakoman.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:64000 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932446Ab1CDUxZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Mar 2011 15:53:25 -0500
Received: by fxm17 with SMTP id 17so2558837fxm.19
        for <linux-omap@vger.kernel.org>; Fri, 04 Mar 2011 12:53:24 -0800 (PST)
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

Steve Sakoman (2):
  OMAP: DSS2: Add support for LG Philips LB035Q02 panel
  OMAP: DSS2: Add DSS2 support for Overo

 arch/arm/mach-omap2/board-overo.c                  |  239 ++++++++++++++---
 drivers/video/omap2/displays/Kconfig               |    6 +
 drivers/video/omap2/displays/Makefile              |    1 +
 .../omap2/displays/panel-lgphilips-lb035q02.c      |  278 ++++++++++++++++++++
 4 files changed, 487 insertions(+), 37 deletions(-)
 create mode 100644 drivers/video/omap2/displays/panel-lgphilips-lb035q02.c

