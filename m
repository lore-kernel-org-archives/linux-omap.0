From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 03/13] OMAP3: PM: Enable system control module autoidle
Date: Fri,  8 Jan 2010 09:59:21 -0800
Message-ID: <1262973571-25796-4-git-send-email-khilman@deeprootsystems.com>
References: <1262973571-25796-1-git-send-email-khilman@deeprootsystems.com>
 <1262973571-25796-2-git-send-email-khilman@deeprootsystems.com>
 <1262973571-25796-3-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.216.174]:51031 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753644Ab0AHR7k (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jan 2010 12:59:40 -0500
Received: by mail-px0-f174.google.com with SMTP id 4so2222956pxi.33
        for <linux-omap@vger.kernel.org>; Fri, 08 Jan 2010 09:59:39 -0800 (PST)
In-Reply-To: <1262973571-25796-3-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tero Kristo <tero.kristo@nokia.com>, Mika Westerberg <ext-mika.1.westerberg@nokia.com>

From: Tero Kristo <tero.kristo@nokia.com>

Enable the auto-idle feature of the SCM block to save some additional
power.

Signed-off-by: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm34xx.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index b26418d..8a148fb 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -837,6 +837,8 @@ static void __init prcm_setup_regs(void)
 			CM_AUTOIDLE);
 	}
 
+	omap_ctrl_writel(OMAP3430_AUTOIDLE, OMAP2_CONTROL_SYSCONFIG);
+
 	/*
 	 * Set all plls to autoidle. This is needed until autoidle is
 	 * enabled by clockfw
-- 
1.6.6.rc2.1.g42108

