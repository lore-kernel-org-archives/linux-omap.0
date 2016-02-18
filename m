From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 2/2] ARM: AM43XX: HWMOD: Add rtc hwmod
Date: Thu, 18 Feb 2016 10:59:41 +0530
Message-ID: <1455773381-11839-3-git-send-email-j-keerthy@ti.com>
References: <1455773381-11839-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455773381-11839-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org, Keerthy <j-keerthy@ti.com>
List-Id: linux-omap@vger.kernel.org

The patch adds rtc hwmod. RTC module The RTC module is physically
present on the AM438x SoC used on AM43X-EPOS-EVM, but it is permanently
disabled. A secure RTC is used instead on these devices, where needed.
. Hence adding it selectively using a seprate list to get RTC Module
functional on the other am43x SoCs used on am437x-gp-evm and
am437x-sk-evm.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---

No Public TRM is available for AM438x SoC as of now.

 arch/arm/mach-omap2/omap_hwmod_43xx_data.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
index e97a894..fcffaf8 100644
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
+	if (!(of_machine_is_compatible("ti,am438x")))
+		ret = omap_hwmod_register_links(am43xx_rtc_hwmod_ocp_ifs);
+
+	return ret;
 }
-- 
1.9.1
