From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 2/2] ARM: AM43XX: HWMOD: Add rtc hwmod
Date: Fri, 19 Feb 2016 07:21:36 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1602190720490.27696@utopia.booyaka.com>
References: <1455856735-11515-1-git-send-email-j-keerthy@ti.com> <1455856735-11515-3-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455856735-11515-3-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, 19 Feb 2016, Keerthy wrote:

> The patch adds rtc hwmod. RTC module The RTC module is physically
> present on the AM438x SoC used on AM43X-EPOS-EVM, but it is permanently
> disabled. A secure RTC is used instead on these devices, where needed.
> . Hence adding it selectively using a seprate list to get RTC Module
> functional on the other am43x SoCs used on am437x-gp-evm and
> am437x-sk-evm.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
> 
> Changes in v2:
> 
> Inverted the checking logic to accommodate registering for all
> the SoCs compatible to am4372 and removed the negating am438x logic
> to register rtc hwmods as suggested by Paul.
> 
>  arch/arm/mach-omap2/omap_hwmod_43xx_data.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)

OK thanks; I've queued the following patch for v4.6 or if I get unlucky, 
v4.7.

- Paul

From: Keerthy <j-keerthy@ti.com>
Date: Fri, 19 Feb 2016 10:08:55 +0530
Subject: [PATCH] ARM: AM43XX: hwmod: Add rtc hwmod

The patch registers the rtc hwmod on AM437x chips.  The RTC module is
physically present on the AM438x SoC used on AM43X-EPOS-EVM, but it is
permanently disabled. A secure RTC is used instead on these devices,
where needed. Hence adding it selectively using a separate list to get
RTC Module functional on the other am43x SoCs used on am437x-gp-evm
and am437x-sk-evm.

Signed-off-by: Keerthy <j-keerthy@ti.com>
[paul@pwsan.com: cleaned up patch description]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
index e97a894b5f88..97fd399202dc 100644
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
2.7.0
