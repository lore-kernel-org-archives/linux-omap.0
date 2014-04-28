From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 2/7] ARM: DRA7: hwmod: Add SYSCONFIG for usb_otg_ss
Date: Mon, 28 Apr 2014 17:01:22 +0300
Message-ID: <1398693687-13967-3-git-send-email-rogerq@ti.com>
References: <1398693687-13967-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1398693687-13967-1-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: george.cherian-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Add the sysconfig class bits for the Super Speed USB
controllers

Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
index 810c205..067d322 100644
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -1731,8 +1731,20 @@ static struct omap_hwmod dra7xx_uart6_hwmod = {
  *
  */
 
+static struct omap_hwmod_class_sysconfig dra7xx_usb_otg_ss_sysc = {
+	.rev_offs	= 0x0000,
+	.sysc_offs	= 0x0010,
+	.sysc_flags	= (SYSC_HAS_DMADISABLE | SYSC_HAS_MIDLEMODE |
+			   SYSC_HAS_SIDLEMODE),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
+			   SIDLE_SMART_WKUP | MSTANDBY_FORCE | MSTANDBY_NO |
+			   MSTANDBY_SMART | MSTANDBY_SMART_WKUP),
+	.sysc_fields	= &omap_hwmod_sysc_type2,
+};
+
 static struct omap_hwmod_class dra7xx_usb_otg_ss_hwmod_class = {
 	.name	= "usb_otg_ss",
+	.sysc	= &dra7xx_usb_otg_ss_sysc,
 };
 
 /* usb_otg_ss1 */
-- 
1.8.3.2

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
