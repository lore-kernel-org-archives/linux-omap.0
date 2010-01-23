From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 0/5] DSPBRIDGE: centralized services initialization
Date: Fri, 22 Jan 2010 21:33:19 -0600
Message-ID: <1264217604-8021-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49996 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753662Ab0AWDXA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 Jan 2010 22:23:00 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

It is more logic to initialize services related modules inside
services layer, even if we are planning to remove it.

This set should be applied after Andy's List patches.

Omar Ramirez Luna (5):
  DSPBRIDGE: Avoid multiple calls to SERVICES_[Init|Exit]
  DSPBRIDGE: remove crefs for SERVICES[Init|Exit]
  DSPBRIDGE: Remove multiple initializations of MEM module
  DSPBRIDGE: Remove multiple initializations of REG module
  DSPBRIDGE: Remove multiple initializations of NTFY module

 drivers/dsp/bridge/gen/gs.c            |    8 +--
 drivers/dsp/bridge/pmgr/dbll.c         |   15 +-----
 drivers/dsp/bridge/pmgr/wcd.c          |   17 +-----
 drivers/dsp/bridge/rmgr/dbdcd.c        |   14 +-----
 drivers/dsp/bridge/rmgr/rmm.c          |   17 +-----
 drivers/dsp/bridge/services/mem.c      |   36 ++----------
 drivers/dsp/bridge/services/services.c |   92 +++++++++++++-------------------
 7 files changed, 53 insertions(+), 146 deletions(-)

