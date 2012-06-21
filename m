From: Russ Dill <Russ.Dill@ti.com>
Subject: [PATCH 2/2] ARM: OMAP: USB: Fix omap3xxx EHCI regression caused by i693 errata fix.
Date: Thu, 21 Jun 2012 03:44:32 -0700
Message-ID: <1340275473-16374-2-git-send-email-Russ.Dill@ti.com>
References: <CA+Bv8XZ-g26_3Hv9xgDvwRooUeZwaKtZJwvnxxEZHcFx06es7Q@mail.gmail.com>
 <1340275473-16374-1-git-send-email-Russ.Dill@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:33237 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753643Ab2FUKoq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Jun 2012 06:44:46 -0400
In-Reply-To: <1340275473-16374-1-git-send-email-Russ.Dill@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Anand Gadiyar <gadiyar@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vikram Pandita <vikram.pandita@ti.com>, Volodymyr Mieshkov <x0182794@ti.com>, Alan Stern <stern@rowland.harvard.edu>, yan-liu@ti.com, aparnab@ti.com, Russ Dill <Russ.Dill@ti.com>

[PATCH] Fix OMAP EHCI suspend/resume failure (i693) '354ab856' causes
an oops on boot for all omap3xxx platforms that use usbhs_omap for
EHCI. The actual oops comes from faulty ehci-omap cleanup, but the
failure caused by the change is evidenced here:

[    3.655059] ehci-omap ehci-omap.0: utmi_p1_gfclk failed error:-2
[    3.661376] ehci-omap: probe of ehci-omap.0 failed with error -2

utmi_p1_gfclk is a clock that exists on OMAP4, but not OMAP3. In the
OMAP3 case, it is configured as a dummy clock. However, OMAP4 lists
the dev_id as NULL, but OMAP3 lists it as "usbhs_omap".

Attempting to get that clock from ehci-omap then fails. The solution
is to just change the clock3xxx_data.c for dummy clocks used in the
errata fix to match the dev_id, NULL, used in clock44xx_data.c.

Tested on BB-xM.

Signed-off-by: Russ Dill <Russ.Dill@ti.com>
---
 arch/arm/mach-omap2/clock3xxx_data.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index 4e1a3b0..59d5315 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -3391,15 +3391,15 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK(NULL,	"usbhost_48m_fck", &usbhost_48m_fck, CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
 	CLK(NULL,	"usbhost_ick",	&usbhost_ick,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
 	CLK("usbhs_omap",	"usbhost_ick",	&usbhost_ick,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
-	CLK("usbhs_omap",	"utmi_p1_gfclk",	&dummy_ck,	CK_3XXX),
-	CLK("usbhs_omap",	"utmi_p2_gfclk",	&dummy_ck,	CK_3XXX),
-	CLK("usbhs_omap",	"xclk60mhsp1_ck",	&dummy_ck,	CK_3XXX),
-	CLK("usbhs_omap",	"xclk60mhsp2_ck",	&dummy_ck,	CK_3XXX),
-	CLK("usbhs_omap",	"usb_host_hs_utmi_p1_clk",	&dummy_ck,	CK_3XXX),
-	CLK("usbhs_omap",	"usb_host_hs_utmi_p2_clk",	&dummy_ck,	CK_3XXX),
+	CLK(NULL,	"utmi_p1_gfclk",	&dummy_ck,	CK_3XXX),
+	CLK(NULL,	"utmi_p2_gfclk",	&dummy_ck,	CK_3XXX),
+	CLK(NULL,	"xclk60mhsp1_ck",	&dummy_ck,	CK_3XXX),
+	CLK(NULL,	"xclk60mhsp2_ck",	&dummy_ck,	CK_3XXX),
+	CLK(NULL,	"usb_host_hs_utmi_p1_clk",	&dummy_ck,	CK_3XXX),
+	CLK(NULL,	"usb_host_hs_utmi_p2_clk",	&dummy_ck,	CK_3XXX),
 	CLK("usbhs_omap",	"usb_tll_hs_usb_ch0_clk",	&dummy_ck,	CK_3XXX),
 	CLK("usbhs_omap",	"usb_tll_hs_usb_ch1_clk",	&dummy_ck,	CK_3XXX),
-	CLK("usbhs_omap",	"init_60m_fclk",	&dummy_ck,	CK_3XXX),
+	CLK(NULL,	"init_60m_fclk",	&dummy_ck,	CK_3XXX),
 	CLK(NULL,	"usim_fck",	&usim_fck,	CK_3430ES2PLUS | CK_36XX),
 	CLK(NULL,	"gpt1_fck",	&gpt1_fck,	CK_3XXX),
 	CLK(NULL,	"wkup_32k_fck",	&wkup_32k_fck,	CK_3XXX),
-- 
1.7.10.4

