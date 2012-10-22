From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH 0/9] OMAPDSS: minor fixes & cleanups
Date: Mon, 22 Oct 2012 11:18:45 +0530
Message-ID: <5084DE3D.1050502@ti.com>
References: <1350472835-28727-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51543 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753999Ab2JVFs5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Oct 2012 01:48:57 -0400
In-Reply-To: <1350472835-28727-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Wednesday 17 October 2012 04:50 PM, Tomi Valkeinen wrote:
> Hi,
>
> This series contains minor cleanups and fixes for omapdss.

This series looks fine to me. I have a related cleanup patch which you 
may consider adding to the series.

Thanks,
Archit

From: Archit Taneja <archit@ti.com>
Date: Thu, 18 Oct 2012 16:51:57 +0530
Subject: [PATCH] OMAPDSS: Remove acb and acbi fields from omap_dss_device

acbi and acb fields were meant for passive matrix panels which omapdss 
doesn't
support any longer. Remove these fields from omap_dss_device struct.

Signed-off-by: Archit Taneja <archit@ti.com>
---
  include/video/omapdss.h |    4 ----
  1 file changed, 4 deletions(-)

diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 88c8294..f39e6aa 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -621,10 +621,6 @@ struct omap_dss_device {
  	struct {
  		struct omap_video_timings timings;

-		int acbi;	/* ac-bias pin transitions per interrupt */
-		/* Unit: line clocks */
-		int acb;	/* ac-bias pin frequency */
-
  		enum omap_dss_dsi_pixel_format dsi_pix_fmt;
  		enum omap_dss_dsi_mode dsi_mode;
  		struct omap_dss_dsi_videomode_timings dsi_vm_timings;
-- 
1.7.9.5
