From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: OMAP2+: Fix serial init for device tree based booting
Date: Fri, 7 Jun 2013 14:55:04 -0700
Message-ID: <20130607215503.GK3331@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:59592 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752999Ab3FGVzH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jun 2013 17:55:07 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

We don't want to call omap_serial_early_init() for device
tree based booting as the ports are initialized based on
the .dts entries.

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -176,6 +176,9 @@ static char *cmdline_find_option(char *str)
 
 static int __init omap_serial_early_init(void)
 {
+	if (of_have_populated_dt())
+		return -ENODEV;
+
 	do {
 		char oh_name[MAX_UART_HWMOD_NAME_LEN];
 		struct omap_hwmod *oh;
