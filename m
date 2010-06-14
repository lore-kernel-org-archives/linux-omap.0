From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH] omap: mux: Add api to retrieve padconf offset based on
     muxname
Date: Mon, 14 Jun 2010 19:43:19 +0530 (IST)
Message-ID: <48791.192.168.10.88.1276524799.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53124 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753276Ab0FNONV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 Jun 2010 10:13:21 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>

Adds a padconf offset retrieval api which will
get us the padconf offset based on muxname provided
which can be later used with omap_ctrl_writew,
omap_ctrl_readw calls for remuxing signals.

Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
Patch is based on earlier discussion with Tony
http://marc.info/?l=linux-omap&m=127609369220618&w=2

 arch/arm/mach-omap2/mux.c |   17 +++++++++++++++++
 arch/arm/mach-omap2/mux.h |    6 ++++++
 2 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 8b3d269..afe45ce 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -882,6 +882,23 @@ free:

 #endif	/* CONFIG_OMAP_MUX */

+u16 omap_mux_request_signal(char *muxname)
+{
+	struct omap_mux_entry *e;
+	u16 offset = -EINVAL;
+
+	list_for_each_entry(e, &muxmodes, node) {
+		struct omap_mux *m = &e->mux;
+		char *m0_entry = m->muxnames[0];
+
+		if (!strcmp(muxname, m0_entry)) {
+			offset = m->reg_offset + OMAP_MUX_BASE_OFFSET;
+			break;
+		}
+	}
+	return offset;
+}
+
 static u16 omap_mux_get_by_gpio(int gpio)
 {
 	struct omap_mux_entry *e;
diff --git a/arch/arm/mach-omap2/mux.h b/arch/arm/mach-omap2/mux.h
index 480abc5..dc5e121 100644
--- a/arch/arm/mach-omap2/mux.h
+++ b/arch/arm/mach-omap2/mux.h
@@ -132,6 +132,12 @@ static inline int omap_mux_init_signal(char *muxname, int val)
 #endif

 /**
+ * omap_mux_request_signal - get mux register offset based on mux name
+ * @muxname: Mux name in mode0_name.signal_name format
+ */
+u16 omap_mux_request_signal(char *muxname);
+
+/**
  * omap_mux_get_gpio() - get mux register value based on GPIO number
  * @gpio:		GPIO number
  *
-- 
1.6.3.3


