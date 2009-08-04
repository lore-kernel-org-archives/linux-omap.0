From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: DSS2 Video Overlay Scaling Patch
Date: Tue, 04 Aug 2009 14:06:15 +0300
Message-ID: <4A781627.2060405@nokia.com>
References: <84FF2D40FEDEB74A98203E6EA01A4E1C059446C7@de01exm63.ds.mot.com> <84FF2D40FEDEB74A98203E6EA01A4E1C059446CD@de01exm63.ds.mot.com> <84FF2D40FEDEB74A98203E6EA01A4E1C059446D0@de01exm63.ds.mot.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020506040700050409060509"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:32986 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751831AbZHDLGW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Aug 2009 07:06:22 -0400
In-Reply-To: <84FF2D40FEDEB74A98203E6EA01A4E1C059446D0@de01exm63.ds.mot.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Fischer Steven-P27614 <Steven.Fischer@motorola.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

This is a multi-part message in MIME format.
--------------020506040700050409060509
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

ext Fischer Steven-P27614 wrote:
> Ugh, messed up morning, forgot the patch as well :(
> 
> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Fischer
> Steven-P27614
> Sent: Tuesday, July 07, 2009 8:05 AM
> To: linux-omap@vger.kernel.org
> Subject: RE: DSS2 Video Overlay Scaling Patch
> 
> Sorry, missed the subject line.
> 
> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Fischer
> Steven-P27614
> Sent: Tuesday, July 07, 2009 7:54 AM
> To: linux-omap@vger.kernel.org
> Subject: 
> 
> All,
>  
> The DSS2 code base seems to inadvertently prevent downscaling of video
> overlay frames.  Attached is my attempt at a patch to resolve this
> issue.
>  
> As I gather from the code, there is an attempt to limit the overlay
> output frame size (x, y, outw, outh) to the managers updated window
> (mc->x, mc->y, mc->w, mc->h).  The problem is that the input frame size
> (w & h) is being used to instead of the output frame size (outw, outh).
> Due to this, when the input frame size is large than the output frame
> size, the input frame is being cropped, thus no downscaling occurs.  My
> patch corrects this issue and also attempts to properly scale the input
> frame size if indeed the output frame is cropped.
>  
> In my particular case, the output frame size is never cropped, so I have
> not explicitly tested these equations, but I believe they are
> mathematically correct.
>  
> With this patch overlay downscaling is functional.
>  

It was indeed slightly broken. The code is there because we cannot use 
partial update for scaled overlays, but we need to update the whole 
overlay. Otherwise there could be visual errors on the screen.

However, your patch didn't apply to my tree, and I think it can be 
solved in slightly more clear way. If the overlay in question is scaled, 
we don't even need to run that code. All we have to do is to adjust x/y 
depending on the x/y of the update area.

Here's a patch, can you check if it works for you?

  Tomi


--------------020506040700050409060509
Content-Type: text/x-patch;
 name="0001-DSS2-fix-downscaling-with-manual-update.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0001-DSS2-fix-downscaling-with-manual-update.patch"

>From 0bd1ee54051fa6b890a9a8b558f8f734ac0303e9 Mon Sep 17 00:00:00 2001
From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Date: Tue, 4 Aug 2009 13:59:54 +0300
Subject: [PATCH] DSS2: fix downscaling with manual update

Updating a downscaled overlay caused out_width/height to
be adjusted wrongly in certain cases.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
---
 drivers/video/omap2/dss/manager.c |   47 +++++++++++++++++++++---------------
 1 files changed, 27 insertions(+), 20 deletions(-)

diff --git a/drivers/video/omap2/dss/manager.c b/drivers/video/omap2/dss/manager.c
index 7b8e556..c77212b 100644
--- a/drivers/video/omap2/dss/manager.c
+++ b/drivers/video/omap2/dss/manager.c
@@ -755,29 +755,36 @@ static int configure_overlay(enum omap_plane plane)
 			BUG();
 		}
 
-		if (mc->x > c->pos_x) {
-			x = 0;
-			w -= (mc->x - c->pos_x);
-			paddr += (mc->x - c->pos_x) * bpp / 8;
-		} else {
+		if (dispc_is_overlay_scaled(c)) {
+			/* If the overlay is scaled, the update area has already been
+			 * enlarged to cover the whole overlay. We only need to adjust
+			 * x/y here */
 			x = c->pos_x - mc->x;
-		}
-
-		if (mc->y > c->pos_y) {
-			y = 0;
-			h -= (mc->y - c->pos_y);
-			paddr += (mc->y - c->pos_y) * c->screen_width * bpp / 8;
-		} else {
 			y = c->pos_y - mc->y;
-		}
+		} else {
+			if (mc->x > c->pos_x) {
+				x = 0;
+				w -= (mc->x - c->pos_x);
+				paddr += (mc->x - c->pos_x) * bpp / 8;
+			} else {
+				x = c->pos_x - mc->x;
+			}
+
+			if (mc->y > c->pos_y) {
+				y = 0;
+				h -= (mc->y - c->pos_y);
+				paddr += (mc->y - c->pos_y) * c->screen_width *
+					bpp / 8;
+			} else {
+				y = c->pos_y - mc->y;
+			}
 
-		if (mc->w < (x+w))
-			w -= (x+w) - (mc->w);
+			if (mc->w < (x+w))
+				w -= (x+w) - (mc->w);
 
-		if (mc->h < (y+h))
-			h -= (y+h) - (mc->h);
+			if (mc->h < (y+h))
+				h -= (y+h) - (mc->h);
 
-		if (!dispc_is_overlay_scaled(c)) {
 			outw = w;
 			outh = h;
 		}
-- 
1.6.3.2


--------------020506040700050409060509--
