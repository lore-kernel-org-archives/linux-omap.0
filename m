From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: [PATCH 1/1] ARM: OMAP: Add maintainer entry for IGEP machines
Date: Mon,  8 Oct 2012 10:47:34 +0200
Message-ID: <1349686054-7486-1-git-send-email-javier@dowhile0.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:52357 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754073Ab2JHIrp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Oct 2012 04:47:45 -0400
Received: by mail-wi0-f170.google.com with SMTP id hm2so2946082wib.1
        for <linux-omap@vger.kernel.org>; Mon, 08 Oct 2012 01:47:44 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King <linux@arm.linux.org.uk>, Enric Balletbo i Serra <eballetbo@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Javier Martinez Canillas <javier@dowhile0.org>

Enric and I have been mantained this machine and while we
are moving to device trees, it is good that people cc us
when reporting bugs or regression on the board file until
we have proper DT support.

Signed-off-by: Javier Martinez Canillas <javier@dowhile0.org>
---
 MAINTAINERS |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 63ce2a2..6b3c58d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -818,6 +818,14 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kristoffer/linux-hpc.git
 F:	arch/arm/mach-sa1100/jornada720.c
 F:	arch/arm/mach-sa1100/include/mach/jornada720.h
 
+ARM/IGEP MACHINE SUPPORT
+M:	Enric Balletbo i Serra <eballetbo@gmail.com>
+M:	Javier Martinez Canillas <javier@dowhile0.org>
+L:	linux-omap@vger.kernel.org
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	arch/arm/mach-omap2/board-igep0020.c
+
 ARM/INCOME PXA270 SUPPORT
 M:	Marek Vasut <marek.vasut@gmail.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-- 
1.7.7.6

