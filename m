From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 0/7] Resource cleanup changes
Date: Wed, 16 Dec 2009 21:45:51 -0600
Message-ID: <1261021558-19036-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33140 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933401AbZLQDil (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Dec 2009 22:38:41 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Fernando Guzman <x0095840@ti.com>, Ernesto Ramos <ernesto@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

This patch series contains the changes to migrate to the
new resource implementation proposed by Ameya.

It is meant to apply after v2 of "first set of unreviewed patches"

Ameya Palande (3):
  DSPBRIDGE: Pass filp->private to all the ioctl wrappers
  DSPBRIDGE: Define pr_ctxt as a parameter in low level functions
  DSPBRIDGE: Remove old resource cleanup implementation

Ernesto Ramos Falcon (1):
  DSPBRIDGE: Delete list implementation for resource cleanup

Fernando Guzman Lugo (1):
  DSPBRIDGE: Remove process context list

Omar Ramirez Luna (2):
  DSPBRIDGE: less indentation for bridge_open and bridge_release
  DSPBRIDGE: Move PROC object abstraction to proc.c

 arch/arm/plat-omap/include/dspbridge/_dcd.h        |  135 ++++---
 arch/arm/plat-omap/include/dspbridge/drv.h         |    9 +-
 arch/arm/plat-omap/include/dspbridge/node.h        |    7 +-
 arch/arm/plat-omap/include/dspbridge/proc.h        |   14 +-
 .../plat-omap/include/dspbridge/resourcecleanup.h  |    9 +-
 arch/arm/plat-omap/include/dspbridge/strm.h        |   13 +-
 drivers/dsp/bridge/pmgr/wcd.c                      |  143 +++---
 drivers/dsp/bridge/rmgr/drv.c                      |  467 +-------------------
 drivers/dsp/bridge/rmgr/drv_interface.c            |   71 ++--
 drivers/dsp/bridge/rmgr/node.c                     |   88 +---
 drivers/dsp/bridge/rmgr/proc.c                     |  201 ++-------
 drivers/dsp/bridge/rmgr/strm.c                     |  118 ++----
 12 files changed, 306 insertions(+), 969 deletions(-)

