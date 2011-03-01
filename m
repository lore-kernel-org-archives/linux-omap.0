From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCH 1/3] OMAP: DSS2: Functions to request/release DSI VCs
Date: Tue, 1 Mar 2011 18:50:30 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB037A21436B@dbde02.ent.ti.com>
References: <1298982743-6771-1-git-send-email-archit@ti.com>
 <1298982743-6771-2-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37250 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753139Ab1CANUe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Mar 2011 08:20:34 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p21DKVwk025571
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 1 Mar 2011 07:20:33 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p21DKVB3019191
	for <linux-omap@vger.kernel.org>; Tue, 1 Mar 2011 18:50:31 +0530 (IST)
In-Reply-To: <1298982743-6771-2-git-send-email-archit@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Taneja, Archit" <archit@ti.com>, "Valkeinen, Tomi" <tomi.valkeinen@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Taneja, Archit
> Sent: Tuesday, March 01, 2011 6:02 PM
> To: Valkeinen, Tomi
> Cc: linux-omap@vger.kernel.org; Taneja, Archit
> Subject: [PATCH 1/3] OMAP: DSS2: Functions to request/release DSI VCs
> 
> Introduce functions which request and release VC's. This will be used in
> panel
> drivers in their probes.
> 
> omap_dsi_request_vc() takes in the pointer to the omap_dss_device, the
> VC_ID
> parameter which goes into the header of the DSI packets, and returns a
> Virtual
> channel number (or virtual channel register set) which it can use.
> 
> omap_dsi_set_vc_id() takes the omap_dss_device pointer, the Virtual
> Channel
> number and the VC_ID that needs to be set for the specifed Virtual
> Channel.
> 
> omap_dsi_releae_vc() takes the omap_dss_device pointer and the Virtual
> Channel
> number that needs to be made free.
> 
> Initialisation of VC parameters is done in dsi_init().
> 
> Signed-off-by: Archit Taneja <archit@ti.com>
> ---
>  arch/arm/plat-omap/include/plat/display.h |    3 +
>  drivers/video/omap2/dss/dsi.c             |   58
> ++++++++++++++++++++++++++--
>  2 files changed, 56 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/include/plat/display.h b/arch/arm/plat-
> omap/include/plat/display.h
> index d45f107..18c103d 100644
> --- a/arch/arm/plat-omap/include/plat/display.h
> +++ b/arch/arm/plat-omap/include/plat/display.h
> @@ -560,6 +560,9 @@ int omap_dsi_update(struct omap_dss_device *dssdev,
>  		int channel,
>  		u16 x, u16 y, u16 w, u16 h,
>  		void (*callback)(int, void *), void *data);
> +int omap_dsi_request_vc(struct omap_dss_device *dssdev, int *channel);
> +int omap_dsi_set_vc_id(struct omap_dss_device *dssdev, int channel, int
> vc_id);
> +void omap_dsi_release_vc(struct omap_dss_device *dssdev, int channel);
> 
>  int omapdss_dsi_display_enable(struct omap_dss_device *dssdev);
>  void omapdss_dsi_display_disable(struct omap_dss_device *dssdev);
> diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
> index 6779785..7758c80 100644
> --- a/drivers/video/omap2/dss/dsi.c
> +++ b/drivers/video/omap2/dss/dsi.c
> @@ -233,6 +233,7 @@ static struct
>  		enum dsi_vc_mode mode;
>  		struct omap_dss_device *dssdev;
>  		enum fifo_size fifo_size;
> +		int vc_id;
>  	} vc[4];
> 
>  	struct mutex lock;
> @@ -1778,8 +1779,6 @@ static void dsi_vc_initial_config(int channel)
>  	r = FLD_MOD(r, 4, 23, 21); /* DMA_TX_REQ_NB = no dma */
> 
>  	dsi_write_reg(DSI_VC_CTRL(channel), r);
> -
> -	dsi.vc[channel].mode = DSI_VC_MODE_L4;
>  }
> 
>  static int dsi_vc_config_l4(int channel)
> @@ -1986,7 +1985,7 @@ static inline void dsi_vc_write_long_header(int
> channel, u8 data_type,
> 
>  	WARN_ON(!dsi_bus_is_locked());
> 
> -	data_id = data_type | channel << 6;
> +	data_id = data_type | dsi.vc[channel].vc_id << 6;
> 
>  	val = FLD_VAL(data_id, 7, 0) | FLD_VAL(len, 23, 8) |
>  		FLD_VAL(ecc, 31, 24);
> @@ -2089,7 +2088,7 @@ static int dsi_vc_send_short(int channel, u8
> data_type, u16 data, u8 ecc)
>  		return -EINVAL;
>  	}
> 
> -	data_id = data_type | channel << 6;
> +	data_id = data_type | dsi.vc[channel].vc_id << 6;
> 
>  	r = (data_id << 0) | (data << 8) | (ecc << 24);
> 
> @@ -3264,6 +3263,48 @@ int dsi_init_display(struct omap_dss_device
> *dssdev)
>  	return 0;
>  }
> 
> +int omap_dsi_request_vc(struct omap_dss_device *dssdev, int *channel)
Since this is an export function it might be good to have standard comment
Header.
> +{
> +	int i;
> +
> +	for (i = 0; i < 4; i++) {
Does it make sense to use a constant instead of hard coding 4?
> +		if (!dsi.vc[i].dssdev) {
> +			dsi.vc[i].dssdev = dssdev;
> +			*channel = i;
> +			return 0;
> +		}
> +	}
> +
> +	DSSERR("cannot get VC for display %s", dssdev->name);
> +	return -ENOSPC;
> +}
> +EXPORT_SYMBOL(omap_dsi_request_vc);
> +
> +int omap_dsi_set_vc_id(struct omap_dss_device *dssdev, int channel, int
> vc_id)
> +{
> +	if (vc_id < 0 || vc_id > 4) {
> +		DSSERR("VC ID out of range\n");
> +		return -EINVAL;
> +	}
> +
> +	if (dsi.vc[channel].dssdev == dssdev) {
> +		dsi.vc[channel].vc_id = vc_id;
> +		return 0;
> +	}
> +
Might be a good idea to print some type of error message here?
> +	return -EINVAL;
> +}
> +EXPORT_SYMBOL(omap_dsi_set_vc_id);
> +
> +void omap_dsi_release_vc(struct omap_dss_device *dssdev, int channel)
> +{
> +	if (dsi.vc[channel].dssdev == dssdev) {
> +		dsi.vc[channel].dssdev = NULL;
Don't we have to free dssdev? Unless it is getting freed else where?
--
Tarun
> +		dsi.vc[channel].vc_id = 0;
> +	}
> +}
> +EXPORT_SYMBOL(omap_dsi_release_vc);
> +
>  void dsi_wait_pll_hsdiv_dispc_active(void)
>  {
>  	if (wait_for_bit_change(DSI_PLL_STATUS, 7, 1) != 1)
> @@ -3283,7 +3324,7 @@ void dsi_wait_pll_hsdiv_dsi_active(void)
>  static int dsi_init(struct platform_device *pdev)
>  {
>  	u32 rev;
> -	int r;
> +	int r, i;
>  	struct resource *dsi_mem;
> 
>  	spin_lock_init(&dsi.errors_lock);
> @@ -3337,6 +3378,13 @@ static int dsi_init(struct platform_device *pdev)
>  		goto err2;
>  	}
> 
> +	/* DSI VCs initialization */
> +	for (i = 0; i < 4; i++) {
> +		dsi.vc[i].mode = DSI_VC_MODE_L4;
> +		dsi.vc[i].dssdev = NULL;
> +		dsi.vc[i].vc_id = 0;
> +	}
> +
>  	enable_clocks(1);
> 
>  	rev = dsi_read_reg(DSI_REVISION);
> --
> 1.7.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
