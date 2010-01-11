From: Tony Lindgren <tony@atomide.com>
Subject: Re: [APPLIED] [PATCH v2] omap: zoom3: enable ehci support
Date: Mon, 11 Jan 2010 15:40:18 -0800
Message-ID: <20100111234018.GH5055@atomide.com>
References: <1262894826-10057-1-git-send-email-vikram.pandita@ti.com>
 <notify-1263253054@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:59836 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753124Ab0AKXkL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jan 2010 18:40:11 -0500
Received: from muru.com ([72.249.23.125] helo=localhost.localdomain)
	by mho-02-ewr.mailhop.org with esmtpa (Exim 4.68)
	(envelope-from <tony@atomide.com>)
	id 1NUTrm-0006XY-Tf
	for linux-omap@vger.kernel.org; Mon, 11 Jan 2010 23:40:11 +0000
Content-Disposition: inline
In-Reply-To: <notify-1263253054@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [100111 15:35]:
> This patch has been applied to the linux-omap
> by youw fwiendly patch wobot.
> 
> Branch in linux-omap: for-next
> 
> Initial commit ID (Likely to change): 426d2accc2b9c0392b2be9b8daed5699a08d8822
> 
> PatchWorks
> http://patchwork.kernel.org/patch/71641/
> 
> Git (Likely to change, and takes a while to get mirrored)
> http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=commit;h=426d2accc2b9c0392b2be9b8daed5699a08d8822

I've updated the patch with following cosmetic clean-up:

diff --git a/arch/arm/mach-omap2/board-zoom3.c b/arch/arm/mach-omap2/board-zoom3.c
index b691340..6512b21 100644
--- a/arch/arm/mach-omap2/board-zoom3.c
+++ b/arch/arm/mach-omap2/board-zoom3.c
@@ -53,14 +53,13 @@ static struct omap_board_mux board_mux[] __initdata = {
 #endif
 
 static struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
-	.port_mode[0] = EHCI_HCD_OMAP_MODE_UNKNOWN,
-	.port_mode[1] = EHCI_HCD_OMAP_MODE_PHY,
-	.port_mode[2] = EHCI_HCD_OMAP_MODE_UNKNOWN,
-
-	.phy_reset  = true,
-	.reset_gpio_port[0]  = -EINVAL,
-	.reset_gpio_port[1]  = 64,
-	.reset_gpio_port[2]  = -EINVAL
+	.port_mode[0]		= EHCI_HCD_OMAP_MODE_UNKNOWN,
+	.port_mode[1]		= EHCI_HCD_OMAP_MODE_PHY,
+	.port_mode[2]		= EHCI_HCD_OMAP_MODE_UNKNOWN,
+	.phy_reset		= true,
+	.reset_gpio_port[0]	= -EINVAL,
+	.reset_gpio_port[1]	= 64,
+	.reset_gpio_port[2]	= -EINVAL,
 };
 
 static void __init omap_zoom_init(void)

Regards,

Tony
