From: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv3 04/41] OMAPDSS: get dssdev->alias from DT alias
Date: Tue, 21 Jan 2014 12:56:36 +0200
Message-ID: <1390301833-24944-5-git-send-email-tomi.valkeinen@ti.com>
References: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1390301833-24944-1-git-send-email-tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Archit Taneja <archit-l0cyMroinI0@public.gmane.org>, Darren Etheridge <detheridge-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Stefan Roese <stefan.roese-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sebastian Reichel <sre-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Dr . H . Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, Sebastian Reichel <sre-GFxCN5SEZAc@public.gmane.org>, Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>, Enric Balletbo Serra <eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

We currently create a "displayX" style alias name for all displays,
using a number that is incremented for each registered display. With the
new DSS device model there is no clear order in which the displays are
registered, and thus the numbering is somewhat random.

This patch improves the behavior for DT case so that if the displays
have been assigned DT aliases, those aliases will be used as DSS
aliases.

This means that "display0" is always the one specified in the DT alias,
and thus display0 can be used as default display in case the user didn't
specify a default display.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
---
 drivers/video/omap2/dss/display.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/dss/display.c b/drivers/video/omap2/dss/display.c
index 012ada38a29d..21080f9dae87 100644
--- a/drivers/video/omap2/dss/display.c
+++ b/drivers/video/omap2/dss/display.c
@@ -134,9 +134,24 @@ static int disp_num_counter;
 int omapdss_register_display(struct omap_dss_device *dssdev)
 {
 	struct omap_dss_driver *drv = dssdev->driver;
+	int id;
 
-	snprintf(dssdev->alias, sizeof(dssdev->alias),
-			"display%d", disp_num_counter++);
+	/*
+	 * Note: this presumes all the displays are either using DT or non-DT,
+	 * which normally should be the case. This also presumes that all
+	 * displays either have an DT alias, or none has.
+	 */
+
+	if (dssdev->dev->of_node) {
+		id = of_alias_get_id(dssdev->dev->of_node, "display");
+
+		if (id < 0)
+			id = disp_num_counter++;
+	} else {
+		id = disp_num_counter++;
+	}
+
+	snprintf(dssdev->alias, sizeof(dssdev->alias), "display%d", id);
 
 	/* Use 'label' property for name, if it exists */
 	if (dssdev->dev->of_node)
-- 
1.8.3.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
