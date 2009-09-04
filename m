From: "C.A, Subramaniam" <subramaniam.ca@ti.com>
Subject: [PATCH 1/10] omap mailbox: OMAP4-Mailbox - Add build specific
 changes to support OMAP4 mailbox.
Date: Fri, 4 Sep 2009 17:17:09 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DD6108EA@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41268 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755791AbZIDLq1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Sep 2009 07:46:27 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "tony@atomide.com" <tony@atomide.com>, "Hiroshi.DOYU@nokia.com" <Hiroshi.DOYU@nokia.com>, "rmk@arm.linux.org.uk" <rmk@arm.linux.org.uk>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "Gupta, Ramesh" <grgupta@ti.com>

>From aa759db084be9a2893de5e61b11f6de6d05508d9 Mon Sep 17 00:00:00 2001
From: C A Subramaniam <subramaniam.ca@ti.com>
Date: Wed, 2 Sep 2009 17:52:22 +0530
Subject: [PATCH 1/10] omap mailbox: OMAP4-Mailbox - Add build specific changes to support OMAP4 mailbox.

This patch adds changes to the build related files of mailbox
driver to support OMAP4 mailbox

Signed-off-by: C A Subramaniam <subramaniam.ca@ti.com>
Signed-off-by: Ramesh Gupta G <grgupta@ti.com>
---
 arch/arm/mach-omap2/Makefile |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 735bae5..4bb426d 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -39,6 +39,10 @@ endif
 obj-$(CONFIG_ARCH_OMAP2)		+= clock24xx.o
 obj-$(CONFIG_ARCH_OMAP3)		+= clock34xx.o
 
+# MAILBOX
+obj-$(CONFIG_OMAP_MBOX_FWK)	+= mailbox_mach.o
+mailbox_mach-objs		:= mailbox.o
+
 iommu-y					+= iommu2.o
 iommu-$(CONFIG_ARCH_OMAP3)		+= omap3-iommu.o
 
-- 
1.5.3.2
