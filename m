From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/2] ARM: OMAP3: Use common error handling code in
 omap3xxx_hwmod_init()
Date: Fri, 20 Oct 2017 17:16:23 +0200
Message-ID: <44cbf405-a2ef-0965-00df-c8d4a5aa6950@users.sourceforge.net>
References: <ad74497a-9516-8a98-8deb-e6d5b752a898@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <ad74497a-9516-8a98-8deb-e6d5b752a898@users.sourceforge.net>
Content-Language: en-GB
Sender: kernel-janitors-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Paul Walmsley <paul@pwsan.com>, Russell King <linux@armlinux.org.uk>, Tony Lindgren <tony@atomide.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 20 Oct 2017 16:30:23 +0200

Add a jump target so that a bit of exception handling can be better reused
at the end of this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index c3276436b0ae..bb6eb1efb1b7 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -3208,18 +3208,14 @@ int __init omap3xxx_hwmod_init(void)
 
 	if (h_sham && omap3xxx_hwmod_is_hs_ip_block_usable(bus, "sham")) {
 		r = omap_hwmod_register_links(h_sham);
-		if (r < 0) {
-			of_node_put(bus);
-			return r;
-		}
+		if (r < 0)
+			goto put_node;
 	}
 
 	if (h_aes && omap3xxx_hwmod_is_hs_ip_block_usable(bus, "aes")) {
 		r = omap_hwmod_register_links(h_aes);
-		if (r < 0) {
-			of_node_put(bus);
-			return r;
-		}
+		if (r < 0)
+			goto put_node;
 	}
 	of_node_put(bus);
 
@@ -3270,4 +3266,8 @@ int __init omap3xxx_hwmod_init(void)
 	r = omap_hwmod_register_links(omap3xxx_dss_hwmod_ocp_ifs);
 
 	return r;
+
+put_node:
+	of_node_put(bus);
+	return r;
 }
-- 
2.14.2

