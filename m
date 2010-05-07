From: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Subject: RE: [PATCH V2]omap: mux.c warning removal
Date: Fri, 7 May 2010 12:17:48 +0530
Message-ID: <0680EC522D0CC943BC586913CF3768C003B31655C3@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46083 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751124Ab0EGGry convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 May 2010 02:47:54 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>

From: Keshava Munegowda <a0393220@ti.com>

This patch removes the below warning 
arch/arm/mach-omap2/mux.c:52: warning: 'mux_phys' defined but not used
The definition of variable mux_phys should be enclosed in the macro CONFIG_ARCH_OMAP3 

Signed-off-by: Keshava Munegowda <a0393220@ti.com>

Index: linux-2.6/arch/arm/mach-omap2/mux.c
===================================================================
--- linux-2.6.orig/arch/arm/mach-omap2/mux.c	2010-05-05 23:59:19.000000000 +0530
+++ linux-2.6/arch/arm/mach-omap2/mux.c	2010-05-06 00:00:07.000000000 +0530
@@ -49,7 +49,7 @@
 	struct list_head	node;
 };
 
-static unsigned long mux_phys;
+
 static void __iomem *mux_base;
 
 u16 omap_mux_read(u16 reg)
@@ -373,6 +373,7 @@
 #ifdef CONFIG_ARCH_OMAP3
 static LIST_HEAD(muxmodes);
 static DEFINE_MUTEX(muxmode_mutex);
+static unsigned long mux_phys;
 
 #ifdef CONFIG_OMAP_MUX

