From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 1/2] OMAP2420: mailbox: fix IVA vs DSP IRQ numbering
Date: Fri, 11 Feb 2011 11:56:42 -0800
Message-ID: <1297454203-28298-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:57666 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756989Ab1BKT4b (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Feb 2011 14:56:31 -0500
Received: by mail-yi0-f47.google.com with SMTP id 16so1212620yie.6
        for <linux-omap@vger.kernel.org>; Fri, 11 Feb 2011 11:56:31 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-arm-kernel@lists.infradead.org

The IRQ numbering for the IVA and DSP mailboxes was switched due
to the wrong ordering in the OMAP2 mbox list.  Switch the ordering
so DSP is first and matches all the other SoCs.

Tested on OMAP2420/n810.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/mailbox.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index b4cd2aa..1ccf1d6 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -334,7 +334,7 @@ static struct omap_mbox mbox_iva_info = {
 	.priv	= &omap2_mbox_iva_priv,
 };
 
-struct omap_mbox *omap2_mboxes[] = { &mbox_iva_info, &mbox_dsp_info, NULL };
+struct omap_mbox *omap2_mboxes[] = { &mbox_dsp_info, &mbox_iva_info, NULL };
 #endif
 
 #if defined(CONFIG_ARCH_OMAP4)
-- 
1.7.4

