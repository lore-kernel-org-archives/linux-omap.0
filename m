Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A0F2D9787;
	Thu, 28 May 2026 20:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779999562; cv=none; b=ofl4ClGZD3kR+ik+FloQQsyZhuyB0iuwaWKZC741h3DrOrEbvw9pOZt8xUt5Hj2rISJQT55ytr5Jfc3Zz0CQCdwplznqNDS0WcnNpD9ZaJ5vep+6EKnNBqKCS80Dt4q2A68H4B8XzR/0bax/eDYksaMPczwMkN4TxGGxKNe4GzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779999562; c=relaxed/simple;
	bh=dww0ZpGouDU3rfew4ddFRvk6Ifx/DNkivm32HJsnt9E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sfqtPHnzh+VB6x1rWc0CoZ99yjzuSeN6xeWGcMvv5eWF+0hLfG+f6CDPqdzDAchdQqqs09kQX1crPYD8VlCMLfti2fANlP5i1GBSHpF+BQ5oh9iI50V35/ivun1r5D743yLoYRFqd3gWoQJZfq+uBmybx2pb0HeUPza+EUEnNUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=pLvB0Rb8; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="pLvB0Rb8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=biI3Fi015+MwZ973Vf6VZ3ApFjpcxlUtSor4LXHCqho=; b=pLvB0Rb8vfM7zRXXm2UT7800K2
	9U1XLNf2F3dc2DwP+cFhyeUtmGV+jk72YZQicruh+1+NF9xTti3CN1AisDkWyK/HPdZ7KRLHbyFz0
	/LwYcKj3rYpa2gh8TCsjWwxKPrHaFI9AApv9A3OFC1h2ltbdFjB9PjZwxfMTv0PK9B51W0NaQzQfI
	g7DkERV2P7rKzk6qfD2MEuWOF2xBlxuSj8cHg0wf4Um3oRnSqhR/Tmj0VSurd6RpcmY2WBs/CmODE
	CPdldl+tQyn6dGPd33ND6xriZFx1ZLbAuw5cJV7D2cKMSBqm/KgDUwUuWkdmYr0CJ+as7CZC52EQy
	Mnx/xXbw==;
Date: Thu, 28 May 2026 22:19:12 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sebastian Reichel
 <sebastian.reichel@collabora.com>, Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>, Tony Lindgren <tony@atomide.com>,
 Linux-OMAP <linux-omap@vger.kernel.org>, Marek Vasut <marex@denx.de>, "H.
 Nikolaus Schaller" <hns@goldelico.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] drm/omap: dsi: avoid sending bta sync all the time in
 writes
Message-ID: <20260528221912.1771daa4@kemnade.info>
In-Reply-To: <20260528220603.6600d45b@kemnade.info>
References: <20260528-vm-upstr-v1-1-fb93ef8cbe47@kernel.org>
	<ec1a577b-12fb-402c-9ceb-3c1e8265a7e9@gmail.com>
	<20260528190234.4c00b740@kernel.org>
	<37f64c1c-9920-41a6-a8c0-7a84a30c884a@gmail.com>
	<20260528220603.6600d45b@kemnade.info>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 28 May 2026 22:06:03 +0200
Andreas Kemnade <andreas@kemnade.info> wrote:

> On Thu, 28 May 2026 20:43:12 +0300
> Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com> wrote:
>=20
> > Hi,
> >=20
> > On 28.05.26 =D0=B3. 20:02 =D1=87., Andreas Kemnade wrote: =20
> > > Hi,
> > >=20
> > > so this droid4? Or which device is it?
> > >    =20
> >=20
> > Oh, sorry, yes, this is droid4.
> >  =20
> > > On Thu, 28 May 2026 17:44:14 +0300
> > > Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com> wrote:
> > >    =20
> > >> Applied against 6.18.31, no dice :)
> > >>
> > >> [   11.617523] [drm] Initialized pvr 1.17.4948957 for 56000000.gpu on
> > >> minor 0
> > >> [   11.674652] omapdss_dss 58000000.dss: bound 58001000.dispc (ops
> > >> dispc_component_ops [omapdrm])
> > >> [   11.775085] omapdss_dss 58000000.dss: bound 58001000.dispc (ops
> > >> dsi_vc_flush_receive_data [omapdrm])
> > >> [   12.222930] omapdss_dss 58000000.dss: bound 58001000.dispc (ops
> > >> dsi_vc_flush_receive_data [omapdrm])
> > >> [   12.245117] omapdss_dss 58000000.dss: bound 58001000.dispc (ops
> > >> dsi_vc_flush_receive_data [omapdrm])
> > >> [   12.247375] omapdss_dss 58000000.dss: bound 58004000.encoder (ops
> > >> dsi_vc_flush_receive_data [omapdrm])
> > >> [   12.249267] omapdss_dss 58000000.dss: bound 58006000.encoder (ops
> > >> dsi_vc_flush_receive_data [omapdrm])
> > >> [   12.284729] [drm] Initialized omapdrm 1.0.0 for omapdrm.0 on mino=
r 1
> > >> [   12.311981] [drm] Enabling DMM ywrap scrolling   =20
> > >=20
> > > I would expect some
> > > output from  the panel-dsi-cm driver:
> > > dev_info(&ddata->dsi->dev, "panel revision %02x.%02x.%02x\n",
> > >                          id1, id2, id3);
> > >=20
> > > or some error:
> > >          dev_err(&ddata->dsi->dev, "error while enabling panel, issui=
ng HW reset\n");
> > >=20
> > > Any explanation why it is missing?
> > >    =20
> >=20
> > It is there, I grep-ed for omapdrm only, didn't want to flood the ML:
> >=20
> > 2026-05-28T17:34:45.761932+03:00 devuan-droid4 kernel: [   12.502105]=20
> > panel-dsi-cm 58004000.encoder.0: panel revision 70.01.02
> >=20
> > Here is the (almost)full boot log: https://paste.debian.net/hidden/e6ca=
55a7
> >  =20
> 2026-05-28T17:34:45.763732+03:00 devuan-droid4 kernel: [  112.820404] DSI=
: omapdss DSI: failed to send nop between frames: -5
> 2026-05-28T17:34:45.763732+03:00 devuan-droid4 kernel: [  113.331726] DSI=
: omapdss DSI: failed to send nop between frames: -5
>=20
> and that is interesting. Apparently no PACKET_SENT_IRQ and the wait
> completion times out. Maybe it is not used with short packets.
> But..
>        /*
>          * Send NOP between the frames. If we don't send something here, =
the
>          * updates stop working. This is probably related to DSI spec sta=
ting
>          * that the DSI host should transition to LP at least once per fr=
ame.
>          */
>         r =3D _dsi_send_nop(dsi, VC_CMD, dsi->dsidev->channel);
>=20
> I do not see a reason why something should go into LP mode here. the
> message will probably be sent in HS mode but the BTA sync (not done anymo=
re)
> is probably the only thing turning something to LP mode.
>=20
> So to avoid PACKET_SENT_IRQ trouble, do:
> diff --git a/drivers/gpu/drm/omapdrm/dss/dsi.c b/drivers/gpu/drm/omapdrm/=
dss/dsi.c
> index dcfcfc0efcdc..37323c9b08a8 100644
> --- a/drivers/gpu/drm/omapdrm/dss/dsi.c
> +++ b/drivers/gpu/drm/omapdrm/dss/dsi.c
> @@ -2200,7 +2200,7 @@ static int dsi_vc_write_common(struct omap_dss_devi=
ce *dssdev, int vc,
>  	int r;
> =20
>  	if (mipi_dsi_packet_format_is_short(msg->type))
> -		r =3D dsi_vc_send_short(dsi, vc, msg);
> +		return dsi_vc_send_short(dsi, vc, msg);
>  	else
>  		r =3D dsi_vc_send_long(dsi, vc, msg);
> =20
>=20
> Also try:
> diff --git a/drivers/gpu/drm/omapdrm/dss/dsi.c b/drivers/gpu/drm/omapdrm/=
dss/dsi.c
> index dcfcfc0efcdc..37323c9b08a8 100644
> --- a/drivers/gpu/drm/omapdrm/dss/dsi.c
> +++ b/drivers/gpu/drm/omapdrm/dss/dsi.c
> @@ -3283,11 +3283,11 @@ static int dsi_update_channel(struct omap_dss_dev=
ice *dssdev, int vc)
>  	DSSDBG("dsi_update_channel: %d", vc);
> =20
>  	/*
> -	 * Send NOP between the frames. If we don't send something here, the
> +	 * Transition to LP here. If we don't send something here, the
>  	 * updates stop working. This is probably related to DSI spec stating
>  	 * that the DSI host should transition to LP at least once per frame.
>  	 */
> -	r =3D _dsi_send_nop(dsi, VC_CMD, dsi->dsidev->channel);
> +	r =3D dsi_vc_send_bta_sync(dssdev, vc);

probably rather VC_CMD
>  	if (r < 0) {
>  		DSSWARN("failed to send nop between frames: %d\n", r);
>  		goto err;
>=20
>=20
>=20
> Regards,
> Andreas
>=20

