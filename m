From: Mike Rapoport <mike@compulab.co.il>
Subject: [PATCH] ARM: OMAP3: cm-t35: add EHCI support
Date: Wed, 14 Oct 2009 10:15:03 +0200
Message-ID: <4AD58887.9010004@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:33024 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755698AbZJNIPm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Oct 2009 04:15:42 -0400
Received: from [62.90.235.247] (helo=zimbra-mta.compulab.co.il)
	by compulab.site5.com with esmtp (Exim 4.69)
	(envelope-from <mike@compulab.co.il>)
	id 1Mxz0j-0003Jj-2r
	for linux-omap@vger.kernel.org; Wed, 14 Oct 2009 03:15:05 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbra-mta.compulab.co.il (Postfix) with ESMTP id 3B1849A034C
	for <linux-omap@vger.kernel.org>; Wed, 14 Oct 2009 10:15:04 +0200 (IST)
Received: from zimbra-mta.compulab.co.il ([127.0.0.1])
	by localhost (zimbra-mta.compulab.co.il [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T0NvImkZyNJn for <linux-omap@vger.kernel.org>;
	Wed, 14 Oct 2009 10:15:04 +0200 (IST)
Received: from [10.1.1.95] (mike-pc.compulab.local [10.1.1.95])
	by zimbra-mta.compulab.co.il (Postfix) with ESMTP id 1D4ED9A0343
	for <linux-omap@vger.kernel.org>; Wed, 14 Oct 2009 10:15:04 +0200 (IST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

This patch adds support for EHCI on CM-T35.
It depends on basic CM-T35 board support ([1]) and EHCI updates
in the linux-omap tree.

[1] http://thread.gmane.org/gmane.linux.ports.arm.omap/24938
---

Signed-off-by: Mike Rapoport <mike@compulab.co.il>
---
 arch/arm/mach-omap2/board-cm-t35.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index 94c1f35..1465892 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -352,6 +352,17 @@ static struct twl4030_hsmmc_info mmc[] = {
 	{}	/* Terminator */
 };

+static struct ehci_hcd_omap_platform_data ehci_pdata = {
+	.port_mode[0] = EHCI_HCD_OMAP_MODE_PHY,
+	.port_mode[1] = EHCI_HCD_OMAP_MODE_PHY,
+	.port_mode[2] = EHCI_HCD_OMAP_MODE_UNKNOWN,
+
+	.phy_reset  = true,
+	.reset_gpio_port[0]  = -EINVAL,
+	.reset_gpio_port[1]  = -EINVAL,
+	.reset_gpio_port[2]  = -EINVAL
+};
+
 static int cm_t35_twl_gpio_setup(struct device *dev, unsigned gpio,
 				 unsigned ngpio)
 {
@@ -377,6 +388,12 @@ static int cm_t35_twl_gpio_setup(struct device *dev, unsigned gpio,
 	cm_t35_vmmc1_supply.dev = mmc[0].dev;
 	cm_t35_vsim_supply.dev = mmc[0].dev;

+	/* setup USB with proper PHY reset GPIOs */
+	ehci_pdata.reset_gpio_port[0] = gpio + 6;
+	ehci_pdata.reset_gpio_port[1] = gpio + 7;
+
+	usb_ehci_init(&ehci_pdata);
+
 	return 0;
 }

-- 
1.6.0.6


-- 
Sincerely yours,
Mike.


