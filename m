From: Sekhar Nori <nsekhar@ti.com>
Subject: [PATCH 0/3] rtc: omap: cleanups and dra7x support
Date: Fri, 9 May 2014 17:39:00 +0530
Message-ID: <cover.1399635871.git.nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49534 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752606AbaEIMKU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 May 2014 08:10:20 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alessandro Zummo <a.zummo@towertech.it>, Andrew Morton <akpm@linux-foundation.org>
Cc: Linux RTC Mailing List <rtc-linux@googlegroups.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>

This patch series does some cleanups
on RTC driver and prepares it for DRA7x
support.

Applies to linux-next of 5th May.

Tested on DRA7x EVM using some additional
patches for platform support. RTC alarm
was not tested (needs IRQ cross bar patches).

Sekhar Nori (3):
  rtc: omap: remove multiple device id checks
  rtc: omap: use BIT() macro
  rtc: omap: add support for enabling 32khz clock

 drivers/rtc/rtc-omap.c |   71 ++++++++++++++++++++++++++++++------------------
 1 file changed, 45 insertions(+), 26 deletions(-)

-- 
1.7.10.1

