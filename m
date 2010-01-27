From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH v2 0/5]
Date: Tue, 26 Jan 2010 18:57:23 -0600
Message-ID: <1264553848-23555-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48516 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754117Ab0A0Aqo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Jan 2010 19:46:44 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

It is more logic to initialize services related modules inside
services layer, even if we are planning to remove it.

v2:
- Fixed crefs build issue (patch 2) if enabling debug

Omar Ramirez Luna (5):
  DSPBRIDGE: Avoid multiple calls to SERVICES_[Init|Exit]
  DSPBRIDGE: remove crefs for SERVICES[Init|Exit]
  DSPBRIDGE: Remove multiple initializations of MEM module
  DSPBRIDGE: Remove multiple initializations of REG module
  DSPBRIDGE: Remove multiple initializations of NTFY module

 drivers/dsp/bridge/gen/gs.c            |    8 +--
 drivers/dsp/bridge/pmgr/dbll.c         |   15 +----
 drivers/dsp/bridge/pmgr/wcd.c          |   17 +-----
 drivers/dsp/bridge/rmgr/dbdcd.c        |   15 +-----
 drivers/dsp/bridge/rmgr/rmm.c          |   17 +-----
 drivers/dsp/bridge/services/mem.c      |   36 ++----------
 drivers/dsp/bridge/services/services.c |  100 ++++++++++++--------------------
 7 files changed, 53 insertions(+), 155 deletions(-)

