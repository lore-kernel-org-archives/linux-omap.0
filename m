Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA7D3F9A1A;
	Thu, 28 May 2026 17:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779987764; cv=none; b=a/J2Q8WJYNx2ooVJYAR8M4+gD/aYaUr5+m5L/Yviyx1ek8EhftA43J0vQWIo/XxYh7WJJTUy8m+dXcbaG8gAJmRGMCKBIpFv3EtzhqPvmPmfyncA6BclyQxR8Xs6fYS+tgQd7m/YAyfq1SwPV9i18EsS6ZIwg1NC67L52Z6ZD2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779987764; c=relaxed/simple;
	bh=D+DDtf372XLeNDcX9Blak1k9JhxnEKnCgwGA5O2zs2o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VanXSTmYfg5ywIr/EZM/tuBf68PCNWC2dhlxekBblvloRJH5m1Hne+c8DNMEmFZSz07UeSaK5GEIjQ2CgdV/Q0jREyw7WW5aT8v7BrnCNT0VWbM9koeGPRuKpxicx6BFa35e0RE40vsqijejgWJBOcaHfdpW2s6LctbUCXryrHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cL2jrF+Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cL2jrF+Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F9361F000E9;
	Thu, 28 May 2026 17:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779987760;
	bh=kX//T06+JmJvGXIU6nc59vpQxq6cZ5FTcVXRmzpdNqA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=cL2jrF+Qx8ocotInYNei4sngZcGSqKPZnGmT6xMRS7Um7twrLRm1LFyhnPmKqueOy
	 Q7uILGDhu8bN7mf6YQu6O6dur6AhLphkDyN4rm2LYrQPTzQSPSjJelNSYQInuW3DTk
	 GpGK+WQhoaYfN9YbAX++JWZxzYR1Gz9x/5cHeLOWIibJwNUBKaSuXQAhW/+WVabgKa
	 GsvuARdUY1DFJUTuFurXNJc/BsWsQlIFw2jAtbEiqNt2EgQWKfKSNNqLoN7WRUJDdb
	 c35bqP/BgkzEWwujAoXlp76aN2ATBkF/eMRcJXxCkVUmHgyxz3KcZbRML4q38urV5F
	 vqKRd3QWSGL6A==
Date: Thu, 28 May 2026 19:02:34 +0200
From: Andreas Kemnade <akemnade@kernel.org>
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sebastian Reichel
 <sebastian.reichel@collabora.com>, Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>, Tony Lindgren <tony@atomide.com>,
 Linux-OMAP <linux-omap@vger.kernel.org>, Marek Vasut <marex@denx.de>, "H.
 Nikolaus Schaller" <hns@goldelico.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>,
 Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [PATCH] drm/omap: dsi: avoid sending bta sync all the time in
 writes
Message-ID: <20260528190234.4c00b740@kernel.org>
In-Reply-To: <ec1a577b-12fb-402c-9ceb-3c1e8265a7e9@gmail.com>
References: <20260528-vm-upstr-v1-1-fb93ef8cbe47@kernel.org>
	<ec1a577b-12fb-402c-9ceb-3c1e8265a7e9@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

so this droid4? Or which device is it?

On Thu, 28 May 2026 17:44:14 +0300
Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com> wrote:

> Applied against 6.18.31, no dice :)
>=20
> [   11.617523] [drm] Initialized pvr 1.17.4948957 for 56000000.gpu on=20
> minor 0
> [   11.674652] omapdss_dss 58000000.dss: bound 58001000.dispc (ops=20
> dispc_component_ops [omapdrm])
> [   11.775085] omapdss_dss 58000000.dss: bound 58001000.dispc (ops=20
> dsi_vc_flush_receive_data [omapdrm])
> [   12.222930] omapdss_dss 58000000.dss: bound 58001000.dispc (ops=20
> dsi_vc_flush_receive_data [omapdrm])
> [   12.245117] omapdss_dss 58000000.dss: bound 58001000.dispc (ops=20
> dsi_vc_flush_receive_data [omapdrm])
> [   12.247375] omapdss_dss 58000000.dss: bound 58004000.encoder (ops=20
> dsi_vc_flush_receive_data [omapdrm])
> [   12.249267] omapdss_dss 58000000.dss: bound 58006000.encoder (ops=20
> dsi_vc_flush_receive_data [omapdrm])
> [   12.284729] [drm] Initialized omapdrm 1.0.0 for omapdrm.0 on minor 1
> [   12.311981] [drm] Enabling DMM ywrap scrolling

I would expect some
output from  the panel-dsi-cm driver:
dev_info(&ddata->dsi->dev, "panel revision %02x.%02x.%02x\n",
                        id1, id2, id3);

or some error:
        dev_err(&ddata->dsi->dev, "error while enabling panel, issuing HW r=
eset\n");

Any explanation why it is missing?



> [   12.770385] omapdrm omapdrm.0: atomic complete timeout (pipe 0)!
> [   22.901306] omapdrm omapdrm.0: [drm] *ERROR* flip_done timed out
> [   22.901306] omapdrm omapdrm.0: [drm] *ERROR* [CRTC:67:crtc-0] commit=20
> wait timed out
looks like dsi is not involed here, so something else is producing problems?

> [   33.131256] omapdrm omapdrm.0: [drm] *ERROR* flip_done timed out
> [   33.131378] omapdrm omapdrm.0: [drm] *ERROR* [CONNECTOR:66:DSI-1]=20
> commit wait timed out

This might have something to do with the patch.

> [   43.371307] omapdrm omapdrm.0: [drm] *ERROR* flip_done timed out
> [   43.371398] omapdrm omapdrm.0: [drm] *ERROR* [PLANE:34:plane-0]=20
> commit wait timed out
> [   43.631408] omapdrm omapdrm.0: atomic complete timeout (pipe 0)!
> [   43.692504] omapdrm omapdrm.0: [drm] fb0: omapdrmdrmfb frame buffer=20
> device
> [   54.251342] omapdrm omapdrm.0: [drm] *ERROR* flip_done timed out
> [   54.251464] omapdrm omapdrm.0: [drm] *ERROR* [CRTC:67:crtc-0] commit=20
> wait timed out
> [   64.491302] omapdrm omapdrm.0: [drm] *ERROR* flip_done timed out
> [   64.491424] omapdrm omapdrm.0: [drm] *ERROR* [CONNECTOR:66:DSI-1]=20
> commit wait timed out
> [   74.731323] omapdrm omapdrm.0: [drm] *ERROR* flip_done timed out
> [   74.731445] omapdrm omapdrm.0: [drm] *ERROR* [PLANE:34:plane-0]=20
> commit wait timed out
> [   74.991363] omapdrm omapdrm.0: atomic complete timeout (pipe 0)!
> [   85.621307] omapdrm omapdrm.0: [drm] *ERROR* flip_done timed out
> [   85.621398] omapdrm omapdrm.0: [drm] *ERROR* [CRTC:67:crtc-0] commit=20
> wait timed out
> [   95.851287] omapdrm omapdrm.0: [drm] *ERROR* flip_done timed out
> [   95.851379] omapdrm omapdrm.0: [drm] *ERROR* [CONNECTOR:66:DSI-1]=20
> commit wait timed out
> [  106.101257] omapdrm omapdrm.0: [drm] *ERROR* flip_done timed out
> [  106.101440] omapdrm omapdrm.0: [drm] *ERROR* [PLANE:34:plane-0]=20
> commit wait timed out
> [  106.371459] omapdrm omapdrm.0: atomic complete timeout (pipe 0)!
> [  106.961334] omapdrm omapdrm.0: atomic complete timeout (pipe 0)!
> [  141.301269] omapdrm omapdrm.0: [drm] *ERROR* flip_done timed out
> [  141.301269] omapdrm omapdrm.0: [drm] *ERROR* [CRTC:67:crtc-0] commit=20
> wait timed out
> [  151.531280] omapdrm omapdrm.0: [drm] *ERROR* flip_done timed out
> [  151.531402] omapdrm omapdrm.0: [drm] *ERROR* [CONNECTOR:66:DSI-1]=20
> commit wait timed out
>=20
>=20
Thanks for testing.

Regards,
Andreas

> On 28.05.26 =D0=B3. 13:16 =D1=87., akemnade@kernel.org wrote:
> > From: Andreas Kemnade <andreas@kemnade.info>
> >=20
> > Some chips need configuration commands to be sent first, before they can
> > send data. TC358762 for example needs PPI_LPTXTIMECNT configured
> > and PPI_STARTPPI set to 1 to be able to transmit anything. To be able to
> > configure such chips, do not send bta sync during writes if no acks are
> > requested. Instead just wait for the packet to be sent to avoid FIFO
> > overflows. There might be more to do about acks, but there seem to be
> > virtually no users of that flag.
> >=20
> > This came to light when fiddling with the Epson Moverio BT-200 display
> > which consists of 2 TC358762 bridges with SPI funneled through
> > to the unknown display chip. With that patch the bridge can be accessed,
> > Reading back registers works, when the above-mentioned registers are se=
t.
> >=20
> > Video mode panel at OMAP4 (BT-200) and video mode at OMAP5 was tested.
> >=20
> > Fixes: e70965386353e ("drm/omap: dsi: simplify write function")
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > ---
> > This was not tested on any command mode display, which IMHO should be
> > done.  So droid4 folks: please give it a try
> > ---
> >   drivers/gpu/drm/omapdrm/dss/dsi.c | 32 +++++++++++++++++++++++-------=
--
> >   1 file changed, 23 insertions(+), 9 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/omapdrm/dss/dsi.c b/drivers/gpu/drm/omapdr=
m/dss/dsi.c
> > index 27fe7bca9e2cf..98362b0157023 100644
> > --- a/drivers/gpu/drm/omapdrm/dss/dsi.c
> > +++ b/drivers/gpu/drm/omapdrm/dss/dsi.c
> > @@ -2194,6 +2194,7 @@ static int dsi_vc_send_null(struct dsi_data *dsi,=
 int vc, int channel)
> >   static int dsi_vc_write_common(struct omap_dss_device *dssdev, int vc,
> >   			       const struct mipi_dsi_msg *msg)
> >   {
> > +	DECLARE_COMPLETION_ONSTACK(completion);
> >   	struct dsi_data *dsi =3D to_dsi_data(dssdev);
> >   	int r;
> >  =20
> > @@ -2205,17 +2206,30 @@ static int dsi_vc_write_common(struct omap_dss_=
device *dssdev, int vc,
> >   	if (r < 0)
> >   		return r;
> >  =20
> > -	/*
> > -	 * TODO: we do not always have to do the BTA sync, for example
> > -	 * we can improve performance by setting the update window
> > -	 * information without sending BTA sync between the commands.
> > -	 * In that case we can return early.
> > -	 */
> > +	/* wait for IRQ for long packet transmission confirmation */
> > +	r =3D dsi_register_isr_vc(dsi, vc, dsi_completion_handler,
> > +			&completion, DSI_VC_IRQ_PACKET_SENT);
> > +	if (r)
> > +		return r;
> >  =20
> > -	r =3D dsi_vc_send_bta_sync(dssdev, vc);
> > -	if (r) {
> > -		DSSERR("bta sync failed\n");
> > +	if (wait_for_completion_timeout(&completion,
> > +			msecs_to_jiffies(500)) =3D=3D 0)
> > +		r =3D -EIO;
> > +
> > +	dsi_unregister_isr_vc(dsi, vc, dsi_completion_handler,
> > +			      &completion, DSI_VC_IRQ_PACKET_SENT);
> > +
> > +	if (r)
> >   		return r;
> > +
> > +	/* TODO: find out if more needs to be done for MIPI_DIS_MSG_REQ_ACK */
> > +
> > +	if (msg->flags & MIPI_DSI_MSG_REQ_ACK) {
> > +		r =3D dsi_vc_send_bta_sync(dssdev, vc);
> > +		if (r) {
> > +			DSSERR("bta sync failed\n");
> > +			return r;
> > +		}
> >   	}
> >  =20
> >   	/* RX_FIFO_NOT_EMPTY */
> >=20
> > ---
> > base-commit: e7ae89a0c97ce2b68b0983cd01eda67cf373517d
> > change-id: 20260528-vm-upstr-c8e7634ebf56
> >=20
> > Best regards,
> > --
> > Andreas Kemnade <akemnade@kernel.org>
> >=20
> >  =20
>=20
>=20

