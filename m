From: Vaibhav Bedia <vaibhav.bedia@ti.com>
Subject: [PATCH 03/15] ARM: OMAP: mailbox: Convert to device_initcall
Date: Fri, 2 Nov 2012 18:02:34 +0530
Message-ID: <1351859566-24818-4-git-send-email-vaibhav.bedia@ti.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45221 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761020Ab2KBMed (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Nov 2012 08:34:33 -0400
In-Reply-To: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: khilman@ti.com, paul@pwsan.com, b-cousson@ti.com, tony@atomide.com, Vaibhav Bedia <vaibhav.bedia@ti.com>

The power management code for AM33XX is a late_initcall
and the PM features depend on the mailbox for IPC.
In preparation for this, convert the mailbox init to
a device_initcall.

Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
---
 arch/arm/mach-omap2/mailbox.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index 7a343aa..8c63c86 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -469,7 +469,7 @@ static void __exit omap2_mbox_exit(void)
 	platform_driver_unregister(&omap2_mbox_driver);
 }
 
-module_init(omap2_mbox_init);
+device_initcall(omap2_mbox_init);
 module_exit(omap2_mbox_exit);
 
 MODULE_LICENSE("GPL v2");
-- 
1.7.0.4

