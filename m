From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: dadd2bb931a08a4b6b17f9e82d9bbe7bedebbc98 breaks omapfb (old
 non-dss2)
Date: Wed, 16 Dec 2009 13:21:20 +0200
Message-ID: <1260962480.15771.1.camel@tubuntu.research.nokia.com>
References: <48239d390912150158xdf2999dr6b43f21c64456002@mail.gmail.com>
	 <1260890578.6017.11.camel@tubuntu.research.nokia.com>
	 <48239d390912150801y70da9d46k637c01d8da3a5595@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:61316 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754105AbZLPLVq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Dec 2009 06:21:46 -0500
In-Reply-To: <48239d390912150801y70da9d46k637c01d8da3a5595@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Sergey Lapin <slapinid@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Tue, 2009-12-15 at 17:01 +0100, ext Sergey Lapin wrote:
> On Tue, Dec 15, 2009 at 6:22 PM, Tomi Valkeinen
> <tomi.valkeinen@nokia.com> wrote:
> > Hi,
> >
> > On Tue, 2009-12-15 at 10:58 +0100, ext Sergey Lapin wrote:
> >> dadd2bb931a08a4b6b17f9e82d9bbe7bedebbc98
> >> OMAP: OMAPFB: add omapdss device
> >>
> >>     The upcoming new display subsystem driver is divided to two devices,
> >>     omapdss and omapfb, of which omapdss handles the actual hardware.
> >>
> >>     This patch adds a dummy omapdss platform device for the current omapfb
> >>     driver, which is then used to get the clocks. This will make it possible
> >>     for the current and the new display drivers to co-exist.
> >>
> >>     Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
> >>     Acked-by: Tony Lindgren <tony@atomide.com>
> >>
> >> breaks old omapfb.
> >
> > I didn't look at this further, but I quickly tested with OMAP3 SDP
> > board, reverting the patch that makes SDP use DSS2, and it seems to work
> > fine with the old omapfb.

rfbi.c was still using omapfb device to get the clocks. Can you try this
patch?


>From 33b78006fb0387e21d5f780338d821621ecad929 Mon Sep 17 00:00:00 2001
From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Date: Wed, 16 Dec 2009 13:18:07 +0200
Subject: [PATCH] OMAP: OMAPFB: fix clk_get for RFBI

omapfb platform device was still used to get clocks inside rfbi.c

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
---
 drivers/video/omap/dispc.c  |    2 +-
 drivers/video/omap/omapfb.h |    2 ++
 drivers/video/omap/rfbi.c   |    4 ++--
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/video/omap/dispc.c b/drivers/video/omap/dispc.c
index c7c6455..e40146a 100644
--- a/drivers/video/omap/dispc.c
+++ b/drivers/video/omap/dispc.c
@@ -189,7 +189,7 @@ static struct {
 	struct omapfb_color_key	color_key;
 } dispc;
 
-static struct platform_device omapdss_device = {
+struct platform_device omapdss_device = {
 	.name		= "omapdss",
 	.id		= -1,
 };
diff --git a/drivers/video/omap/omapfb.h b/drivers/video/omap/omapfb.h
index 46e4714..0a4988e 100644
--- a/drivers/video/omap/omapfb.h
+++ b/drivers/video/omap/omapfb.h
@@ -224,4 +224,6 @@ extern int  omapfb_update_window_async(struct fb_info *fbi,
 				       void (*callback)(void *),
 				       void *callback_data);
 
+extern struct platform_device omapdss_device;
+
 #endif /* __OMAPFB_H */
diff --git a/drivers/video/omap/rfbi.c b/drivers/video/omap/rfbi.c
index fed7b1b..36af8ba 100644
--- a/drivers/video/omap/rfbi.c
+++ b/drivers/video/omap/rfbi.c
@@ -83,13 +83,13 @@ static inline u32 rfbi_read_reg(int idx)
 
 static int rfbi_get_clocks(void)
 {
-	rfbi.dss_ick = clk_get(rfbi.fbdev->dev, "ick");
+	rfbi.dss_ick = clk_get(&omapdss_device.dev, "ick");
 	if (IS_ERR(rfbi.dss_ick)) {
 		dev_err(rfbi.fbdev->dev, "can't get ick\n");
 		return PTR_ERR(rfbi.dss_ick);
 	}
 
-	rfbi.dss1_fck = clk_get(rfbi.fbdev->dev, "dss1_fck");
+	rfbi.dss1_fck = clk_get(&omapdss_device.dev, "dss1_fck");
 	if (IS_ERR(rfbi.dss1_fck)) {
 		dev_err(rfbi.fbdev->dev, "can't get dss1_fck\n");
 		clk_put(rfbi.dss_ick);
-- 
1.6.3.3






