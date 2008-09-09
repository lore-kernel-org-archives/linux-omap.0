From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] OMAP3 clock: remove extra init from csi2_96m_fck
Date: Tue, 9 Sep 2008 10:58:02 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0809091056390.30431@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:37158 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753100AbYIIQ6E (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Sep 2008 12:58:04 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org


csi2_96m_fck no longer should attempt to init its clockdomain pointer; the 
clock framework now does this by default.  Applies on top of the "Update 
powerdomains and clockdomains" series sent earlier.

Verified on 3430SDP ES2.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock34xx.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index 65568c3..56ae83f 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -2298,7 +2298,6 @@ static struct clk cam_ick = {
 static struct clk csi2_96m_fck = {
 	.name		= "csi2_96m_fck",
 	.parent		= &core_96m_fck,
-	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= _OMAP34XX_CM_REGADDR(OMAP3430_CAM_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_CSI2_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
