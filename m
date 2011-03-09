From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 0/6] OMAP: DSS2: DSI: IRQ restructuring
Date: Wed, 9 Mar 2011 09:21:22 +0200
Message-ID: <1299655288-7121-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48208 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751156Ab1CIHVk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Mar 2011 02:21:40 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Hi,

In the future we will have more features using the DSI interrupts, like ULPS
handling, and making use-case specific hooks into the main IRQ handler would
become burdensome.

This patch set cleans up the DSI IRQ handling a bit by implementing a generic
way to register/unregister interrupt service routines. This allows us to remove
the use-case specific callbacks from the main IRQ handler.

 Tomi

Tomi Valkeinen (6):
  OMAP: DSS2: DSI: Restructure IRQ handler
  OMAP: DSS2: DSI: Add ISR support
  OMAP: DSS2: DSI: use ISR in send_bta_sync
  OMAP: DSS2: DSI: use ISR for BTA in framedone
  OMAP: DSS2: DSI: catch DSI errors in send_bta_sync
  OMAP: DSS2: DSI: fix IRQ debug prints

 drivers/video/omap2/dss/dsi.c |  523 ++++++++++++++++++++++++++++++++---------
 1 files changed, 408 insertions(+), 115 deletions(-)

