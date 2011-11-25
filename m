From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 0/2] ARM: OMAP: dmtimer: scheduling while atomic fixes
Date: Thu, 24 Nov 2011 22:12:48 -0600
Message-ID: <1322194370-8073-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:32930 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751458Ab1KYEMx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Nov 2011 23:12:53 -0500
Received: by ggnp4 with SMTP id p4so3784753ggn.31
        for <linux-omap@vger.kernel.org>; Thu, 24 Nov 2011 20:12:51 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King <linux@arm.linux.org.uk>, Tarun Kanti DebBarma <tarun.kanti@ti.com>, Kevin Hilman <khilman@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Benoit Cousson <b-cousson@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Omar Ramirez Luna <omar.ramirez@ti.com>

Changes in dmtimer framework have introduced scheduling-while-atomic
and other lock state BUGs, these are related to the usage of clk_get
(internal path holds a mutex_lock) while holding a spin_lock_irqsave.

The other inconsistent lock state BUGs are caused when calling
omap_dm_timer_request* on softirq or hardirq, because code handling source
parent clocks is still using clk_get, since there is only one user of those
APIs that acquires a lock in a softirq context (tidspbridge) for now it
can be changed.

Omar Ramirez Luna (2):
  ARM: OMAP: dmtimer: fix sleeping function called from invalid context
  ARM: OMAP: dmtimer: reorganize omap_dm_timer_request_*

 arch/arm/plat-omap/dmtimer.c              |  104 +++++++++++------------------
 arch/arm/plat-omap/include/plat/dmtimer.h |    6 +-
 2 files changed, 44 insertions(+), 66 deletions(-)

-- 
1.7.5.4

