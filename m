From: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 2/2] ARM: AM43XX: HWMOD: Add rtc hwmod
Date: Fri, 19 Feb 2016 10:08:55 +0530
Message-ID: <1455856735-11515-3-git-send-email-j-keerthy@ti.com>
References: <1455856735-11515-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1455856735-11515-1-git-send-email-j-keerthy-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The patch adds rtc hwmod. RTC module The RTC module is physically
present on the AM438x SoC used on AM43X-EPOS-EVM, but it is permanently
disabled. A secure RTC is used instead on these devices, where needed.
. Hence adding it selectively using a seprate list to get RTC Module
functional on the other am43x SoCs used on am437x-gp-evm and
am437x-sk-evm.

Signed-off-by: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
---

Changes in v2:

Inverted the checking logic to accommodate registering for all
the SoCs compatible to am4372 and removed the negating am438x logic
to register rtc hwmods as suggested by Paul.

 arch/arm/mach-omap2/omap_hwmod_43xx_data.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
index e97a894..97fd399 100644
--- a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
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
+	if (!ret && of_machine_is_compatible("ti,am4372"))
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
