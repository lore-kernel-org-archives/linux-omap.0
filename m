From: "C.A, Subramaniam" <subramaniam.ca@ti.com>
Subject: [PATCH 1/10] omap: mailbox: Add build specific changes to support
 omap mailbox
Date: Fri, 13 Nov 2009 18:00:55 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DE4C4990@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52676 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751401AbZKMMai convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Nov 2009 07:30:38 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Gupta, Ramesh" <grgupta@ti.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@Nokia.com>

>From bf41b0fd7324149a647b43d434ae3821bea49541 Mon Sep 17 00:00:00 2001
From: C A Subramaniam <subramaniam.ca@ti.com>
Date: Thu, 12 Nov 2009 16:18:03 -0800
Subject: [PATCH 1/10] omap: mailbox: Add build specific changes to support omap mailbox

This patch adds changes to the build related files of mailbox
driver

Signed-off-by: C A Subramaniam <subramaniam.ca@ti.com>
Signed-off-by: Ramesh Gupta G <grgupta@ti.com>
Acked-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Makefile |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 5c32b65..b77fe24 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -44,6 +44,9 @@ obj-$(CONFIG_ARCH_OMAP4)		+= cm4xxx.o
 obj-$(CONFIG_ARCH_OMAP2)		+= clock24xx.o
 obj-$(CONFIG_ARCH_OMAP3)		+= clock34xx.o
 
+obj-$(CONFIG_OMAP_MBOX_FWK)		+= mailbox_mach.o
+mailbox_mach-objs			:= mailbox.o
+
 iommu-y					+= iommu2.o
 iommu-$(CONFIG_ARCH_OMAP3)		+= omap3-iommu.o
 
-- 
1.5.3.2
