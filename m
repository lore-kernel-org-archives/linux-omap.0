From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 1/3] OMAP: DSS2: Functions to request/release DSI VCs
Date: Mon, 28 Feb 2011 16:10:14 +0200
Message-ID: <1298902214.9809.109.camel@deskari>
References: <1298882849-7432-1-git-send-email-archit@ti.com>
	 <1298882849-7432-2-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45742 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753748Ab1B1OKR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Feb 2011 09:10:17 -0500
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1SEAHic009220
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 28 Feb 2011 08:10:17 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep35.itg.ti.com (8.13.7/8.13.7) with ESMTP id p1SEAG3s014493
	for <linux-omap@vger.kernel.org>; Mon, 28 Feb 2011 08:10:16 -0600 (CST)
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p1SEAGYa018999
	for <linux-omap@vger.kernel.org>; Mon, 28 Feb 2011 08:10:16 -0600 (CST)
In-Reply-To: <1298882849-7432-2-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Taneja, Archit" <archit@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, 2011-02-28 at 02:47 -0600, Taneja, Archit wrote:
> Introduce functions which request and release VC's. This will be used in panel
> drivers in their probes.
> 
> omap_dsi_request_vc() takes in the pointer to the omap_dss_device, the VC_ID
> parameter which goes into the header of the DSI packets, and returns a Virtual
> channel number (or virtual channel register set) which it can use.
> 
> omap_dsi_releae_vc() takes the omap_dss_device pointer and frees all VCs which
> were used by that device.
> 
> Initialisation of VC parameters is done in dsi_init().
> 
> Signed-off-by: Archit Taneja <archit@ti.com>
> ---
>  arch/arm/plat-omap/include/plat/display.h |    3 ++
>  drivers/video/omap2/dss/dsi.c             |   55 ++++++++++++++++++++++++++---
>  2 files changed, 53 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/include/plat/display.h b/arch/arm/plat-omap/include/plat/display.h
> index d45f107..0057259 100644
> --- a/arch/arm/plat-omap/include/plat/display.h
> +++ b/arch/arm/plat-omap/include/plat/display.h
> @@ -560,6 +560,9 @@ int omap_dsi_update(struct omap_dss_device *dssdev,
>  		int channel,
>  		u16 x, u16 y, u16 w, u16 h,
>  		void (*callback)(int, void *), void *data);
> +int omap_dsi_request_vc(struct omap_dss_device *dssdev, int vc_id,
> +		int *channel);

One more thing: 

In theory the vc_id could be given per transmission, when calling
dsi_vc_send_xxx() functions, like it is currently.

But as the vc_id changes (probably) very rarely, it could be stored like
you do. But we should still have a separate function to set the vc_id,
without having to release and request the vc.

 Tomi


