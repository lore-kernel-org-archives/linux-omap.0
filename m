From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: [PATCH 20/23] OMAP2: DSS: Add missing line for update bg color
Date: Tue, 18 May 2010 15:35:11 +0300
Message-ID: <1274186114-26951-21-git-send-email-tomi.valkeinen@nokia.com>
References: <1274186114-26951-1-git-send-email-tomi.valkeinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:57954 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757559Ab0ERMgc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 May 2010 08:36:32 -0400
In-Reply-To: <1274186114-26951-1-git-send-email-tomi.valkeinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org
Cc: Carlos Lopez <carlos.cruz@sasken.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>

From: Carlos Lopez <carlos.cruz@sasken.com>

The driver set the background color canvas but never writes it in
DISPC_DEFAULT_COLOR_m register, which changes the background color
on the LCD or TV.

This patch adds a line to call to dispc_set_default_color() which is
the function in charge to write the DISPC_DEFAULT_COLOR_m register.

Signed-off-by: Carlos Lopez <carlos.cruz@sasken.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
---
 drivers/video/omap2/dss/manager.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/manager.c b/drivers/video/omap2/dss/manager.c
index 32ec2ff..9e1fbe5 100644
--- a/drivers/video/omap2/dss/manager.c
+++ b/drivers/video/omap2/dss/manager.c
@@ -843,6 +843,7 @@ static void configure_manager(enum omap_channel channel)
 
 	c = &dss_cache.manager_cache[channel];
 
+	dispc_set_default_color(channel, c->default_color);
 	dispc_set_trans_key(channel, c->trans_key_type, c->trans_key);
 	dispc_enable_trans_key(channel, c->trans_enabled);
 	dispc_enable_alpha_blending(channel, c->alpha_enabled);
-- 
1.7.0.4

