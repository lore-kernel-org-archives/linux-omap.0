From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: OMAP DSS Enable clocks in dss_setup_partial_planes
Date: Wed, 12 Jan 2011 11:14:18 +0200
Message-ID: <1294823658.4156.18.camel@tubuntu>
References: b3985d3b9ab26a0aac963651376b21ac@mail.gmail.com <fd876042b2837b7dd3eaea2257dcbd6f@mail.gmail.com>
	 <1294413238.3968.110.camel@nubuntu>
	 <78677181845a6577fe0955a1984ac16a@mail.gmail.com>
	 <c08bf1989fbe2e704960116748c416f3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.48]:56859 "EHLO mgw-sa02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751023Ab1ALJOX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 Jan 2011 04:14:23 -0500
In-Reply-To: <c08bf1989fbe2e704960116748c416f3@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Ben Tucker <btucker@mpcdata.com>
Cc: linux-omap@vger.kernel.org

Hi,

On Tue, 2011-01-11 at 17:41 +0000, ext Ben Tucker wrote:
> From 086e3454c8f154cd90a4669899f2179f16ef32cd Mon Sep 17 00:00:00 2001
> From: Ben Tucker <btucker@mpc-data.co.uk>
> Date: Thu, 13 Jan 2011 12:56:45 +0000
> Subject: [PATCH] OMAP DSS Enable clocks in dss_setup_partial_planes
>  Enable the interface clocks while calling
>  configure_dispc().

This description doesn't really tell anything which isn't selfevident
from the code below. Please check
http://who-t.blogspot.com/2009/12/on-commit-messages.html

But I presume this is about RFBI. If so, correct place to enable the
clocks would be in rfbi.c.

 Tomi

> ---
>  drivers/video/omap2/dss/manager.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/video/omap2/dss/manager.c
> b/drivers/video/omap2/dss/manager.c
> index 545e9b9..cb90dac 100644
> --- a/drivers/video/omap2/dss/manager.c
> +++ b/drivers/video/omap2/dss/manager.c
> @@ -1106,7 +1106,9 @@ void dss_setup_partial_planes(struct omap_dss_device
> *dssdev,
>         mc->w = w;
>         mc->h = h;
> 
> +       dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK1);
>         configure_dispc();
> +       dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK1);
> 
>         mc->do_manual_update = false;
> 
> --
> 1.7.3.2
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


