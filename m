From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [RFC 1/3] omap3+: sr: Prevent multiple smartreflex class driver enable calls
Date: Wed,  2 Mar 2011 17:57:23 +0200
Message-ID: <1299081445-27938-2-git-send-email-jhnikula@gmail.com>
References: <1299081445-27938-1-git-send-email-jhnikula@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:59934 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754327Ab1CBP4S (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Mar 2011 10:56:18 -0500
Received: by mail-ey0-f174.google.com with SMTP id 24so22036eyx.19
        for <linux-omap@vger.kernel.org>; Wed, 02 Mar 2011 07:56:17 -0800 (PST)
In-Reply-To: <1299081445-27938-1-git-send-email-jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Thara Gopinath <thara@ti.com>, Nishanth Menon <nm@ti.com>, Jarkko Nikula <jhnikula@gmail.com>

Currently it is possible to enable multiple times the smartreflex class
driver from userspace via ../smartreflex/autocomp debugfs entry. Fix this
by checking the autocomp_active state in sr_start_vddautocomp.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
Not known to cause any problems at the moment with class3 driver.
---
 arch/arm/mach-omap2/smartreflex.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 95ac336..d94894a 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -213,6 +213,9 @@ static void sr_set_regfields(struct omap_sr *sr)
 
 static void sr_start_vddautocomp(struct omap_sr *sr)
 {
+	if (sr->autocomp_active)
+		return;
+
 	if (!sr_class || !(sr_class->enable) || !(sr_class->configure)) {
 		dev_warn(&sr->pdev->dev,
 			"%s: smartreflex class driver not registered\n",
-- 
1.7.2.3

