From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH v2] ARM: OMAP2+: Fix build issues with missing include of
 linux/bug.h
Date: Wed, 7 Mar 2012 17:28:01 -0800
Message-ID: <20120308012801.GO12083@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:28893 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751697Ab2CHB2E (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Mar 2012 20:28:04 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Otherwise we can get the following if bug.h is not included from kernel.h:

arch/arm/mach-omap2/powerdomain-common.c:
In function 'omap2_pwrdm_get_mem_bank_onstate_mask':
arch/arm/mach-omap2/powerdomain-common.c:64:3: error:
implicit declaration of function 'WARN_ON' [-Werror=implicit-function-declaration]
cc1: some warnings being treated as errors

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/clkt_clksel.c b/arch/arm/mach-omap2/clkt_clksel.c
index e25364d..04d551b 100644
--- a/arch/arm/mach-omap2/clkt_clksel.c
+++ b/arch/arm/mach-omap2/clkt_clksel.c
@@ -43,6 +43,7 @@
 #include <linux/errno.h>
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <linux/bug.h>
 
 #include <plat/clock.h>
 
diff --git a/arch/arm/mach-omap2/powerdomain-common.c b/arch/arm/mach-omap2/powerdomain-common.c
index f97afff..c0aeabf 100644
--- a/arch/arm/mach-omap2/powerdomain-common.c
+++ b/arch/arm/mach-omap2/powerdomain-common.c
@@ -13,6 +13,7 @@
 
 #include <linux/errno.h>
 #include <linux/kernel.h>
+#include <linux/bug.h>
 #include "pm.h"
 #include "cm.h"
 #include "cm-regbits-34xx.h"
diff --git a/arch/arm/mach-omap2/powerdomain2xxx_3xxx.c b/arch/arm/mach-omap2/powerdomain2xxx_3xxx.c
index 6a17e4c..0f0a9f1 100644
--- a/arch/arm/mach-omap2/powerdomain2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/powerdomain2xxx_3xxx.c
@@ -15,6 +15,7 @@
 #include <linux/io.h>
 #include <linux/errno.h>
 #include <linux/delay.h>
+#include <linux/bug.h>
 
 #include <plat/prcm.h>
 
diff --git a/arch/arm/mach-omap2/powerdomains3xxx_data.c b/arch/arm/mach-omap2/powerdomains3xxx_data.c
index 8ef26da..b7ea468 100644
--- a/arch/arm/mach-omap2/powerdomains3xxx_data.c
+++ b/arch/arm/mach-omap2/powerdomains3xxx_data.c
@@ -13,6 +13,7 @@
 
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/bug.h>
 
 #include <plat/cpu.h>
 
