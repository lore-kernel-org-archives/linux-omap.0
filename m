From: "C.A, Subramaniam" <subramaniam.ca@ti.com>
Subject: [PATCH 1/10] omap mailbox: Add build specific changes to support
 omap mailbox
Date: Tue, 22 Sep 2009 19:58:57 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DD9921D8@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49063 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755529AbZIVO26 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Sep 2009 10:28:58 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "tony@atomide.com" <tony@atomide.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@Nokia.com>, "Gupta, Ramesh" <grgupta@ti.com>, "rmk@arm.linux.org.uk" <rmk@arm.linux.org.uk>

>From c25cd3fc0a18010a579ab6fc265009ff19e81ac7 Mon Sep 17 00:00:00 2001
From: C A Subramaniam <subramaniam.ca@ti.com>
Date: Mon, 7 Sep 2009 14:54:20 +0530
Subject: [PATCH 1/10] omap mailbox: Add build specific changes to support omap mailbox.

This patch adds changes to the build related files of mailbox
driver

Signed-off-by: C A Subramaniam <subramaniam.ca@ti.com>
Signed-off-by: Ramesh Gupta G <grgupta@ti.com>
---
 arch/arm/mach-omap2/Makefile |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 735bae5..b7be8b3 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -39,6 +39,9 @@ endif
 obj-$(CONFIG_ARCH_OMAP2)		+= clock24xx.o
 obj-$(CONFIG_ARCH_OMAP3)		+= clock34xx.o
 
+obj-$(CONFIG_OMAP_MBOX_FWK)		+= mailbox_mach.o
+mailbox_mach-objs			:= mailbox.o
+
 iommu-y					+= iommu2.o
 iommu-$(CONFIG_ARCH_OMAP3)		+= omap3-iommu.o
 
-- 
1.5.3.2
