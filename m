From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 0/4] i2c: omap: few more patches
Date: Mon,  6 Aug 2012 17:18:53 +0300
Message-ID: <1344262737-6662-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:51661 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756474Ab2HFOWd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Aug 2012 10:22:33 -0400
Received: by lagr15 with SMTP id r15so876180lag.7
        for <linux-omap@vger.kernel.org>; Mon, 06 Aug 2012 07:22:30 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti Datta <shubhrajyoti@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, w.sang@pengutronix.de, Felipe Balbi <balbi@ti.com>

Just a few extra patches on top of the earlier series I sent.

With these patches, we have threaded irq support and autosuspend support for
i2c-omap driver.

All patches boot tested with pandaboard.

Felipe Balbi (4):
  i2c: omap: always return IRQ_HANDLED
  i2c: omap: switch to threaded IRQ support
  i2c: omap: remove unnecessary pm_runtime_suspended check
  i2c: omap: switch over to autosuspend API

 drivers/i2c/busses/i2c-omap.c | 53 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 42 insertions(+), 11 deletions(-)

-- 
1.7.12.rc0

