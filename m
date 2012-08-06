From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: v3.6-rc1 DSS issues/regression
Date: Tue, 7 Aug 2012 01:14:24 +0300
Message-ID: <20120806221424.GD1298@harshnoise.musicnaut.iki.fi>
References: <20120806164732.GB1298@harshnoise.musicnaut.iki.fi>
 <1344273868.12136.50.camel@deskari>
 <5020009C.1080308@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:46536 "EHLO
	filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755950Ab2HFWOj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Aug 2012 18:14:39 -0400
Content-Disposition: inline
In-Reply-To: <5020009C.1080308@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org

Hi,

On Mon, Aug 06, 2012 at 11:06:28PM +0530, Archit Taneja wrote:
> >On Mon, 2012-08-06 at 19:47 +0300, Aaro Koskinen wrote:
> >>I can't get the display on N900 (SDI, acx565akm) to work with v3.6-rc1
> >>kernel, it's just full of flicker/noise.
> >>
> >>According to git-bisect, the problem is introduced by the commit:
> >>
> >>     commit f476ae9dab3234532d41d36beb4ba7be838fa786
> >>     Author: Archit Taneja <archit@ti.com>
> >>     Date:   Fri Jun 29 14:37:03 2012 +0530
> >>
> >>     OMAPDSS: APPLY: Remove DISPC writes to manager's lcd parameters in interface

[...]

> The diff I have shared introduces the register writes back. This
> should make it work like before. But we need to figure out which
> parameter write needs to be done immediately. If this works, could
> you remove each dispc register write turn by turn, and point out
> which is the culprit one?

Thanks, the following one makes the display to work again:

diff --git a/drivers/video/omap2/dss/sdi.c b/drivers/video/omap2/dss/sdi.c
index 5d31699..3c9f598 100644
--- a/drivers/video/omap2/dss/sdi.c
+++ b/drivers/video/omap2/dss/sdi.c
@@ -46,6 +46,9 @@ static void sdi_config_lcd_manager(struct omap_dss_device *dssdev)
 	sdi.mgr_config.video_port_width = 24;
 	sdi.mgr_config.lcden_sig_polarity = 1;
 
+	dispc_mgr_set_clock_div(dssdev->manager->id,
+				&sdi.mgr_config.clock_info);
+
 	dss_mgr_set_lcd_config(dssdev->manager, &sdi.mgr_config);
 }
 
A.
