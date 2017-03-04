From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v3 2/2] ARM: OMAP2+: Release device node after it is no longer needed.
Date: Sat,  4 Mar 2017 07:02:11 -0800
Message-ID: <1488639731-8047-2-git-send-email-linux@roeck-us.net>
References: <1488639731-8047-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1488639731-8047-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Qi Hou <qi.hou@windriver.com>, Peter Rosin <peda@axentia.se>, Rob Herring <robh@kernel.org>, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-omap@vger.kernel.org

The device node returned by of_find_node_by_name() needs to be released
after it is no longer needed to avoid a device node leak.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v3: Split patch into two parts

 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 44b5f9bbdde6..042e460f4aa4 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -3193,15 +3193,20 @@ int __init omap3xxx_hwmod_init(void)
 
 	if (h_sham && omap3xxx_hwmod_is_hs_ip_block_usable(bus, "sham")) {
 		r = omap_hwmod_register_links(h_sham);
-		if (r < 0)
+		if (r < 0) {
+			of_node_put(bus);
 			return r;
+		}
 	}
 
 	if (h_aes && omap3xxx_hwmod_is_hs_ip_block_usable(bus, "aes")) {
 		r = omap_hwmod_register_links(h_aes);
-		if (r < 0)
+		if (r < 0) {
+			of_node_put(bus);
 			return r;
+		}
 	}
+	of_node_put(bus);
 
 	/*
 	 * Register hwmod links specific to certain ES levels of a
-- 
2.7.4
