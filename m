From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 3/8] ARM: DRA7: hwmod: Add SYSCONFIG for usb_otg_ss
Date: Fri, 7 Mar 2014 15:09:06 +0200
Message-ID: <1394197751-28984-4-git-send-email-rogerq@ti.com>
References: <1394197751-28984-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1394197751-28984-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com, tony@atomide.com
Cc: kishon@ti.com, george.cherian@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-usb@vger.kernel.org, rogerq@ti.com
List-Id: linux-omap@vger.kernel.org

Add the sysconfig class bits for the Super Speed USB
controllers

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
index 3c9a430..cca24ad 100644
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -1752,8 +1752,20 @@ static struct omap_hwmod dra7xx_uart6_hwmod = {
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
