From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [PATCH] ARM: OMAP2: fix mailbox init code
Date: Thu, 23 Feb 2012 10:53:35 +0200
Message-ID: <1329987215-28227-1-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:41746 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752081Ab2BWIx7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Feb 2012 03:53:59 -0500
Received: by eaah12 with SMTP id h12so436091eaa.19
        for <linux-omap@vger.kernel.org>; Thu, 23 Feb 2012 00:53:58 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Russell King <linux@arm.linux.org.uk>, Ohad Ben-Cohen <ohad@wizery.com>, Tony Lindgren <tony@atomide.com>, Hiroshi Doyu <hdoyu@nvidia.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

Fix this:

arch/arm/mach-omap2/mailbox.c: In function 'omap2_mbox_probe':
arch/arm/mach-omap2/mailbox.c:354: error: 'omap2_mboxes' undeclared (first use in this function)
arch/arm/mach-omap2/mailbox.c:354: error: (Each undeclared identifier is reported only once
arch/arm/mach-omap2/mailbox.c:354: error: for each function it appears in.)

Which happens on CONFIG_ARCH_OMAP2 && !CONFIG_SOC_OMAP2420, due to
missing omap2_mboxes declaration.

In addition, make sure we declare the right mailbox instances for 2430.

Reported-by: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Hiroshi Doyu <hdoyu@nvidia.com>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/mach-omap2/mailbox.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index 609ea2d..415a6f1 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -281,8 +281,16 @@ static struct omap_mbox mbox_iva_info = {
 	.ops	= &omap2_mbox_ops,
 	.priv	= &omap2_mbox_iva_priv,
 };
+#endif
 
-struct omap_mbox *omap2_mboxes[] = { &mbox_dsp_info, &mbox_iva_info, NULL };
+#ifdef CONFIG_ARCH_OMAP2
+struct omap_mbox *omap2_mboxes[] = {
+	&mbox_dsp_info,
+#ifdef CONFIG_SOC_OMAP2420
+	&mbox_iva_info,
+#endif
+	NULL
+};
 #endif
 
 #if defined(CONFIG_ARCH_OMAP4)
-- 
1.7.5.4

