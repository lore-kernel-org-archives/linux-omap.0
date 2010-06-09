From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 0/2] dspbridge: reorganize initialization and probe
Date: Tue,  8 Jun 2010 19:48:11 -0500
Message-ID: <1276044493-23003-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49462 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754926Ab0FIAz1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 Jun 2010 20:55:27 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

Split the functions to have cleaner error handling paths, this
will aslo cover a case where bridge initialization has failed but
device entry is still available which leads to unknown behavior.

Omar Ramirez Luna (2):
  DSPRBIDGE: split probe from bridge initializations
  DSPBRIDGE: reorganize probe function

 drivers/dsp/bridge/rmgr/drv_interface.c |  202 ++++++++++++++++++-------------
 1 files changed, 118 insertions(+), 84 deletions(-)

