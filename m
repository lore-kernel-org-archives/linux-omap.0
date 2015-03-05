From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH 2/4] ARM: OMAP2+: AM43xx hwmod: Add RTC hwmod for AM43xx
Date: Thu, 5 Mar 2015 07:13:29 -0600
Message-ID: <1425561211-31003-3-git-send-email-d-gerlach@ti.com>
References: <1425561211-31003-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36006 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754706AbbCENOK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 5 Mar 2015 08:14:10 -0500
In-Reply-To: <1425561211-31003-1-git-send-email-d-gerlach@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, KEERTHY <j-keerthy@ti.com>, Dave Gerlach <d-gerlach@ti.com>

RTC hwmod is needed for proper operation of PM features like
rtcwake and rtc-only mode so reuse the am33xx rtc hwmod.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
index 8eb8592..9070535 100644
--- a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
@@ -889,6 +889,7 @@ static struct omap_hwmod_ocp_if *am43xx_hwmod_ocp_ifs[] __initdata = {
 	&am43xx_l4_ls__dss,
 	&am43xx_l4_ls__dss_dispc,
 	&am43xx_l4_ls__dss_rfbi,
+	&am33xx_l4_wkup__rtc,
 	NULL,
 };
 
-- 
2.3.0

