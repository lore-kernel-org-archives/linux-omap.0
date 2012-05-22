From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 4/4] USB: Remove omap2 support from omap_udc.c
Date: Tue, 22 May 2012 10:09:16 +0300
Message-ID: <20120522070914.GD30559@arwen.pp.htv.fi>
References: <20120521185323.927.88012.stgit@muffinssi.local>
 <20120521190111.927.38546.stgit@muffinssi.local>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ycz6tD7Th1CMF4v7"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:55851 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751522Ab2EVHLR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 May 2012 03:11:17 -0400
Received: by lahg1 with SMTP id g1so4672499lah.30
        for <linux-omap@vger.kernel.org>; Tue, 22 May 2012 00:11:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120521190111.927.38546.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, Kyungmin Park <kyungmin.park@samsung.com>, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, Felipe Balbi <balbi@ti.com>


--Ycz6tD7Th1CMF4v7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 21, 2012 at 12:01:11PM -0700, Tony Lindgren wrote:
> There are no active users of this code for omap2 as
> the boards in use have either TUSB or MUSB controller.
>=20
> While at it, also fix warnings related to uninitialized
> dc_clk and hhc_clk.
>=20
> Cc: linux-usb@vger.kernel.org
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

This one doesn't depend on the rest of the series, I can take it myself
to v3.6 or you can take it with your series:

Acked-by: Felipe Balbi <balbi@ti.com>

> ---
>  drivers/usb/gadget/omap_udc.c |  113 ++++++++---------------------------=
------
>  1 file changed, 23 insertions(+), 90 deletions(-)
>=20
> diff --git a/drivers/usb/gadget/omap_udc.c b/drivers/usb/gadget/omap_udc.c
> index 2acf06c..913587f 100644
> --- a/drivers/usb/gadget/omap_udc.c
> +++ b/drivers/usb/gadget/omap_udc.c
> @@ -62,9 +62,6 @@
> =20
>  #define	DMA_ADDR_INVALID	(~(dma_addr_t)0)
> =20
> -#define OMAP2_DMA_CH(ch)	(((ch) - 1) << 1)
> -#define OMAP24XX_DMA(name, ch)	(OMAP24XX_DMA_##name + OMAP2_DMA_CH(ch))
> -
>  /*
>   * The OMAP UDC needs _very_ early endpoint setup:  before enabling the
>   * D+ pullup to allow enumeration.  That's too early for the gadget
> @@ -537,12 +534,8 @@ static void next_in_dma(struct omap_ep *ep, struct o=
map_req *req)
>  				: OMAP_DMA_SYNC_ELEMENT;
>  	int		dma_trigger =3D 0;
> =20
> -	if (cpu_is_omap24xx())
> -		dma_trigger =3D OMAP24XX_DMA(USB_W2FC_TX0, ep->dma_channel);
> -
>  	/* measure length in either bytes or packets */
>  	if ((cpu_is_omap16xx() && length <=3D UDC_TXN_TSC)
> -			|| (cpu_is_omap24xx() && length < ep->maxpacket)
>  			|| (cpu_is_omap15xx() && length < ep->maxpacket)) {
>  		txdma_ctrl =3D UDC_TXN_EOT | length;
>  		omap_set_dma_transfer_params(ep->lch, OMAP_DMA_DATA_TYPE_S8,
> @@ -601,28 +594,14 @@ static void next_out_dma(struct omap_ep *ep, struct=
 omap_req *req)
>  	int dma_trigger =3D 0;
>  	u16 w;
> =20
> -	if (cpu_is_omap24xx())
> -		dma_trigger =3D OMAP24XX_DMA(USB_W2FC_RX0, ep->dma_channel);
> -
> -	/* NOTE:  we filtered out "short reads" before, so we know
> -	 * the buffer has only whole numbers of packets.
> -	 * except MODE SELECT(6) sent the 24 bytes data in OMAP24XX DMA mode
> -	 */
> -	if (cpu_is_omap24xx() && packets < ep->maxpacket) {
> -		omap_set_dma_transfer_params(ep->lch, OMAP_DMA_DATA_TYPE_S8,
> -				packets, 1, OMAP_DMA_SYNC_ELEMENT,
> -				dma_trigger, 0);
> -		req->dma_bytes =3D packets;
> -	} else {
> -		/* set up this DMA transfer, enable the fifo, start */
> -		packets /=3D ep->ep.maxpacket;
> -		packets =3D min(packets, (unsigned)UDC_RXN_TC + 1);
> -		req->dma_bytes =3D packets * ep->ep.maxpacket;
> -		omap_set_dma_transfer_params(ep->lch, OMAP_DMA_DATA_TYPE_S16,
> -				ep->ep.maxpacket >> 1, packets,
> -				OMAP_DMA_SYNC_ELEMENT,
> -				dma_trigger, 0);
> -	}
> +	/* set up this DMA transfer, enable the fifo, start */
> +	packets /=3D ep->ep.maxpacket;
> +	packets =3D min(packets, (unsigned)UDC_RXN_TC + 1);
> +	req->dma_bytes =3D packets * ep->ep.maxpacket;
> +	omap_set_dma_transfer_params(ep->lch, OMAP_DMA_DATA_TYPE_S16,
> +			ep->ep.maxpacket >> 1, packets,
> +			OMAP_DMA_SYNC_ELEMENT,
> +			dma_trigger, 0);
>  	omap_set_dma_dest_params(ep->lch, OMAP_DMA_PORT_EMIFF,
>  		OMAP_DMA_AMODE_POST_INC, req->req.dma + req->req.actual,
>  		0, 0);
> @@ -761,10 +740,7 @@ static void dma_channel_claim(struct omap_ep *ep, un=
signed channel)
>  	ep->dma_channel =3D channel;
> =20
>  	if (is_in) {
> -		if (cpu_is_omap24xx())
> -			dma_channel =3D OMAP24XX_DMA(USB_W2FC_TX0, channel);
> -		else
> -			dma_channel =3D OMAP_DMA_USB_W2FC_TX0 - 1 + channel;
> +		dma_channel =3D OMAP_DMA_USB_W2FC_TX0 - 1 + channel;
>  		status =3D omap_request_dma(dma_channel,
>  			ep->ep.name, dma_error, ep, &ep->lch);
>  		if (status =3D=3D 0) {
> @@ -781,11 +757,7 @@ static void dma_channel_claim(struct omap_ep *ep, un=
signed channel)
>  				0, 0);
>  		}
>  	} else {
> -		if (cpu_is_omap24xx())
> -			dma_channel =3D OMAP24XX_DMA(USB_W2FC_RX0, channel);
> -		else
> -			dma_channel =3D OMAP_DMA_USB_W2FC_RX0 - 1 + channel;
> -
> +		dma_channel =3D OMAP_DMA_USB_W2FC_RX0 - 1 + channel;
>  		status =3D omap_request_dma(dma_channel,
>  			ep->ep.name, dma_error, ep, &ep->lch);
>  		if (status =3D=3D 0) {
> @@ -809,7 +781,7 @@ static void dma_channel_claim(struct omap_ep *ep, uns=
igned channel)
>  		omap_disable_dma_irq(ep->lch, OMAP_DMA_BLOCK_IRQ);
> =20
>  		/* channel type P: hw synch (fifo) */
> -		if (cpu_class_is_omap1() && !cpu_is_omap15xx())
> +		if (!cpu_is_omap15xx())
>  			omap_set_dma_channel_mode(ep->lch, OMAP_DMA_LCH_P);
>  	}
> =20
> @@ -929,13 +901,11 @@ omap_ep_queue(struct usb_ep *_ep, struct usb_reques=
t *_req, gfp_t gfp_flags)
> =20
>  	/* this isn't bogus, but OMAP DMA isn't the only hardware to
>  	 * have a hard time with partial packet reads...  reject it.
> -	 * Except OMAP2 can handle the small packets.
>  	 */
>  	if (use_dma
>  			&& ep->has_dma
>  			&& ep->bEndpointAddress !=3D 0
>  			&& (ep->bEndpointAddress & USB_DIR_IN) =3D=3D 0
> -			&& !cpu_class_is_omap2()
>  			&& (req->req.length % ep->ep.maxpacket) !=3D 0) {
>  		DBG("%s, no partial packet OUT reads\n", __func__);
>  		return -EMSGSIZE;
> @@ -2091,10 +2061,6 @@ static inline int machine_without_vbus_sense(void)
>  {
>  	return (machine_is_omap_innovator()
>  		|| machine_is_omap_osk()
> -		|| machine_is_omap_apollon()
> -#ifndef CONFIG_MACH_OMAP_H4_OTG
> -		|| machine_is_omap_h4()
> -#endif
>  		|| machine_is_sx1()
>  		|| cpu_is_omap7xx() /* No known omap7xx boards with vbus sense */
>  		);
> @@ -2308,12 +2274,9 @@ static int proc_otg_show(struct seq_file *s)
>  	u32		trans =3D 0;
>  	char		*ctrl_name =3D "(UNKNOWN)";
> =20
> -	/* XXX This needs major revision for OMAP2+ */
>  	tmp =3D omap_readl(OTG_REV);
> -	if (cpu_class_is_omap1()) {
> -		ctrl_name =3D "tranceiver_ctrl";
> -		trans =3D omap_readw(USB_TRANSCEIVER_CTRL);
> -	}
> +	ctrl_name =3D "tranceiver_ctrl";
> +	trans =3D omap_readw(USB_TRANSCEIVER_CTRL);
>  	seq_printf(s, "\nOTG rev %d.%d, %s %05x\n",
>  		tmp >> 4, tmp & 0xf, ctrl_name, trans);
>  	tmp =3D omap_readw(OTG_SYSCON_1);
> @@ -2400,14 +2363,12 @@ static int proc_udc_show(struct seq_file *s, void=
 *_)
>  		HMC,
>  		udc->transceiver
>  			? udc->transceiver->label
> -			: ((cpu_is_omap1710() || cpu_is_omap24xx())
> +			: (cpu_is_omap1710()=20
>  				? "external" : "(none)"));
> -	if (cpu_class_is_omap1()) {
> -		seq_printf(s, "ULPD control %04x req %04x status %04x\n",
> -			omap_readw(ULPD_CLOCK_CTRL),
> -			omap_readw(ULPD_SOFT_REQ),
> -			omap_readw(ULPD_STATUS_REQ));
> -	}
> +	seq_printf(s, "ULPD control %04x req %04x status %04x\n",
> +		omap_readw(ULPD_CLOCK_CTRL),
> +		omap_readw(ULPD_SOFT_REQ),
> +		omap_readw(ULPD_STATUS_REQ));
> =20
>  	/* OTG controller registers */
>  	if (!cpu_is_omap15xx())
> @@ -2592,7 +2553,7 @@ omap_ep_setup(char *name, u8 addr, u8 type,
>  		 * and ignored for PIO-IN on newer chips
>  		 * (for more reliable behavior)
>  		 */
> -		if (!use_dma || cpu_is_omap15xx() || cpu_is_omap24xx())
> +		if (!use_dma || cpu_is_omap15xx())
>  			dbuf =3D 0;
> =20
>  		switch (maxp) {
> @@ -2796,8 +2757,8 @@ static int __init omap_udc_probe(struct platform_de=
vice *pdev)
>  	struct usb_phy		*xceiv =3D NULL;
>  	const char		*type =3D NULL;
>  	struct omap_usb_config	*config =3D pdev->dev.platform_data;
> -	struct clk		*dc_clk;
> -	struct clk		*hhc_clk;
> +	struct clk		*dc_clk =3D NULL;
> +	struct clk		*hhc_clk =3D NULL;
> =20
>  	/* NOTE:  "knows" the order of the resources! */
>  	if (!request_mem_region(pdev->resource[0].start,
> @@ -2817,16 +2778,6 @@ static int __init omap_udc_probe(struct platform_d=
evice *pdev)
>  		udelay(100);
>  	}
> =20
> -	if (cpu_is_omap24xx()) {
> -		dc_clk =3D clk_get(&pdev->dev, "usb_fck");
> -		hhc_clk =3D clk_get(&pdev->dev, "usb_l4_ick");
> -		BUG_ON(IS_ERR(dc_clk) || IS_ERR(hhc_clk));
> -		/* can't use omap_udc_enable_clock yet */
> -		clk_enable(dc_clk);
> -		clk_enable(hhc_clk);
> -		udelay(100);
> -	}
> -
>  	if (cpu_is_omap7xx()) {
>  		dc_clk =3D clk_get(&pdev->dev, "usb_dc_ck");
>  		hhc_clk =3D clk_get(&pdev->dev, "l3_ocpi_ck");
> @@ -2876,14 +2827,6 @@ static int __init omap_udc_probe(struct platform_d=
evice *pdev)
> =20
>  		hmc =3D HMC_1610;
> =20
> -		if (cpu_is_omap24xx()) {
> -			/* this could be transceiverless in one of the
> -			 * "we don't need to know" modes.
> -			 */
> -			type =3D "external";
> -			goto known;
> -		}
> -
>  		switch (hmc) {
>  		case 0:			/* POWERUP DEFAULT =3D=3D 0 */
>  		case 4:
> @@ -2922,7 +2865,7 @@ bad_on_1710:
>  			goto cleanup0;
>  		}
>  	}
> -known:
> +
>  	INFO("hmc mode %d, %s transceiver\n", hmc, type);
> =20
>  	/* a "gadget" abstracts/virtualizes the controller */
> @@ -2976,16 +2919,6 @@ known:
>  		clk_disable(dc_clk);
>  	}
> =20
> -	if (cpu_is_omap24xx()) {
> -		udc->dc_clk =3D dc_clk;
> -		udc->hhc_clk =3D hhc_clk;
> -		/* FIXME OMAP2 don't release hhc & dc clock */
> -#if 0
> -		clk_disable(hhc_clk);
> -		clk_disable(dc_clk);
> -#endif
> -	}
> -
>  	create_proc_file();
>  	status =3D device_add(&udc->gadget.dev);
>  	if (status)
> @@ -3014,7 +2947,7 @@ cleanup0:
>  	if (xceiv)
>  		usb_put_transceiver(xceiv);
> =20
> -	if (cpu_is_omap16xx() || cpu_is_omap24xx() || cpu_is_omap7xx()) {
> +	if (cpu_is_omap16xx() || cpu_is_omap7xx()) {
>  		clk_disable(hhc_clk);
>  		clk_disable(dc_clk);
>  		clk_put(hhc_clk);
>=20

--=20
balbi

--Ycz6tD7Th1CMF4v7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPuzuaAAoJEIaOsuA1yqREEE4P/1ONP6HUoAV6unv1XVwQoT9V
1BnI+MckU/cKUDaj3xkWiGS1TBfZC/MT5W5DFXatULuaVroqBvKYVPvF1f+M7Hsp
yCbk1uJAlL1zlQS89zHxrkcClPIKPYo/mTyml148cqM9N9qeJQq72ECHAFF0LXXA
DJjzCbsNlf4LeB2YuWOOZ5z82Dx7sf8hgPiWKQtZ2vjeFxRuTGvhasQgZWpaiDim
YP8aD8C47rBPsBvpRSWiVL4iRlGEGfl+O+RNxOwMtB6NjxBTf2+eG4H1Lz2G1hTS
YXczH3LgN4mYtcO+fnagLvS+0l6dED24psN4btJkzPBr7JzYT5B1DqsvlqbaENW7
KqOT4ayyGjcpnyJ8MuJQbwjBLkIaCEgg4MA/RrHqmNX8CasMfq4Nsb3vrXQPEutb
z2GTTGwdtCZgylt+7Fn4ARi8pqUbDHTwht0Ph/cYKHx8rbgsd8iF0gw3kTFLsjI3
yo7vJC6CupnuybTR+UQNNURqPf7b+Lzy2DfP1Du55QhrG5ALb5ovFWd/VWdsBz92
/pz5eDujuTgB/CPi6CkXK1Kx3TsCKeQqe6qFUfO0wKW9jATdF94X7mRglci9fTsR
kgGnTAIjaZ7i9pN1T8wbvZsHMd9asjmdGVF4wYqSGzhs/dOfBzrgCUzrNU1g4Dww
yZKoGoIFuweCEt1RzwOA
=DTOO
-----END PGP SIGNATURE-----

--Ycz6tD7Th1CMF4v7--
