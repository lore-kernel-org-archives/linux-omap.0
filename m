From: Ilya Yanok <yanok@emcraft.com>
Subject: [PATCH] OMAP3: don't init PM on AM35{05,17}
Date: Tue, 20 Dec 2011 01:00:51 +0100
Message-ID: <1324339251-10764-1-git-send-email-yanok@emcraft.com>
References: <4EEE80DE.8040001@emcraft.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:41752 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751495Ab1LTABB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Dec 2011 19:01:01 -0500
In-Reply-To: <4EEE80DE.8040001@emcraft.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Ilya Yanok <yanok@emcraft.com>

Current OMAP3 PM code seems to be incompatible with AM35{05,17} and
leads to system hang during boot.
Disable PM init on AM35{05,17} until working implementation will be
merged.

Signed-off-by: Ilya Yanok <yanok@emcraft.com>
---
This patch solves the problem for me but I'm curious why simple
CONFIG_PM disabling doesn't work? I'm getting
Unhandled fault: external abort on non-linefetch
while trying to access absolutely valid register from omapdss/venc
driver. I've tried to disable VENC but then I got the same error
from omap_wdt driver. Is it supposed to be so? Are !CONFIG_PM
configurations supported? How comes that disabling CONFIG_PM
makes some registers inaccessible?

Regards, Ilya.

 arch/arm/mach-omap2/pm34xx.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index fc69875..0f30742 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -790,7 +790,7 @@ static int __init omap3_pm_init(void)
 	struct clockdomain *neon_clkdm, *per_clkdm, *mpu_clkdm, *core_clkdm;
 	int ret;
 
-	if (!cpu_is_omap34xx())
+	if (!cpu_is_omap34xx() || cpu_is_omap3505() || cpu_is_omap3517())
 		return -ENODEV;
 
 	if (!omap3_has_io_chain_ctrl())
-- 
1.7.6.4

