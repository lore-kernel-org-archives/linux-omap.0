From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 0/2] ARM: OMAP: few more PM fixes for v3.5-rc
Date: Thu, 28 Jun 2012 10:01:30 -0700
Message-ID: <1340902892-9542-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:55067 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755605Ab2F1RBl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Jun 2012 13:01:41 -0400
Received: by dady13 with SMTP id y13so3181684dad.5
        for <linux-omap@vger.kernel.org>; Thu, 28 Jun 2012 10:01:35 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Tony, here are hopefully the last couple PM-related fixes for v3.5-rc.

Both of these fix suspend/resume/wakeup problems on OMAP3 or OMAP4.

Thanks,

Kevin

Kevin Hilman (2):
  ARM: OMAP2: Overo: init I2C before MMC to fix MMC suspend/resume
    failure
  ARM: OMAP4: TWL6030: ensure sys_nirq1 is mux'd and wakeup enabled

 arch/arm/mach-omap2/board-overo.c |    2 +-
 arch/arm/mach-omap2/twl-common.c  |    2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

-- 
1.7.9.2

