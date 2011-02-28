From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 1/3] OMAP: DSS2: Functions to request/release DSI VCs
Date: Mon, 28 Feb 2011 14:51:56 +0200
Message-ID: <1298897516.9809.48.camel@deskari>
References: <1298882849-7432-1-git-send-email-archit@ti.com>
	 <1298882849-7432-2-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41429 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753789Ab1B1Mv7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Feb 2011 07:51:59 -0500
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1SCpxVD030572
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 28 Feb 2011 06:51:59 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep35.itg.ti.com (8.13.7/8.13.7) with ESMTP id p1SCpx5N010204
	for <linux-omap@vger.kernel.org>; Mon, 28 Feb 2011 06:51:59 -0600 (CST)
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p1SCpxAg015942
	for <linux-omap@vger.kernel.org>; Mon, 28 Feb 2011 06:51:59 -0600 (CST)
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
> +void omap_dsi_release_vc(struct omap_dss_device *dssdev);

The release function is misnamed. It's actually release_all_vcs.
However, I think the request and release functions should match:
request/release one vc.

So perhaps something like:

void omap_dsi_release_vc(struct omap_dss_device *dssdev, int channel);

dssdev is not really needed there, but can be used for checking validity
of the release call.

Also, about the returned channel value. It is something that the panel
driver should not use for anything else than to pass to DSI functions.
Perhaps this would be a good case for typedeffing (see CodingStyle,
chapter 5, part a). dsi_channel_t? Well, we can think about this later.

In the future we could possibly encode the DSI module number in the
channel also.

 
>  int omapdss_dsi_display_enable(struct omap_dss_device *dssdev);
>  void omapdss_dsi_display_disable(struct omap_dss_device *dssdev);
> diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
> index cda83b0..8118f62 100644
> --- a/drivers/video/omap2/dss/dsi.c
> +++ b/drivers/video/omap2/dss/dsi.c
> @@ -233,8 +233,11 @@ static struct
>  		enum dsi_vc_mode mode;
>  		struct omap_dss_device *dssdev;
>  		enum fifo_size fifo_size;
> +		int vc_id;
>  	} vc[4];
>  
> +	int num_vc_used;
> +
>  	struct mutex lock;
>  	struct semaphore bus_lock;
>  
> @@ -1778,8 +1781,6 @@ static void dsi_vc_initial_config(int channel)
>  	r = FLD_MOD(r, 4, 23, 21); /* DMA_TX_REQ_NB = no dma */
>  
>  	dsi_write_reg(DSI_VC_CTRL(channel), r);
> -
> -	dsi.vc[channel].mode = DSI_VC_MODE_L4;
>  }
>  
>  static int dsi_vc_config_l4(int channel)
> @@ -1986,7 +1987,7 @@ static inline void dsi_vc_write_long_header(int channel, u8 data_type,
>  
>  	WARN_ON(!dsi_bus_is_locked());
>  
> -	data_id = data_type | channel << 6;
> +	data_id = data_type | dsi.vc[channel].vc_id << 6;
>  
>  	val = FLD_VAL(data_id, 7, 0) | FLD_VAL(len, 23, 8) |
>  		FLD_VAL(ecc, 31, 24);
> @@ -2089,7 +2090,7 @@ static int dsi_vc_send_short(int channel, u8 data_type, u16 data, u8 ecc)
>  		return -EINVAL;
>  	}
>  
> -	data_id = data_type | channel << 6;
> +	data_id = data_type | dsi.vc[channel].vc_id << 6;
>  
>  	r = (data_id << 0) | (data << 8) | (ecc << 24);
>  
> @@ -3264,6 +3265,42 @@ int dsi_init_display(struct omap_dss_device *dssdev)
>  	return 0;
>  }
>  
> +int omap_dsi_request_vc(struct omap_dss_device *dssdev, int vc_id, int *channel)
> +{
> +	int p = dsi.num_vc_used;
> +
> +	if (p >= 4) {
> +		DSSERR("cannot get VC for display %s", dssdev->name);
> +		return -EINVAL;
> +	}
> +
> +	dsi.vc[p].dssdev = dssdev;
> +	dsi.vc[p].vc_id = vc_id;
> +	*channel = p;
> +
> +	dsi.num_vc_used += 1;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(omap_dsi_request_vc);
> +
> +void omap_dsi_release_vc(struct omap_dss_device *dssdev)
> +{
> +	int i, num_vc_used_disp = 0;
> +
> +	for (i = 0; i < 4; i++) {
> +		if (dsi.vc[i].dssdev == dssdev) {
> +			dsi.vc[i].dssdev = NULL;
> +			dsi.vc[i].vc_id = 0;
> +			dsi.vc[i].mode = DSI_VC_MODE_L4;
> +			num_vc_used_disp++;
> +		}
> +	}
> +
> +	dsi.num_vc_used -= num_vc_used_disp;
> +}
> +EXPORT_SYMBOL(omap_dsi_release_vc);

I don't think these work quite right. What happens if there are two
panel drivers, both have allocated one channel. Then the first channel
is released. At this point num_vc_used is 1. Next request would allocate
channel number 1, which is still in use.

I think the code will be cleaner and simpler if you removed num_vc_used,
and loop through the 4 channels when allocating, trying to find a free
one. It's just 4 iterations.

 Tomi


