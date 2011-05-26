From: Todd Poynor <toddpoynor@google.com>
Subject: [PATCH] ARM: OMAP2: Add missing iounmap in omap4430_phy_init
Date: Thu, 26 May 2011 12:25:53 -0700
Message-ID: <20110526192553.GA21534@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:25157 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753168Ab1EZT0M (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 May 2011 15:26:12 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Hema HK <hemahk@ti.com>

!dev case needs iounmap before return.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 arch/arm/mach-omap2/omap_phy_internal.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_phy_internal.c b/arch/arm/mach-omap2/omap_phy_internal.c
index ae97336..bd563cf 100644
--- a/arch/arm/mach-omap2/omap_phy_internal.c
+++ b/arch/arm/mach-omap2/omap_phy_internal.c
@@ -56,8 +56,10 @@ int omap4430_phy_init(struct device *dev)
 	/* Power down the phy */
 	__raw_writel(PHY_PD, ctrl_base + CONTROL_DEV_CONF);
 
-	if (!dev)
+	if (!dev) {
+		iounmap(ctrl_base);
 		return 0;
+	}
 
 	phyclk = clk_get(dev, "ocp2scp_usb_phy_ick");
 	if (IS_ERR(phyclk)) {
-- 
1.7.3.1

