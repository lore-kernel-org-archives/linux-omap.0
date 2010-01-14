From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 0/3] Interface tightening patches
Date: Wed, 13 Jan 2010 19:11:13 -0600
Message-ID: <1263431476-19206-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38133 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752305Ab0ANBUU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jan 2010 20:20:20 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Nishanth Menon <nm@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Fernando Guzman Lugo <x0095840@ti.com>

Set of patches containing ioctl interface checks, null pointers
checks and imporvement on resource handling on error.

Ernesto Ramos (3):
  DSPBRIDGE: Interface tightening to check for invalid input
    parameters
  DSPBRIDGE: Undo allocation of resources in case of cp_to_usr fails
  DSPBRIDGE: NULL Pointer Dereference fix

 arch/arm/plat-omap/include/dspbridge/dbdefs.h |    4 +-
 drivers/dsp/bridge/pmgr/wcd.c                 |  126 ++++++++++++++++++++-----
 drivers/dsp/bridge/rmgr/nldr.c                |    3 +-
 drivers/dsp/bridge/rmgr/node.c                |    6 +-
 drivers/dsp/bridge/rmgr/proc.c                |    9 +-
 drivers/dsp/bridge/services/mem.c             |    4 -
 drivers/dsp/bridge/wmd/chnl_sm.c              |    2 +-
 7 files changed, 113 insertions(+), 41 deletions(-)

CC: Nishanth Menon <nm@ti.com>
CC: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>
CC: Ameya Palande <ameya.palande@nokia.com>
CC: Fernando Guzman Lugo <x0095840@ti.com>
