From: Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 1/4] arm: omap2+: add missing HWMOD_NO_IDLEST in 81xx hwmod
 data
Date: Fri, 13 Nov 2015 17:29:53 +0100
Message-ID: <56461001.3050707@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Brian Hutchinson <b.hutchman@gmail.com>, fisaksen@baylibre.com
List-Id: linux-omap@vger.kernel.org

Add missing HWMOD_NO_IDLEST hwmod flag for entries not
having omap4 clkctrl values.
The emac0 hwmod flag fixes the davinci_emac driver probe
since the return of pm_resume() call is now checked.

This solves the following boot errors :
[    0.121429] omap_hwmod: l4_ls: _wait_target_ready failed: -16
[    0.121441] omap_hwmod: l4_ls: cannot be enabled for reset (3)
[    0.124342] omap_hwmod: l4_hs: _wait_target_ready failed: -16
[    0.124352] omap_hwmod: l4_hs: cannot be enabled for reset (3)
[    1.967228] omap_hwmod: emac0: _wait_target_ready failed: -16

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
