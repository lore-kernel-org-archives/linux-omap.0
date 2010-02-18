From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 10/23] omap3: Add platform init code for EHCI driver on IGEP v2
Date: Wed, 17 Feb 2010 17:32:15 -0800
Message-ID: <20100218013215.32075.39322.stgit@baageli.muru.com>
References: <20100218013012.32075.43788.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:58923 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754414Ab0BRBbZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Feb 2010 20:31:25 -0500
In-Reply-To: <20100218013012.32075.43788.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Enric Balletbo i Serra <eballetbo@iseebcn.com>, linux-omap@vger.kernel.org

From: Enric Balletbo i Serra <eballetbo@iseebcn.com>

Add platform init code for EHCI driver on IGEP v2

Signed-off-by: Enric Balletbo i Serra <eballetbo@iseebcn.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-igep0020.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 71488b2..f6102c7 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -213,6 +213,17 @@ static int __init igep2_i2c_init(void)
 	return 0;
 }
 
+static struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
+	.port_mode[0] = EHCI_HCD_OMAP_MODE_UNKNOWN,
+	.port_mode[1] = EHCI_HCD_OMAP_MODE_PHY,
+	.port_mode[2] = EHCI_HCD_OMAP_MODE_UNKNOWN,
+
+	.phy_reset = true,
+	.reset_gpio_port[0] = -EINVAL,
+	.reset_gpio_port[1] = IGEP2_GPIO_USBH_NRESET,
+	.reset_gpio_port[2] = -EINVAL,
+};
+
 #ifdef CONFIG_OMAP_MUX
 static struct omap_board_mux board_mux[] __initdata = {
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
@@ -227,6 +238,7 @@ static void __init igep2_init(void)
 	igep2_i2c_init();
 	omap_serial_init();
 	usb_musb_init();
+	usb_ehci_init(&ehci_pdata);
 
 	igep2_init_smsc911x();
 

