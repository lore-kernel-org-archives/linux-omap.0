From: "Joe Woodward" <jw@terrafix.co.uk>
Subject: Re: Problems with 3.4-rc5
Date: Thu, 03 May 2012 09:49:38 +0100
Message-ID: <WC20120503084938.900446@terrafix.co.uk>
References: <WC20120502115251.8503FF@terrafix.co.uk> <4FA12775.1090206@ti.com> <WC20120502124638.320406@terrafix.co.uk> <1336033721.14378.2.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp3.keele.netcentral.co.uk ([212.57.235.197]:45998 "EHLO
	smtp3.keele.netcentral.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754573Ab2ECIuE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 May 2012 04:50:04 -0400
In-Reply-To: <1336033721.14378.2.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Archit Taneja <a0393947@ti.com>, linux-omap@vger.kernel.org

-----Original Message-----
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Joe Woodward <jw@terrafix.co.uk>
Cc: Archit Taneja <a0393947@ti.com>, linux-omap@vger.kernel.org
Date: Thu, 03 May 2012 11:28:41 +0300
Subject: Re: Problems with 3.4-rc5

> On Wed, 2012-05-02 at 13:46 +0100, Joe Woodward wrote:
> 
> > > > Secondly, I get the following when booted:
> > > > ...
> > > > [    4.701232] devtmpfs: mounted
> > > > [    4.704772] Freeing init memory: 168K
> > > > [    4.827301] omapdss DISPC error: FIFO UNDERFLOW on gfx,
> disabling
> > > the overlay
> > > > ...
> > > >
> > > 
> > > Could you add some dss debug prints? You can add "omapdss.debug=1
> > > debug" 
> > > in the bootargs to get that.
> > > 
> > > There was a feature called fifo merge added in 3.4, this might lead
> to 
> > > underflow, we had tested this using a DVI monitor on beagle but
> didn't 
> > > see any underflows.
> > > 
> > > Are you trying this out on 3.4 for the first time? What was the
> last 
> > > kernel revision on which you tested this and didn't see any issues?
> 
> Can you try the following changes (separately):
> 
> 
> diff --git a/drivers/video/omap2/dss/dispc.c
> b/drivers/video/omap2/dss/dispc.c
> index ee30937..aca4eb1 100644
> --- a/drivers/video/omap2/dss/dispc.c
> +++ b/drivers/video/omap2/dss/dispc.c
> @@ -1091,13 +1091,8 @@ void dispc_ovl_compute_fifo_thresholds(enum
> omap_plane plane,
>  	 * combined fifo size
>  	 */
>  
> -	if (dss_has_feature(FEAT_OMAP3_DSI_FIFO_BUG)) {
> -		*fifo_low = ovl_fifo_size - burst_size * 2;
> -		*fifo_high = total_fifo_size - burst_size;
> -	} else {
> -		*fifo_low = ovl_fifo_size - burst_size;
> -		*fifo_high = total_fifo_size - buf_unit;
> -	}
> +	*fifo_low = ovl_fifo_size - burst_size;
> +	*fifo_high = total_fifo_size - buf_unit;
>  }
>  
>  static void dispc_ovl_set_fir(enum omap_plane plane,
> 
> ---

The above patch fixes the problem (I no longer see any underflows).


> 
> diff --git a/drivers/video/omap2/dss/dispc.c
> b/drivers/video/omap2/dss/dispc.c
> index ee30937..d63f1a3 100644
> --- a/drivers/video/omap2/dss/dispc.c
> +++ b/drivers/video/omap2/dss/dispc.c
> @@ -1077,13 +1077,7 @@ void dispc_ovl_compute_fifo_thresholds(enum
> omap_plane plane,
>  	burst_size = dispc_ovl_get_burst_size(plane);
>  	ovl_fifo_size = dispc_ovl_get_fifo_size(plane);
>  
> -	if (use_fifomerge) {
> -		total_fifo_size = 0;
> -		for (i = 0; i < omap_dss_get_num_overlays(); ++i)
> -			total_fifo_size += dispc_ovl_get_fifo_size(i);
> -	} else {
> -		total_fifo_size = ovl_fifo_size;
> -	}
> +	total_fifo_size = ovl_fifo_size;
>  
>  	/*
>  	 * We use the same low threshold for both fifomerge and non-fifomerge
> 

The above patch has no effect (I still see underflows).

Both patches together results in slightly different behaviour, the display is still broken- 
it flickers on and off with occassional underflows before breaking completely.

Cheers,
Joe

>  Tomi
> 


