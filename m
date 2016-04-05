From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 3/4] ARM: DRA7: hwmod: Add data for GPTimer 12
Date: Tue, 5 Apr 2016 16:44:11 -0500
Message-ID: <1459892652-47845-4-git-send-email-s-anna@ti.com>
References: <1459892652-47845-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1459892652-47845-1-git-send-email-s-anna-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Add the hwmod data for GPTimer 12. GPTimer 12 is present in
WKUPAON power domain and is clocked from a secure 32K clock.
GPTimer 12 serves as a secure timer on HS devices, but is
available for kernel on regular GP devices.

The hwmod link is registered only on GP devices. The hwmod data
also reused the existing timer class instead of reintroducing
the identical dra7xx_timer_secure_sysc class which was dropped
in commit edec17863362 ("ARM: DRA7: hwmod: Fix the hwmod class
for GPTimer4").

Cc: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 36 +++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
index 9442d89bd229..527c7c859e41 100644
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -2065,6 +2065,20 @@ static struct omap_hwmod dra7xx_timer11_hwmod = {
 	},
 };
 
+/* timer12 */
+static struct omap_hwmod dra7xx_timer12_hwmod = {
+	.name		= "timer12",
+	.class		= &dra7xx_timer_hwmod_class,
+	.clkdm_name	= "wkupaon_clkdm",
+	.main_clk	= "secure_32k_clk_src_ck",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = DRA7XX_CM_WKUPAON_TIMER12_CLKCTRL_OFFSET,
+			.context_offs = DRA7XX_RM_WKUPAON_TIMER12_CONTEXT_OFFSET,
+		},
+	},
+};
+
 /* timer13 */
 static struct omap_hwmod dra7xx_timer13_hwmod = {
 	.name		= "timer13",
@@ -3281,6 +3295,14 @@ static struct omap_hwmod_ocp_if dra7xx_l4_per1__timer11 = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+/* l4_wkup -> timer12 */
+static struct omap_hwmod_ocp_if dra7xx_l4_wkup__timer12 = {
+	.master		= &dra7xx_l4_wkup_hwmod,
+	.slave		= &dra7xx_timer12_hwmod,
+	.clk		= "wkupaon_iclk_mux",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 /* l4_per3 -> timer13 */
 static struct omap_hwmod_ocp_if dra7xx_l4_per3__timer13 = {
 	.master		= &dra7xx_l4_per3_hwmod,
@@ -3580,6 +3602,13 @@ static struct omap_hwmod_ocp_if *dra7xx_hwmod_ocp_ifs[] __initdata = {
 	NULL,
 };
 
+/* GP-only hwmod links */
+static struct omap_hwmod_ocp_if *dra7xx_gp_hwmod_ocp_ifs[] __initdata = {
+	&dra7xx_l4_wkup__timer12,
+	NULL,
+};
+
+/* SoC variant specific hwmod links */
 static struct omap_hwmod_ocp_if *dra74x_hwmod_ocp_ifs[] __initdata = {
 	&dra7xx_l4_per3__usb_otg_ss4,
 	NULL,
@@ -3597,9 +3626,12 @@ int __init dra7xx_hwmod_init(void)
 	ret = omap_hwmod_register_links(dra7xx_hwmod_ocp_ifs);
 
 	if (!ret && soc_is_dra74x())
-		return omap_hwmod_register_links(dra74x_hwmod_ocp_ifs);
+		ret = omap_hwmod_register_links(dra74x_hwmod_ocp_ifs);
 	else if (!ret && soc_is_dra72x())
-		return omap_hwmod_register_links(dra72x_hwmod_ocp_ifs);
+		ret = omap_hwmod_register_links(dra72x_hwmod_ocp_ifs);
+
+	if (!ret && omap_type() == OMAP2_DEVICE_TYPE_GP)
+		ret = omap_hwmod_register_links(dra7xx_gp_hwmod_ocp_ifs);
 
 	return ret;
 }
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
