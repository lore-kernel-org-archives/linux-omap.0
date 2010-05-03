From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/PATCH 8/8] omap: mailbox: always built-in omap2 platform data
Date: Mon,  3 May 2010 03:02:47 +0300
Message-ID: <1272844967-25441-4-git-send-email-felipe.contreras@gmail.com>
References: <1272844798-25330-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:51880 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752604Ab0ECADX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 2 May 2010 20:03:23 -0400
Received: by mail-bw0-f219.google.com with SMTP id 19so1033152bwz.21
        for <linux-omap@vger.kernel.org>; Sun, 02 May 2010 17:03:22 -0700 (PDT)
In-Reply-To: <1272844798-25330-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Ohad Ben-Cohen <ohad@wizery.com>, Felipe Contreras <felipe.contreras@gmail.com>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 arch/arm/mach-omap2/Makefile |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 307f8b0..9fcd87b 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -56,8 +56,9 @@ obj-$(CONFIG_ARCH_OMAP4)		+= clock44xx.o clock44xx_data.o
 # EMU peripherals
 obj-$(CONFIG_OMAP3_EMU)		+= emu.o
 
-obj-$(CONFIG_OMAP_MBOX_FWK)		+= mailbox_mach.o
-mailbox_mach-objs			:= mailbox.o
+ifneq ($(CONFIG_OMAP_MBOX_FWK),)
+obj-y					+= mailbox.o
+endif
 
 iommu-y					+= iommu2.o
 iommu-$(CONFIG_ARCH_OMAP3)		+= omap3-iommu.o
-- 
1.7.1

