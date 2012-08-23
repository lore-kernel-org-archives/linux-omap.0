From: Olof Johansson <olof@lixom.net>
Subject: [PATCH] ARM: omap: add dtb targets
Date: Thu, 23 Aug 2012 09:51:29 -0700
Message-ID: <1345740689-21676-1-git-send-email-olof@lixom.net>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:61821 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750788Ab2HWQvg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Aug 2012 12:51:36 -0400
Received: by pbbrr13 with SMTP id rr13so1805504pbb.19
        for <linux-omap@vger.kernel.org>; Thu, 23 Aug 2012 09:51:36 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Olof Johansson <olof@lixom.net>

Makes it easier to just do 'make dtbs' for whatever the kernel was
configured for, just like some other platforms.

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/arm/mach-omap2/Makefile.boot | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/mach-omap2/Makefile.boot b/arch/arm/mach-omap2/Makefile.boot
index b03e562..6cf1c2d 100644
--- a/arch/arm/mach-omap2/Makefile.boot
+++ b/arch/arm/mach-omap2/Makefile.boot
@@ -1,3 +1,9 @@
   zreladdr-y		+= 0x80008000
 params_phys-y		:= 0x80000100
 initrd_phys-y		:= 0x80800000
+
+dtb-$(CONFIG_SOC_OMAP2420)	+= omap2420-h4.dtb
+dtb-$(CONFIG_ARCH_OMAP3)	+= omap3-beagle.dtb omap3-evm.dtb
+dtb-$(CONFIG_ARCH_OMAP4)	+= omap4-panda.dtb omap4-pandaES.dtb
+dtb-$(CONFIG_ARCH_OMAP4)	+= omap4-var_som.dtb omap4-sdp.dtb
+dtb-$(CONFIG_SOC_OMAP5)		+= omap5-evm.dtb
-- 
1.7.10.1.488.g05fbf7a

