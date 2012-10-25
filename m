From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCH 0/2] i2c: omap: cleanups
Date: Thu, 25 Oct 2012 15:53:04 +0530
Message-ID: <1351160586-12306-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57952 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935568Ab2JYKXi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 25 Oct 2012 06:23:38 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, w.sang@pengutronix.de, Shubhrajyoti D <shubhrajyoti@ti.com>

Applies on Felipe's series
http://www.spinics.net/lists/linux-omap/msg79995.html

Tested with Terro sys fix + Felipe's stop sched_clock() during suspend
on omap3630 beagle both idle and suspend.

Functional testing on omap4sdp.


Shubhrajyoti D (2):
  i2c: omap: re-factor omap_i2c_init function
  i2c: omap: make reset a seperate function

 drivers/i2c/busses/i2c-omap.c |   97 +++++++++++++++++++++--------------------
 1 files changed, 49 insertions(+), 48 deletions(-)

-- 
1.7.5.4

