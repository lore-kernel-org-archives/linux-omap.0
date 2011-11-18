From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 0/2] ARM: OMAP: misc. PM fixes for v3.2-rc
Date: Fri, 18 Nov 2011 11:22:38 -0800
Message-ID: <1321644160-19981-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:51584 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754754Ab1KRTWj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 Nov 2011 14:22:39 -0500
Received: by mail-vw0-f45.google.com with SMTP id fr13so536063vbb.4
        for <linux-omap@vger.kernel.org>; Fri, 18 Nov 2011 11:22:38 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Tony,

Here's a couple more PM fixes for v3.2-rc.

Also available here if you prefer to pull:

   git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_3.2/fixes/pm

(Note that this branch also includes the CPUidle fix that you already have
 in your fixes branch)

Kevin

Felipe Balbi (1):
  arm: omap: smartreflex: fix IRQ handling bug

Kevin Hilman (1):
  ARM: OMAP: PM: only register TWL with voltage layer when device is
    present

 arch/arm/mach-omap2/pm.c          |    6 ++----
 arch/arm/mach-omap2/smartreflex.c |    2 +-
 arch/arm/mach-omap2/twl-common.c  |   11 +++++++++++
 arch/arm/mach-omap2/twl-common.h  |    3 +++
 4 files changed, 17 insertions(+), 5 deletions(-)

-- 
1.7.6

