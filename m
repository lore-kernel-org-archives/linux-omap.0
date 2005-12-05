From: Brian Swetland <swetland@google.com>
Subject: [PATCH] omapfb: panel enable/disable reordering
Date: Mon, 5 Dec 2005 05:49:05 -0800
Message-ID: <20051205134905.GA21963@localhost.localdomain>
References: <20051203034219.GA1516@localhost.localdomain>
	<1133786154.7902.11.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="EeQfGwPcQSOJBaQU"
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <1133786154.7902.11.camel@localhost.localdomain>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Imre Deak <imre.deak@nokia.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

[Imre Deak <imre.deak@nokia.com>]
> Actually there is no requirement on calling panel->enable() before
> omapfb_set_update_mode(), which enables the LCD DMA. It's even possible
> to enable / disable the panel while having the LCD DMA active.
> 
> So lets simply switch the order of the two calls in omapfb_probe and the
> suspend / resume functions. Please send a patch.

Sounds fine to me.

Here's such a patch.

Brian

--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="omapfb-init-order.patch"

diff --git a/drivers/video/omap/omapfb_main.c b/drivers/video/omap/omapfb_main.c
index 2c4098d..0eefec5 100644
--- a/drivers/video/omap/omapfb_main.c
+++ b/drivers/video/omap/omapfb_main.c
@@ -349,9 +349,9 @@ static int omapfb_blank(int blank, struc
 	switch (blank) {
 	case VESA_NO_BLANKING:
 		if (fbdev->state == OMAPFB_SUSPENDED) {
-			fbdev->panel->enable();
 			if (fbdev->ctrl->resume)
 				fbdev->ctrl->resume();
+			fbdev->panel->enable();
 			fbdev->state = OMAPFB_ACTIVE;
 			if (fbdev->ctrl->get_update_mode() ==
 					OMAPFB_MANUAL_UPDATE)
@@ -360,9 +360,9 @@ static int omapfb_blank(int blank, struc
 		break;
 	case VESA_POWERDOWN:
 		if (fbdev->state == OMAPFB_ACTIVE) {
+			fbdev->panel->disable();
 			if (fbdev->ctrl->suspend)
 				fbdev->ctrl->suspend();
-			fbdev->panel->disable();
 			fbdev->state = OMAPFB_SUSPENDED;
 		}
 		break;
@@ -1108,11 +1108,12 @@ static void omapfb_free_resources(struct
 	switch (state) {
 	case OMAPFB_ACTIVE:
 		unregister_framebuffer(fbdev->fb_info);
-	case 6:
+	case 7:
 		omapfb_unregister_sysfs(fbdev);
-		omapfb_set_update_mode(fbdev, OMAPFB_UPDATE_DISABLED);
-	case 5:
+	case 6:
 		fbdev->panel->disable();
+	case 5:
+		omapfb_set_update_mode(fbdev, OMAPFB_UPDATE_DISABLED);
 	case 4:
 		fbinfo_cleanup(fbdev);
 	case 3:
@@ -1296,11 +1297,6 @@ static int omapfb_probe(struct platform_
 	omap_set_dma_priority(OMAP_DMA_PORT_EMIFF, 15);
 #endif
 
-	r = fbdev->panel->enable();
-	if (r)
-		goto cleanup;
-	init_state++;
-
 	r = ctrl_change_mode(fbdev);
 	if (r) {
 		pr_err("mode setting failed\n");
@@ -1311,6 +1307,12 @@ static int omapfb_probe(struct platform_
 
 	omapfb_set_update_mode(fbdev, manual_update ?
 				   OMAPFB_MANUAL_UPDATE : OMAPFB_AUTO_UPDATE);
+	init_state++;
+
+	r = fbdev->panel->enable();
+	if (r)
+		goto cleanup;
+	init_state++;
 
 	r = omapfb_register_sysfs(fbdev);
 	if (r)

--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--EeQfGwPcQSOJBaQU--
