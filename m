From: "Y, Kishore" <kishore.y@ti.com>
Subject: [PATCH] OMAP:DSS: Add missing line for update bg color
Date: Sun, 25 Apr 2010 16:23:35 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E94026F6E2B94@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54495 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753398Ab0DYKwV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 25 Apr 2010 06:52:21 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

From: Carlos Lopez <carlos.cruz@sasken.com>

The driver set the background color canvas but never writes it in
DISPC_DEFAULT_COLOR_m register, which changes the background color
on the LCD or TV.

This patch adds a line to call to dispc_set_default_color() which is
the function in charge to write the DISPC_DEFAULT_COLOR_m register.

Signed-off-by: Carlos Lopez <carlos.cruz@sasken.com>
---
 drivers/video/omap2/dss/manager.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/manager.c b/drivers/video/omap2/dss/manager.c
index c12fa14..72d53eb 100644
--- a/drivers/video/omap2/dss/manager.c
+++ b/drivers/video/omap2/dss/manager.c
@@ -845,6 +845,7 @@ static void configure_manager(enum omap_channel channel)
 
 	c = &dss_cache.manager_cache[channel];
 
+	dispc_set_default_color(channel, c->default_color);
 	dispc_set_trans_key(channel, c->trans_key_type, c->trans_key);
 	dispc_enable_trans_key(channel, c->trans_enabled);
 	dispc_enable_alpha_blending(channel, c->alpha_enabled);
-- 
1.5.6.3


Regards,
Kishore Y
