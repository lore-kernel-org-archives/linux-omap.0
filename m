From: Ben Tucker <btucker@mpcdata.com>
Subject: RE: OMAP DSS Enable clocks in dss_setup_partial_planes
Date: Wed, 12 Jan 2011 11:20:18 -0000
Message-ID: <93718b46f4f9309fb4b87599040a432f@mail.gmail.com>
References: b3985d3b9ab26a0aac963651376b21ac@mail.gmail.com
 <fd876042b2837b7dd3eaea2257dcbd6f@mail.gmail.com>	 <1294413238.3968.110.camel@nubuntu>
	 <78677181845a6577fe0955a1984ac16a@mail.gmail.com>	 <c08bf1989fbe2e704960116748c416f3@mail.gmail.com>
 <1294823658.4156.18.camel@tubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:39444 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751901Ab1ALLUX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Jan 2011 06:20:23 -0500
Received: by iyj18 with SMTP id 18so388245iyj.19
        for <linux-omap@vger.kernel.org>; Wed, 12 Jan 2011 03:20:22 -0800 (PST)
In-Reply-To: <1294823658.4156.18.camel@tubuntu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: linux-omap@vger.kernel.org

> -----Original Message-----
> From: Tomi Valkeinen [mailto:tomi.valkeinen@nokia.com]
> Sent: 12 January 2011 09:14
> To: ext Ben Tucker
> Cc: linux-omap@vger.kernel.org
> Subject: Re: OMAP DSS Enable clocks in dss_setup_partial_planes
>
> Hi,
>
> On Tue, 2011-01-11 at 17:41 +0000, ext Ben Tucker wrote:
> > From 086e3454c8f154cd90a4669899f2179f16ef32cd Mon Sep 17 00:00:00
> 2001
> > From: Ben Tucker <btucker@mpc-data.co.uk>
> > Date: Thu, 13 Jan 2011 12:56:45 +0000
> > Subject: [PATCH] OMAP DSS Enable clocks in dss_setup_partial_planes
> >  Enable the interface clocks while calling>
> >  >  configure_dispc().
>
> This description doesn't really tell anything which isn't selfevident
> from the code below. Please check
> http://who-t.blogspot.com/2009/12/on-commit-messages.html
>
> But I presume this is about RFBI. If so, correct place to enable the
> clocks would be in rfbi.c.
>
>  Tomi
>

Apologies for the commit message. Updated patch below.

Are you sure the code to enable clocks should be placed in rfbi.c? The DSI
code (dsi.c) uses dss_setup_partial_planes() in the same way as rfbi.c and
there is no clock enable code there. Also omap_dss_mgr_apply() within
manager.c enables clocks for the configure_dispc() call.

	Ben


>From fac7afefc4f80c3045ce73bb34e24a037ed26edc Mon Sep 17 00:00:00 2001
From: Ben Tucker <btucker@mpc-data.co.uk>
Date: Sat, 15 Jan 2011 07:18:49 +0000
Subject: [PATCH] OMAP2,3: DSS2: Enable clocks in dss_setup_partial_planes

Fix a deadly bus halt when using RFBI or DSI interfaced panels
due to access to the OMAP DSS subsystem while interface and
peripheral clocks are disabled.
Resolved by enabling the clocks while calling the
configure_dispc() in dss_setup_partial_planes().
---
 drivers/video/omap2/dss/manager.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/manager.c
b/drivers/video/omap2/dss/manager.c
index 545e9b9..cb90dac 100644
--- a/drivers/video/omap2/dss/manager.c
+++ b/drivers/video/omap2/dss/manager.c
@@ -1106,7 +1106,9 @@ void dss_setup_partial_planes(struct omap_dss_device
*dssdev,
        mc->w = w;
        mc->h = h;

+       dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK1);
        configure_dispc();
+       dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK1);

        mc->do_manual_update = false;

--
1.7.3.2
