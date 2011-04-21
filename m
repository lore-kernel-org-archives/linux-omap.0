From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 0/2] OMAP: GPIO: cleanup: first pass at ifdef removal
Date: Wed, 20 Apr 2011 17:13:49 -0700
Message-ID: <1303344831-7889-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:50891 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752097Ab1DUAMA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Apr 2011 20:12:00 -0400
Received: by mail-px0-f173.google.com with SMTP id 16so1013529pxi.4
        for <linux-omap@vger.kernel.org>; Wed, 20 Apr 2011 17:11:59 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, charu@ti.com

This series is a first pass at the #ifdef removal cleanup.  

To demonstrate the type of changes needed for the cleanup, the
direction and data input/output functions are handled first.  Register
offset fields are added to platform_data so #ifdefs can be removed.

Similar needs to be done for the remaining #ifdefs.

Currently boot tested on 3430/n900 only.

Series applies to v2.6.39-rc4.

Kevin Hilman (2):
  OMAP: GPIO: move register offset defines into gpio.h
  OMAP: GPIO: consolidate direction, input, output, remove #ifdefs

 arch/arm/mach-omap1/gpio15xx.c         |    7 +
 arch/arm/mach-omap1/gpio16xx.c         |   15 ++
 arch/arm/mach-omap1/gpio7xx.c          |   15 ++
 arch/arm/mach-omap2/gpio.c             |   10 +
 arch/arm/plat-omap/gpio.c              |  328 +++----------------------------
 arch/arm/plat-omap/include/plat/gpio.h |  111 +++++++++++
 6 files changed, 190 insertions(+), 296 deletions(-)

-- 
1.7.4

