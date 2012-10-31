From: Keshava Munegowda <keshava_mgowda@ti.com>
Subject: [PATCH 09/11] ARM: OMAP: USB: Remove the device name for TLL channel clocks for OMAP3
Date: Wed, 31 Oct 2012 17:46:47 +0530
Message-ID: <1351685810-20616-10-git-send-email-keshava_mgowda@ti.com>
References: <1351685810-20616-1-git-send-email-keshava_mgowda@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1351685810-20616-1-git-send-email-keshava_mgowda@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-usb@vger.kernel.org
Cc: Keshava Munegowda <keshava_mgowda@ti.com>, balbi@ti.com, sameo@linux.intel.com
List-Id: linux-omap@vger.kernel.org

Since TLL channels clocks are dummy(virtual) nodes for OMAP3.
The device names for these clocks are set to NULL.

Signed-off-by: Keshava Munegowda <keshava_mgowda@ti.com>
---
 arch/arm/mach-omap2/clock3xxx_data.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index 6cca199..c63c818 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -3404,10 +3404,8 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK(NULL,	"xclk60mhsp2_ck",	&dummy_ck,	CK_3XXX),
 	CLK(NULL,	"usb_host_hs_utmi_p1_clk",	&dummy_ck,	CK_3XXX),
 	CLK(NULL,	"usb_host_hs_utmi_p2_clk",	&dummy_ck,	CK_3XXX),
-	CLK("usbhs_omap",	"usb_tll_hs_usb_ch0_clk",	&dummy_ck,	CK_3XXX),
-	CLK("usbhs_omap",	"usb_tll_hs_usb_ch1_clk",	&dummy_ck,	CK_3XXX),
-	CLK("usbhs_tll",	"usb_tll_hs_usb_ch0_clk",	&dummy_ck,	CK_3XXX),
-	CLK("usbhs_tll",	"usb_tll_hs_usb_ch1_clk",	&dummy_ck,	CK_3XXX),
+	CLK(NULL,	"usb_tll_hs_usb_ch0_clk",	&dummy_ck,	CK_3XXX),
+	CLK(NULL,	"usb_tll_hs_usb_ch1_clk",	&dummy_ck,	CK_3XXX),
 	CLK(NULL,	"init_60m_fclk",	&dummy_ck,	CK_3XXX),
 	CLK(NULL,	"usim_fck",	&usim_fck,	CK_3430ES2PLUS | CK_36XX),
 	CLK(NULL,	"gpt1_fck",	&gpt1_fck,	CK_3XXX),
-- 
1.7.9.5

