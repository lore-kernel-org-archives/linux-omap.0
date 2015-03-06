From: Tony Lindgren <tony@atomide.com>
Subject: ARM: OMAP2+: Fix wl12xx on dm3730-evm with mainline u-boot
Date: Fri, 6 Mar 2015 10:39:37 -0800
Message-ID: <20150306183937.GB13520@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from pmta1.delivery8.ore.mailhop.org ([54.191.158.99]:42331 "EHLO
	pmta1.delivery8.ore.mailhop.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755085AbbCFSrD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Mar 2015 13:47:03 -0500
Received: from smtp5.ore.mailhop.org (172.31.18.134) by pmta1.delivery1.ore.mailhop.org id hv7r1620r840 for <linux-omap@vger.kernel.org>; Fri, 6 Mar 2015 18:44:41 +0000 (envelope-from <tony@atomide.com>)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

I upgraded my u-boot and noticed that wl12xx stopped working.
Turns out the kernel is not setting the quirk for the MMC2
copy clock while the eariler bootloader I had was setting it.

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -173,6 +173,7 @@ static void __init omap3_igep0030_rev_g_legacy_init(void)
 
 static void __init omap3_evm_legacy_init(void)
 {
+	hsmmc2_internal_input_clk();
 	legacy_init_wl12xx(WL12XX_REFCLOCK_38, 0, 149);
 }
 
