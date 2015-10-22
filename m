From: Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 1/4] arm: omap2+: add missing HWMOD_NO_IDLEST in 81xx hwmod
 data
Date: Thu, 22 Oct 2015 11:18:42 +0200
Message-ID: <5628A9F2.3010801@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Brian Hutchinson <b.hutchman@gmail.com>, fisaksen@baylibre.com
List-Id: linux-omap@vger.kernel.org

Add missing HWMOD_NO_IDLEST hwmod flag for entries no
having omap4 clkctrl values.

Cc: Brian Hutchinson <b.hutchman@gmail.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_81xx_data.c b/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
index b1288f5..6256052 100644
--- a/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
@@ -144,6 +144,7 @@ static struct omap_hwmod dm81xx_l4_ls_hwmod = {
 	.name		= "l4_ls",
 	.clkdm_name	= "alwon_l3s_clkdm",
 	.class		= &l4_hwmod_class,
+	.flags		= HWMOD_NO_IDLEST,
 };

 /*
@@ -155,6 +156,7 @@ static struct omap_hwmod dm81xx_l4_hs_hwmod = {
 	.name		= "l4_hs",
 	.clkdm_name	= "alwon_l3_med_clkdm",
 	.class		= &l4_hwmod_class,
+	.flags		= HWMOD_NO_IDLEST,
 };

 /* L3 slow -> L4 ls peripheral interface running at 125MHz */
@@ -850,6 +852,7 @@ static struct omap_hwmod dm816x_emac0_hwmod = {
 	.name		= "emac0",
 	.clkdm_name	= "alwon_ethernet_clkdm",
 	.class		= &dm816x_emac_hwmod_class,
+	.flags		= HWMOD_NO_IDLEST,
 };

 static struct omap_hwmod_ocp_if dm81xx_l4_hs__emac0 = {
-- 
1.9.1
