From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [RFC] ARM: OMAP4: hwmod data: add HWMOD_SWSUP_SIDLE to dss_hdmi to data
Date: Sat, 16 Jun 2012 18:54:37 -0500
Message-ID: <1339890877-20129-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59871 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757213Ab2FPXzW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 16 Jun 2012 19:55:22 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: b-cousson@ti.com, tony@atomide.com, paul@pwsan.com, tomi.valkeinen@ti.com
Cc: s-guiriec@ti.com, mythripk@ti.com, linux-omap@vger.kernel.org, Ricardo Neri <ricardo.neri@ti.com>

I would like to revive an old discussion regarding how to use a particular
idle mode for a specific use-case[1].

As per the OMAP4 documentation, audio over HDMI should be transmitted in
no-idle mode. This patch adds the HWMOD_SWSUP_SIDLE so that omap_hwmode uses
no-idle/force-idle settings instead of smart-idle.

However, if this flag is used, smart-idle nor smart-idle wakeup-capable
features could not be used. This would not be ideal if we want, for instance,
to wake up using a HDMI cable connect event.

Ideally, the HDMI module should be set to no-idle when transmitting audio
and then go back to whatever mode it was (e.g., smart-idle) when audio
transmission is over. I am not sure how to do that, though.

In the past, it was suggested to use an integration function through
platform_data[2], which didn't seem to be  suitable from the device tree
perspective; although there were no other alternatives[3].

It was also suggested to add functions to allow/block smart-idle
momentarily[4], but how would the driver let know omap_hwmod when to
allow/block smart-idle without using platform_data/integration function?

Thanks for your comments!

Ricardo

[1].http://www.mail-archive.com/linux-omap@vger.kernel.org/msg60226.html
[2].http://www.mail-archive.com/linux-omap@vger.kernel.org/msg60236.html
[3].http://www.mail-archive.com/linux-omap@vger.kernel.org/msg60316.html
[4].http://www.mail-archive.com/linux-omap@vger.kernel.org/msg60252.html

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 950454a..3568b3b 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -865,6 +865,11 @@ static struct omap_hwmod omap44xx_dss_hdmi_hwmod = {
 	},
 	.opt_clks	= dss_hdmi_opt_clks,
 	.opt_clks_cnt	= ARRAY_SIZE(dss_hdmi_opt_clks),
+	/*
+	 * HDMI audio requires to not rely on smart idle and
+	 * use no-idle instead. Hence, set idle mode by software.
+	 */
+	.flags          = HWMOD_SWSUP_SIDLE,
 };
 
 /*
-- 
1.7.5.4

