From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 7/8] omapfb: Blizzard: fix pointer to be const
Date: Fri, 02 Oct 2009 15:45:37 -0700
Message-ID: <20091002224537.11962.13995.stgit@localhost>
References: <20091002223510.11962.21751.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:56753 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754791AbZJBWpe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Oct 2009 18:45:34 -0400
In-Reply-To: <20091002223510.11962.21751.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Imre Deak <imre.deak@nokia.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>, Tommi Rantala <tt.rantala@gmail.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org

From: Tommi Rantala <tt.rantala@gmail.com>

Fixes a compiler warning:
warning: assignment discards qualifiers from pointer target type

Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: Imre Deak <imre.deak@nokia.com>
Signed-off-by: Tommi Rantala <tt.rantala@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/video/omap/blizzard.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap/blizzard.c b/drivers/video/omap/blizzard.c
index d5e5955..ce28be6 100644
--- a/drivers/video/omap/blizzard.c
+++ b/drivers/video/omap/blizzard.c
@@ -191,7 +191,7 @@ struct blizzard_struct {
 
 	struct omapfb_device	*fbdev;
 	struct lcd_ctrl_extif	*extif;
-	struct lcd_ctrl		*int_ctrl;
+	const struct lcd_ctrl	*int_ctrl;
 
 	void			(*power_up)(struct device *dev);
 	void			(*power_down)(struct device *dev);

