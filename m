From: "Taneja, Archit" <archit@ti.com>
Subject: RE: OMAP DSS Enable clocks in dss_setup_partial_planes
Date: Thu, 20 Jan 2011 15:28:09 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC356087035F9246DA@dbde02.ent.ti.com>
References: b3985d3b9ab26a0aac963651376b21ac@mail.gmail.com
  <fd876042b2837b7dd3eaea2257dcbd6f@mail.gmail.com>
 <1294413238.3968.110.camel@nubuntu>
 <78677181845a6577fe0955a1984ac16a@mail.gmail.com>
 <c08bf1989fbe2e704960116748c416f3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59813 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755286Ab1ATJ6T convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Jan 2011 04:58:19 -0500
In-Reply-To: <c08bf1989fbe2e704960116748c416f3@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ben Tucker <btucker@mpcdata.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

I am not sure if this is needed. All calls within configure_dispc()
ensure that clocks are enabled before a register write.

The functions which read/write to registers and don't enable/disable
clocks have names which start with a "_"(for most cases).

Regards,
Archit

linux-omap-owner@vger.kernel.org wrote:
> From 086e3454c8f154cd90a4669899f2179f16ef32cd Mon Sep 17 00:00:00
> 2001 From: Ben Tucker <btucker@mpc-data.co.uk>
> Date: Thu, 13 Jan 2011 12:56:45 +0000
> Subject: [PATCH] OMAP DSS Enable clocks in
> dss_setup_partial_planes  Enable the interface clocks while
> calling  configure_dispc().
> 
> ---
>  drivers/video/omap2/dss/manager.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/video/omap2/dss/manager.c
> b/drivers/video/omap2/dss/manager.c
> index 545e9b9..cb90dac 100644
> --- a/drivers/video/omap2/dss/manager.c
> +++ b/drivers/video/omap2/dss/manager.c
> @@ -1106,7 +1106,9 @@ void dss_setup_partial_planes(struct
>         omap_dss_device *dssdev, mc->w = w;
>         mc->h = h;
> 
> +       dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK1);        
> configure_dispc(); +       dss_clk_disable(DSS_CLK_ICK |
> DSS_CLK_FCK1); 
> 
>         mc->do_manual_update = false;
> 
> --
> 1.7.3.2