From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [PATCH 2/4] omap: mailbox cleanup: split MODULE_AUTHOR line
Date: Tue, 27 Apr 2010 20:56:20 +0300
Message-ID: <1272390982-14882-3-git-send-email-ohad@wizery.com>
References: <1272390982-14882-1-git-send-email-ohad@wizery.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:4458 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756385Ab0D0R6l (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Apr 2010 13:58:41 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2795216fgg.1
        for <linux-omap@vger.kernel.org>; Tue, 27 Apr 2010 10:58:40 -0700 (PDT)
In-Reply-To: <1272390982-14882-1-git-send-email-ohad@wizery.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kanigeri Hari <h-kanigeri2@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ohad Ben-Cohen <ohad@wizery.com>

use multiple MODULE_AUTHOR lines for multiple authors

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
---
 arch/arm/mach-omap2/mailbox.c |    3 ++-
 arch/arm/plat-omap/mailbox.c  |    3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index 318f363..763272c 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -486,5 +486,6 @@ module_exit(omap2_mbox_exit);
 
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("omap mailbox: omap2/3/4 architecture specific functions");
-MODULE_AUTHOR("Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Paul Mundt");
+MODULE_AUTHOR("Hiroshi DOYU <Hiroshi.DOYU@nokia.com>");
+MODULE_AUTHOR("Paul Mundt");
 MODULE_ALIAS("platform:"DRV_NAME);
diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
index d73d51a..8abf0e8 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -419,4 +419,5 @@ module_exit(omap_mbox_exit);
 
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("omap mailbox: interrupt driven messaging");
-MODULE_AUTHOR("Toshihiro Kobayashi and Hiroshi DOYU");
+MODULE_AUTHOR("Toshihiro Kobayashi");
+MODULE_AUTHOR("Hiroshi DOYU");
-- 
1.6.3.3

