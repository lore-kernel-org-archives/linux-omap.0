From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 0/2] ARM: OMAP/TWL: remove unused pdata IRQ fields
Date: Tue,  8 May 2012 10:19:00 -0700
Message-ID: <1336497542-13629-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:58823 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756003Ab2EHRTM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 13:19:12 -0400
Received: by pbbrq2 with SMTP id rq2so8573898pbb.34
        for <linux-omap@vger.kernel.org>; Tue, 08 May 2012 10:19:04 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>, Benoit Cousson <b-cousson@ti.com>
Cc: linux-arm-kernel@lists.infradead.org

The TWL driver has been converted to SPARSE_IRQ, and no longer needs
these fields.  Remove them.

Samuel, with your ack, we can keep the twl.h change with the OMAP
change that removes all the users so they merge together and avoid
potential build problems if they merge separately.

Kevin


Kevin Hilman (2):
  ARM: OMAP2+: TWL: remove usage of pdata->irq_base/_end
  mfd: twl: remove pdata->irq_base/_end, no more users

 arch/arm/mach-omap2/board-2430sdp.c    |    3 ---
 arch/arm/mach-omap2/board-omap3logic.c |    3 ---
 arch/arm/mach-omap2/twl-common.c       |   10 ----------
 include/linux/i2c/twl.h                |    1 -
 4 files changed, 17 deletions(-)

-- 
1.7.9.2

