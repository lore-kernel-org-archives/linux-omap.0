From: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 5/6] ARM: AM43XX: HWMOD: Add rtc hwmod
Date: Mon, 10 Aug 2015 14:58:25 +0530
Message-ID: <1439198906-31189-6-git-send-email-j-keerthy@ti.com>
References: <1439198906-31189-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1439198906-31189-1-git-send-email-j-keerthy-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org
Cc: galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org, j-keerthy-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

The patch adds rtc hwmod. This is present on gp and sk evm and not on
epos evm. Hence adding it selectively using a seprate list.

Signed-off-by: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
index 215d5ef..a0850b9 100644
--- a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
@@ -21,7 +21,7 @@
 #include "prcm43xx.h"
 #include "omap_hwmod_common_data.h"
 #include "hdq1w.h"
-
+#include "soc.h"
 
 /* IP blocks */
 static struct omap_hwmod am43xx_emif_hwmod = {
@@ -1020,9 +1020,21 @@ static struct omap_hwmod_ocp_if *am43xx_hwmod_ocp_ifs[] __initdata = {
 	NULL,
 };
 
+static struct omap_hwmod_ocp_if *am43xx_rtc_hwmod_ocp_ifs[] __initdata = {
+	&am33xx_l4_wkup__rtc,
+	NULL,
+};
+
 int __init am43xx_hwmod_init(void)
 {
+	int ret;
+
 	omap_hwmod_am43xx_reg();
 	omap_hwmod_init();
-	return omap_hwmod_register_links(am43xx_hwmod_ocp_ifs);
+	ret = omap_hwmod_register_links(am43xx_hwmod_ocp_ifs);
+
+	if (!soc_is_am438x())
+		ret = omap_hwmod_register_links(am43xx_rtc_hwmod_ocp_ifs);
+
+	return ret;
 }
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
