From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/2] ARM: OMAP3: Delete an unnecessary variable initialisation
 in omap3xxx_hwmod_init()
Date: Fri, 20 Oct 2017 17:17:31 +0200
Message-ID: <a69f8cfb-ef9e-6af3-1cf9-013cdb517c5a@users.sourceforge.net>
References: <ad74497a-9516-8a98-8deb-e6d5b752a898@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ad74497a-9516-8a98-8deb-e6d5b752a898@users.sourceforge.net>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Paul Walmsley <paul@pwsan.com>, Russell King <linux@armlinux.org.uk>, Tony Lindgren <tony@atomide.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 20 Oct 2017 16:37:07 +0200

The local variable "bus" will eventually be set to an appropriate pointer
a bit later. Thus omit the explicit initialisation at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index bb6eb1efb1b7..fd7db429e02b 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -3148,7 +3148,7 @@ int __init omap3xxx_hwmod_init(void)
 	int r;
 	struct omap_hwmod_ocp_if **h = NULL, **h_gp = NULL, **h_sham = NULL;
 	struct omap_hwmod_ocp_if **h_aes = NULL;
-	struct device_node *bus = NULL;
+	struct device_node *bus;
 	unsigned int rev;
 
 	omap_hwmod_init();
-- 
2.14.2
