From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: OMAP2+: Fix section warning for omap_init_ocp2scp()
Date: Mon, 21 Jan 2013 10:26:03 -0800
Message-ID: <20130121182602.GF22517@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:48057 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755429Ab3AUS0F (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Jan 2013 13:26:05 -0500
Received: from c-50-131-214-131.hsd1.ca.comcast.net ([50.131.214.131] helo=localhost.localdomain)
	by mho-01-ewr.mailhop.org with esmtpa (Exim 4.72)
	(envelope-from <tony@atomide.com>)
	id 1TxM4K-000Khb-HS
	for linux-omap@vger.kernel.org; Mon, 21 Jan 2013 18:26:04 +0000
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Otherwise we will get:

WARNING: vmlinux.o(.text+0x1d4f0): Section mismatch in reference from the
function omap_init_ocp2scp() to the function .init.text:omap_device_build()
The function omap_init_ocp2scp() references
the function __init omap_device_build().
This is often because omap_init_ocp2scp lacks a __init
annotation or the annotation of omap_device_build is wrong.

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -639,7 +639,7 @@ static int count_ocp2scp_devices(struct omap_ocp2scp_dev *ocp2scp_dev)
 	return cnt;
 }
 
-static void omap_init_ocp2scp(void)
+static void __init omap_init_ocp2scp(void)
 {
 	struct omap_hwmod	*oh;
 	struct platform_device	*pdev;
