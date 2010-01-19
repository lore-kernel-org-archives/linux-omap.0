From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 0/3] DSPBRIDGE: Return right error codes
Date: Tue, 19 Jan 2010 12:15:08 -0600
Message-ID: <1263924911-7404-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53755 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754993Ab0ASSFM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Jan 2010 13:05:12 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

This set of patches fixes the overwritten or missing error codes
returned from different bridge layers.

Fernando Guzman Lugo (3):
  DSPBRIDGE: return right error codes wmd directory
  DSPBRIDGE: return right error codes services directory
  DSPBRIDGE: return right error codes rmgr directory

 drivers/dsp/bridge/rmgr/dbdcd.c         |   31 ++--
 drivers/dsp/bridge/rmgr/disp.c          |   36 ++--
 drivers/dsp/bridge/rmgr/drv.c           |   89 +++++----
 drivers/dsp/bridge/rmgr/dspdrv.c        |   27 ++--
 drivers/dsp/bridge/rmgr/mgr.c           |   23 +--
 drivers/dsp/bridge/rmgr/nldr.c          |   32 +--
 drivers/dsp/bridge/rmgr/node.c          |  123 ++++++------
 drivers/dsp/bridge/rmgr/proc.c          |  100 ++++------
 drivers/dsp/bridge/rmgr/strm.c          |   31 +--
 drivers/dsp/bridge/services/cfg.c       |    8 +-
 drivers/dsp/bridge/services/clk.c       |    7 +-
 drivers/dsp/bridge/services/reg.c       |   25 +--
 drivers/dsp/bridge/services/sync.c      |    1 -
 drivers/dsp/bridge/wmd/chnl_sm.c        |  230 +++++++++++------------
 drivers/dsp/bridge/wmd/io_sm.c          |  322 ++++++++++++++-----------------
 drivers/dsp/bridge/wmd/mmu_fault.c      |    4 +-
 drivers/dsp/bridge/wmd/msg_sm.c         |   47 +++--
 drivers/dsp/bridge/wmd/tiomap3430.c     |   28 +--
 drivers/dsp/bridge/wmd/tiomap3430_pwr.c |   10 +-
 drivers/dsp/bridge/wmd/tiomap_io.c      |   10 +-
 drivers/dsp/bridge/wmd/tiomap_sm.c      |    2 -
 drivers/dsp/bridge/wmd/ue_deh.c         |   21 +--
 22 files changed, 542 insertions(+), 665 deletions(-)

