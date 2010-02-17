From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: [PATCH 0/2] DSPBRIDGE: fix and cleanup of stream resource cleanup
Date: Tue, 16 Feb 2010 18:38:20 -0600
Message-ID: <496565EC904933469F292DDA3F1663E602CA2B9604@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43686 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933615Ab0BQAiY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Feb 2010 19:38:24 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>

>From 6ed51fea16df51e88a25bda2b9908f0a43b86303 Mon Sep 17 00:00:00 2001
From: Fernando Guzman Lugo <x0095840@ti.com>
Date: Tue, 16 Feb 2010 18:35:58 -0600
Subject: [PATCH 0/2] DSPBRIDGE: fix and cleanup of stream resource cleanup

This patch fixes an issue when there are still pending buffers for a
stream at cleanup time, and it also cleanups DRV_RemoveAllSTRMResElements
function.

Fernando Guzman Lugo (2):
  DSPBRIDGE: cleanup patch for DRV_RemoveAllSTRMResElements function
  DSPBRIDGE: Reclaim all pending buffer on resource cleanup

 drivers/dsp/bridge/rmgr/drv.c |   72 ++++++++++++++--------------------------
 1 files changed, 25 insertions(+), 47 deletions(-)

