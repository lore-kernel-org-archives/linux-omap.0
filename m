From: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 10/10] arm: omap: usb: clock entries for omap3 and omap4
Date: Sat, 26 Feb 2011 04:36:38 +0530
Message-ID: <1298675198-14214-11-git-send-email-keshava_mgowda@ti.com>
References: <1298675198-14214-1-git-send-email-keshava_mgowda@ti.com>
 <1298675198-14214-2-git-send-email-keshava_mgowda@ti.com>
 <1298675198-14214-3-git-send-email-keshava_mgowda@ti.com>
 <1298675198-14214-4-git-send-email-keshava_mgowda@ti.com>
 <1298675198-14214-5-git-send-email-keshava_mgowda@ti.com>
 <1298675198-14214-6-git-send-email-keshava_mgowda@ti.com>
 <1298675198-14214-7-git-send-email-keshava_mgowda@ti.com>
 <1298675198-14214-8-git-send-email-keshava_mgowda@ti.com>
 <1298675198-14214-9-git-send-email-keshava_mgowda@ti.com>
 <1298675198-14214-10-git-send-email-keshava_mgowda@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1298675198-14214-10-git-send-email-keshava_mgowda-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>, balbi-l0cyMroinI0@public.gmane.org, gadiyar-l0cyMroinI0@public.gmane.org, p-basak2-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

The devices of clocks are set to usbhs, so that
only usbhs common driver can invoke these clocks.
The dummy per port clocks are added to omap3
clock data base. This helps to invoke common
clock get APIs for omap3 and omap4.

Signed-off-by: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-omap2/clock3xxx_data.c |   14 +++++++++-----
 arch/arm/mach-omap2/clock44xx_data.c |   10 +++++-----
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index 403a4a1..bba590f 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -3286,7 +3286,7 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK(NULL,	"cpefuse_fck",	&cpefuse_fck,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
 	CLK(NULL,	"ts_fck",	&ts_fck,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
 	CLK(NULL,	"usbtll_fck",	&usbtll_fck,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
-	CLK("ehci-omap.0",	"usbtll_fck",	&usbtll_fck,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
+	CLK("usbhs-omap.0",	"usbtll_fck",	&usbtll_fck,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
 	CLK("omap-mcbsp.1",	"prcm_fck",	&core_96m_fck,	CK_3XXX),
 	CLK("omap-mcbsp.5",	"prcm_fck",	&core_96m_fck,	CK_3XXX),
 	CLK(NULL,	"core_96m_fck",	&core_96m_fck,	CK_3XXX),
@@ -3322,7 +3322,7 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK(NULL,	"pka_ick",	&pka_ick,	CK_34XX | CK_36XX),
 	CLK(NULL,	"core_l4_ick",	&core_l4_ick,	CK_3XXX),
 	CLK(NULL,	"usbtll_ick",	&usbtll_ick,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
-	CLK("ehci-omap.0",	"usbtll_ick",	&usbtll_ick,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
+	CLK("usbhs-omap.0",	"usbtll_ick",	&usbtll_ick,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
 	CLK("mmci-omap-hs.2",	"ick",	&mmchs3_ick,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
 	CLK(NULL,	"icr_ick",	&icr_ick,	CK_34XX | CK_36XX),
 	CLK("omap-aes",	"ick",	&aes2_ick,	CK_34XX | CK_36XX),
@@ -3368,11 +3368,15 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK(NULL,	"cam_ick",	&cam_ick,	CK_34XX | CK_36XX),
 	CLK(NULL,	"csi2_96m_fck",	&csi2_96m_fck,	CK_34XX | CK_36XX),
 	CLK(NULL,	"usbhost_120m_fck", &usbhost_120m_fck, CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
-	CLK("ehci-omap.0",	"hs_fck", &usbhost_120m_fck, CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
+	CLK("usbhs-omap.0",	"hs_fck", &usbhost_120m_fck, CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
 	CLK(NULL,	"usbhost_48m_fck", &usbhost_48m_fck, CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
-	CLK("ehci-omap.0",	"fs_fck", &usbhost_48m_fck, CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
+	CLK("usbhs-omap.0",	"fs_fck", &usbhost_48m_fck, CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
 	CLK(NULL,	"usbhost_ick",	&usbhost_ick,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
-	CLK("ehci-omap.0",	"usbhost_ick",	&usbhost_ick,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
+	CLK("usbhs-omap.0",	"usbhost_ick",	&usbhost_ick,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
+	CLK("usbhs-omap.0",	"utmi_p1_gfclk",	&dummy_ck,	CK_3XXX),
+	CLK("usbhs-omap.0",	"utmi_p2_gfclk",	&dummy_ck,	CK_3XXX),
+	CLK("usbhs-omap.0",	"xclk60mhsp1_ck",	&dummy_ck,	CK_3XXX),
+	CLK("usbhs-omap.0",	"xclk60mhsp2_ck",	&dummy_ck,	CK_3XXX),
 	CLK(NULL,	"usim_fck",	&usim_fck,	CK_3430ES2PLUS | CK_36XX),
 	CLK(NULL,	"gpt1_fck",	&gpt1_fck,	CK_3XXX),
 	CLK(NULL,	"wkup_32k_fck",	&wkup_32k_fck,	CK_3XXX),
diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index de9ec8d..46fd3f6 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -3197,7 +3197,7 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK(NULL,	"uart3_fck",			&uart3_fck,	CK_443X),
 	CLK(NULL,	"uart4_fck",			&uart4_fck,	CK_443X),
 	CLK(NULL,	"usb_host_fs_fck",		&usb_host_fs_fck,	CK_443X),
-	CLK("ehci-omap.0",	"fs_fck",		&usb_host_fs_fck,	CK_443X),
+	CLK("usbhs-omap.0",	"fs_fck",		&usb_host_fs_fck,	CK_443X),
 	CLK(NULL,	"utmi_p1_gfclk",		&utmi_p1_gfclk,	CK_443X),
 	CLK(NULL,	"usb_host_hs_utmi_p1_clk",	&usb_host_hs_utmi_p1_clk,	CK_443X),
 	CLK(NULL,	"utmi_p2_gfclk",		&utmi_p2_gfclk,	CK_443X),
@@ -3209,8 +3209,8 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK(NULL,	"usb_host_hs_hsic480m_p2_clk",	&usb_host_hs_hsic480m_p2_clk,	CK_443X),
 	CLK(NULL,	"usb_host_hs_func48mclk",	&usb_host_hs_func48mclk,	CK_443X),
 	CLK(NULL,	"usb_host_hs_fck",		&usb_host_hs_fck,	CK_443X),
-	CLK("ehci-omap.0",	"hs_fck",		&usb_host_hs_fck,	CK_443X),
-	CLK("ehci-omap.0",	"usbhost_ick",		&dummy_ck,		CK_443X),
+	CLK("usbhs-omap.0",	"hs_fck",		&usb_host_hs_fck,	CK_443X),
+	CLK("usbhs-omap.0",	"usbhost_ick",		&dummy_ck,		CK_443X),
 	CLK(NULL,	"otg_60m_gfclk",		&otg_60m_gfclk,	CK_443X),
 	CLK(NULL,	"usb_otg_hs_xclk",		&usb_otg_hs_xclk,	CK_443X),
 	CLK("musb-omap2430",	"ick",				&usb_otg_hs_ick,	CK_443X),
@@ -3219,8 +3219,8 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK(NULL,	"usb_tll_hs_usb_ch0_clk",	&usb_tll_hs_usb_ch0_clk,	CK_443X),
 	CLK(NULL,	"usb_tll_hs_usb_ch1_clk",	&usb_tll_hs_usb_ch1_clk,	CK_443X),
 	CLK(NULL,	"usb_tll_hs_ick",		&usb_tll_hs_ick,	CK_443X),
-	CLK("ehci-omap.0",	"usbtll_ick",		&usb_tll_hs_ick,	CK_443X),
-	CLK("ehci-omap.0",	"usbtll_fck",		&dummy_ck,	CK_443X),
+	CLK("usbhs-omap.0",	"usbtll_ick",		&usb_tll_hs_ick,	CK_443X),
+	CLK("usbhs-omap.0",	"usbtll_fck",		&dummy_ck,	CK_443X),
 	CLK(NULL,	"usim_ck",			&usim_ck,	CK_443X),
 	CLK(NULL,	"usim_fclk",			&usim_fclk,	CK_443X),
 	CLK(NULL,	"usim_fck",			&usim_fck,	CK_443X),
-- 
1.6.0.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
