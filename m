From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH] OMAP2+: voltage: don't build voltage layer when !CONFIG_PM
Date: Thu, 10 Mar 2011 16:49:48 -0800
Message-ID: <1299804588-13544-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:53979 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754029Ab1CKAtk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Mar 2011 19:49:40 -0500
Received: by mail-gw0-f52.google.com with SMTP id 15so1542969gwj.25
        for <linux-omap@vger.kernel.org>; Thu, 10 Mar 2011 16:49:39 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsely <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

commit 47cfef (OMAP2+: voltage: reorganize, split code from data)
moved voltage.c to it's own section in the Makefile.  The original
section was wrapped by ifeq CONFIG_PM, but the new section was not.

Wrap new voltage section with conditional compile for CONFIG_PM

Fixes the following compile error when !CONFIG_PM

/work/kernel/omap/pm/arch/arm/mach-omap2/voltage.c:957:5: error: redefinition of 'omap_voltage_register_pmic'
/work/kernel/omap/pm/arch/arm/mach-omap2/voltage.h:167:50: note: previous definition of 'omap_voltage_register_pmic' was here
/work/kernel/omap/pm/arch/arm/mach-omap2/voltage.c:1009:6: error: redefinition of 'omap_change_voltscale_method'
/work/kernel/omap/pm/arch/arm/mach-omap2/voltage.h:172:51: note: previous definition of 'omap_change_voltscale_method' was here
/work/kernel/omap/pm/arch/arm/mach-omap2/voltage.c:1043:23: error: redefinition of 'omap_voltage_domain_lookup'
/work/kernel/omap/pm/arch/arm/mach-omap2/voltage.h:178:68: note: previous definition of 'omap_voltage_domain_lookup' was here
/work/kernel/omap/pm/arch/arm/mach-omap2/voltage.c:1073:115: error: redefinition of 'omap_voltage_late_init'
/work/kernel/omap/pm/arch/arm/mach-omap2/voltage.h:174:50: note: previous definition of 'omap_voltage_late_init' was here

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
Paul, feel free to fold into the original patch in your
integration-2.6.39 branch.

 arch/arm/mach-omap2/Makefile |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 4edac5d..82b2a67 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -89,12 +89,14 @@ obj-$(CONFIG_ARCH_OMAP4)		+= prcm.o cm2xxx_3xxx.o cminst44xx.o \
 					   vp44xx_data.o
 
 # OMAP voltage domains
+ifeq ($(CONFIG_PM),y)
 voltagedomain-common			:= voltage.o
 obj-$(CONFIG_ARCH_OMAP2)		+= $(voltagedomain-common)
 obj-$(CONFIG_ARCH_OMAP3)		+= $(voltagedomain-common) \
 					   voltagedomains3xxx_data.o
 obj-$(CONFIG_ARCH_OMAP4)		+= $(voltagedomain-common) \
 					   voltagedomains44xx_data.o
+endif
 
 # OMAP powerdomain framework
 powerdomain-common			+= powerdomain.o powerdomain-common.o
-- 
1.7.4

