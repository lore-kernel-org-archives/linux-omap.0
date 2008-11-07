From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: [PATCH] OMAP: LCD: Use omap_rev check
Date: Fri, 7 Nov 2008 09:56:55 -0600
Message-ID: <A24693684029E5489D1D202277BE894413B3903C@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33913 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752620AbYKGQGE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Nov 2008 11:06:04 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "hyau@mvista.com" <hyau@mvista.com>

From: Sergio Aguirre <saaguirre@ti.com>

OMAP: LCD: Use omap_rev check

This patch fixes correct detection of OMAP revision for
LCD driver. This makes Tux look correct on my ES3 SDP board.

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
---
 drivers/video/omap/lcd_2430sdp.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-omap-2.6/drivers/video/omap/lcd_2430sdp.c
===================================================================
--- linux-omap-2.6.orig/drivers/video/omap/lcd_2430sdp.c
+++ linux-omap-2.6/drivers/video/omap/lcd_2430sdp.c
@@ -88,7 +88,7 @@ static int sdp2430_panel_enable(struct l
                grp_reg = TWL4030_VAUX3_DEV_GRP;
                grp_val = ENABLE_VAUX3_DEV_GRP;

-               if (system_rev > OMAP3430_REV_ES1_0) {
+               if (omap_rev() > OMAP3430_REV_ES1_0) {
                        t2_out(PM_RECEIVER, ENABLE_VPLL2_DEDICATED,
                                        TWL4030_VPLL2_DEDICATED);
                        t2_out(PM_RECEIVER, ENABLE_VPLL2_DEV_GRP,
@@ -116,7 +116,7 @@ static void sdp2430_panel_disable(struct
 {
        omap_set_gpio_dataout(enable_gpio, 0);
        omap_set_gpio_dataout(backlight_gpio, 0);
-       if (system_rev > OMAP3430_REV_ES1_0) {
+       if (omap_rev() > OMAP3430_REV_ES1_0) {
                t2_out(PM_RECEIVER, 0x0, TWL4030_VPLL2_DEDICATED);
                t2_out(PM_RECEIVER, 0x0, TWL4030_VPLL2_DEV_GRP);
                mdelay(4);

--
