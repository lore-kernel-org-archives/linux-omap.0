From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 0/3] ARM: OMAP3: clock: cleanup AM35xx clock flags
Date: Mon, 30 Apr 2012 16:30:01 -0700
Message-ID: <1335828604-18795-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:50301 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756938Ab2D3X3G (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Apr 2012 19:29:06 -0400
Received: by dady13 with SMTP id y13so5876216dad.41
        for <linux-omap@vger.kernel.org>; Mon, 30 Apr 2012 16:29:05 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Remove all AM35xx specifics from the clock tree and tree and treat all
AM35xx devices the same.

Kevin Hilman (2):
  ARM: OMAP3: clock data: replace 3503/3517 flag with AM35x flag for
    UART4
  ARM: OMAP3: clock data: treat all AM35x devices the same

Paul Walmsley (1):
  ARM: OMAP: clock: convert AM3517/3505 detection/flags to AM35xx

 arch/arm/mach-omap2/clock3xxx_data.c          |   36 +++++++++----------------
 arch/arm/plat-omap/include/plat/clkdev_omap.h |    4 +--
 2 files changed, 13 insertions(+), 27 deletions(-)

-- 
1.7.9.2

