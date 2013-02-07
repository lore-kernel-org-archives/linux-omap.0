From: Ruslan Bilovol <ruslan.bilovol@ti.com>
Subject: [PATCH 0/1] OMAP4: DSS: Add panel for Blaze Tablet boards
Date: Thu,  7 Feb 2013 16:40:49 +0200
Message-ID: <1360248051-16541-1-git-send-email-ruslan.bilovol@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tomi.valkeinen@ti.com, FlorianSchandinat@gmx.de, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

This patch adds support for TC358765 DSI-to-LVDS transmitter
from Toshiba, that is used in OMAP4 Blaze Tablet development
platform. It was originally developed a long time ago and
was used internally survived few kernel migrations.
Different people worked in this driver during last two
years changing its sources to what each new version of
kernel expects.

Current version is ported from internal kernel v3.4 to 3.8.0-rc6
Tested basic functioning under busybox.

-
Ruslan

Tomi Valkeinen (1):
  OMAP4: DSS: Add panel for Blaze Tablet boards

 drivers/video/omap2/displays/Kconfig          |   15 +
 drivers/video/omap2/displays/Makefile         |    1 +
 drivers/video/omap2/displays/panel-tc358765.c | 1001 +++++++++++++++++++++++++
 drivers/video/omap2/displays/panel-tc358765.h |  170 +++++
 include/video/omap-panel-tc358765.h           |   53 ++
 5 files changed, 1240 insertions(+)
 create mode 100644 drivers/video/omap2/displays/panel-tc358765.c
 create mode 100644 drivers/video/omap2/displays/panel-tc358765.h
 create mode 100644 include/video/omap-panel-tc358765.h

-- 
1.7.9.5
