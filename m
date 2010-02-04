From: Ameya Palande <ameya.palande@nokia.com>
Subject: [PATCHv2 0/3] DSPBRIDGE: MEM Module cleanup series
Date: Thu,  4 Feb 2010 17:33:11 +0200
Message-ID: <cover.1265296743.git.ameya.palande@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:30392 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932278Ab0BDPdo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Feb 2010 10:33:44 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: omar.ramirez@ti.com, nm@ti.com, deepak.chitriki@ti.com

This series contains patches which remove following things from the MEM
module:
1. MEM_CHECK memory leak debugging mechanism
2. MEM_Free() function
3. MEM_VFree() function

There was some issue while applying patches from V1, which should be solved in
V2.

Ameya Palande (3):
  DSPBRIDGE: Get rid of MEM_CHECK mechanism
  DSPBRIDGE: Get rid of MEM_Free()
  DSPBRIDGE: Get rid of MEM_VFree()

 arch/arm/plat-omap/include/dspbridge/mem.h |   36 +----
 drivers/dsp/bridge/gen/gs.c                |    4 +-
 drivers/dsp/bridge/pmgr/cmm.c              |   12 +-
 drivers/dsp/bridge/pmgr/cod.c              |    4 +-
 drivers/dsp/bridge/pmgr/dbll.c             |   15 +-
 drivers/dsp/bridge/pmgr/dev.c              |    9 +-
 drivers/dsp/bridge/pmgr/dmm.c              |    3 +-
 drivers/dsp/bridge/pmgr/wcd.c              |   46 ++---
 drivers/dsp/bridge/rmgr/dbdcd.c            |   13 +-
 drivers/dsp/bridge/rmgr/disp.c             |    3 +-
 drivers/dsp/bridge/rmgr/drv.c              |   38 ++---
 drivers/dsp/bridge/rmgr/drv_interface.c    |    2 +-
 drivers/dsp/bridge/rmgr/nldr.c             |   52 ++----
 drivers/dsp/bridge/rmgr/node.c             |   87 ++++-------
 drivers/dsp/bridge/rmgr/proc.c             |   10 +-
 drivers/dsp/bridge/rmgr/rmm.c              |   19 +-
 drivers/dsp/bridge/rmgr/strm.c             |    3 +-
 drivers/dsp/bridge/services/mem.c          |  246 +---------------------------
 drivers/dsp/bridge/services/ntfy.c         |    7 +-
 drivers/dsp/bridge/services/regsup.c       |   10 +-
 drivers/dsp/bridge/services/sync.c         |    3 +-
 drivers/dsp/bridge/wmd/chnl_sm.c           |   11 +-
 drivers/dsp/bridge/wmd/io_sm.c             |   12 +-
 drivers/dsp/bridge/wmd/msg_sm.c            |    8 +-
 drivers/dsp/bridge/wmd/tiomap3430.c        |   17 +--
 drivers/dsp/bridge/wmd/ue_deh.c            |    6 +-
 26 files changed, 160 insertions(+), 516 deletions(-)

