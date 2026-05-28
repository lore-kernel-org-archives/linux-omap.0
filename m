Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F232F691F;
	Thu, 28 May 2026 20:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779998842; cv=none; b=j0Jb45u7yJdcbhPQ36jXJ2HPhE9CMDTL0LlahNUpDiUGZ/b9wGTmTyk8WqESZvLQ8vTqTUQvUhwKc5ZFVOnH7SJdVW05G4A661mcgl8SgwW7QBV/M+z+N9/ZuxV9dIjX+yha0ivV4sQcp1t1H+zYI8Gxyqi0o97MZDSxYed+8YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779998842; c=relaxed/simple;
	bh=OTVpfijVVAPywyvq0cT0IAsRWcnXNB2NerEH3nYCWYY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rTLOaIc44LejjxnK/uvy/xmlr6W2IAkW0YpCW2uSG3PJYw+0ed0tdtayc0hzqyyU5v/3SR4BObU1bVrBaaOA7m/DiJiHCNLZhYDuMeM6CfjMabTIkI0tEg3TPepxX+fvJj/kxSK5auvIYs+X+iFnQzdlbaoDhdJD7UZXQnW3eNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=vosyaRMC; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="vosyaRMC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=sD7kBKKtM8dEsFdv6/yfLIQsji4IOkzPOV/bT+nBl48=; b=vosyaRMC/4CM7H84E5kl4g6t07
	BUIfiwJntkrb2LZ7iXkbTmUao3J1j9UAcDbbSyB7OUluIh9StJkN4Wk8UhwghS6gM3pgZd5yRxyIS
	mt13vypJcnqLd4OXRugApOhPTrAbCmT6Xl7IcOBlHHRecU6OYSpqkXteM8jvMnLpzOYla0XI6XUD7
	mpqyNrUx4JLpFBkX+PYOdy6t2bDA49vqZ42e6ZrIzVvOy+VqJQvtmeh4rG3Y+fcPfmJx3O4zmZezd
	AhMDukksuc1P/ycXwgCzbNfw1PL0byy2PtoCbQ8D9Q37wkzEASY7NpLuNRBQv8lrM699TlBJnjPLA
	X7fxndwQ==;
Date: Thu, 28 May 2026 22:06:03 +0200
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
 linux-kernel@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>,
 Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [PATCH] drm/omap: dsi: avoid sending bta sync all the time in
 writes
Message-ID: <20260528220603.6600d45b@kemnade.info>
In-Reply-To: <37f64c1c-9920-41a6-a8c0-7a84a30c884a@gmail.com>
References: <20260528-vm-upstr-v1-1-fb93ef8cbe47@kernel.org>
	<ec1a577b-12fb-402c-9ceb-3c1e8265a7e9@gmail.com>
	<20260528190234.4c00b740@kernel.org>
	<37f64c1c-9920-41a6-a8c0-7a84a30c884a@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 28 May 2026 20:43:12 +0300
Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com> wrote:

> Hi,
>=20
> On 28.05.26 =D0=B3. 20:02 =D1=87., Andreas Kemnade wrote:
> > Hi,
> >=20
> > so this droid4? Or which device is it?
> >  =20
>=20
> Oh, sorry, yes, this is droid4.
>=20
> > On Thu, 28 May 2026 17:44:14 +0300
> > Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com> wrote:
> >  =20
> >> Applied against 6.18.31, no dice :)
> >>
> >> [   11.617523] [drm] Initialized pvr 1.17.4948957 for 56000000.gpu on
> >> minor 0
> >> [   11.674652] omapdss_dss 58000000.dss: bound 58001000.dispc (ops
> >> dispc_component_ops [omapdrm])
> >> [   11.775085] omapdss_dss 58000000.dss: bound 58001000.dispc (ops
> >> dsi_vc_flush_receive_data [omapdrm])
> >> [   12.222930] omapdss_dss 58000000.dss: bound 58001000.dispc (ops
> >> dsi_vc_flush_receive_data [omapdrm])
> >> [   12.245117] omapdss_dss 58000000.dss: bound 58001000.dispc (ops
> >> dsi_vc_flush_receive_data [omapdrm])
> >> [   12.247375] omapdss_dss 58000000.dss: bound 58004000.encoder (ops
> >> dsi_vc_flush_receive_data [omapdrm])
> >> [   12.249267] omapdss_dss 58000000.dss: bound 58006000.encoder (ops
> >> dsi_vc_flush_receive_data [omapdrm])
> >> [   12.284729] [drm] Initialized omapdrm 1.0.0 for omapdrm.0 on minor 1
> >> [   12.311981] [drm] Enabling DMM ywrap scrolling =20
> >=20
> > I would expect some
> > output from  the panel-dsi-cm driver:
> > dev_info(&ddata->dsi->dev, "panel revision %02x.%02x.%02x\n",
> >                          id1, id2, id3);
> >=20
> > or some error:
> >          dev_err(&ddata->dsi->dev, "error while enabling panel, issuing=
 HW reset\n");
> >=20
> > Any explanation why it is missing?
> >  =20
>=20
> It is there, I grep-ed for omapdrm only, didn't want to flood the ML:
>=20
> 2026-05-28T17:34:45.761932+03:00 devuan-droid4 kernel: [   12.502105]=20
> panel-dsi-cm 58004000.encoder.0: panel revision 70.01.02
>=20
> Here is the (almost)full boot log: https://paste.debian.net/hidden/e6ca55=
a7
>=20
2026-05-28T17:34:45.763732+03:00 devuan-droid4 kernel: [  112.820404] DSI: =
omapdss DSI: failed to send nop between frames: -5
2026-05-28T17:34:45.763732+03:00 devuan-droid4 kernel: [  113.331726] DSI: =
omapdss DSI: failed to send nop between frames: -5

and that is interesting. Apparently no PACKET_SENT_IRQ and the wait
completion times out. Maybe it is not used with short packets.
But..
       /*
         * Send NOP between the frames. If we don't send something here, the
         * updates stop working. This is probably related to DSI spec stati=
ng
         * that the DSI host should transition to LP at least once per fram=
e.
         */
        r =3D _dsi_send_nop(dsi, VC_CMD, dsi->dsidev->channel);

I do not see a reason why something should go into LP mode here. the
message will probably be sent in HS mode but the BTA sync (not done anymore)
is probably the only thing turning something to LP mode.

So to avoid PACKET_SENT_IRQ trouble, do:
diff --git a/drivers/gpu/drm/omapdrm/dss/dsi.c b/drivers/gpu/drm/omapdrm/ds=
s/dsi.c
index dcfcfc0efcdc..37323c9b08a8 100644
--- a/drivers/gpu/drm/omapdrm/dss/dsi.c
+++ b/drivers/gpu/drm/omapdrm/dss/dsi.c
@@ -2200,7 +2200,7 @@ static int dsi_vc_write_common(struct omap_dss_device=
 *dssdev, int vc,
 	int r;
=20
 	if (mipi_dsi_packet_format_is_short(msg->type))
-		r =3D dsi_vc_send_short(dsi, vc, msg);
+		return dsi_vc_send_short(dsi, vc, msg);
 	else
 		r =3D dsi_vc_send_long(dsi, vc, msg);
=20

Also try:
diff --git a/drivers/gpu/drm/omapdrm/dss/dsi.c b/drivers/gpu/drm/omapdrm/ds=
s/dsi.c
index dcfcfc0efcdc..37323c9b08a8 100644
--- a/drivers/gpu/drm/omapdrm/dss/dsi.c
+++ b/drivers/gpu/drm/omapdrm/dss/dsi.c
@@ -3283,11 +3283,11 @@ static int dsi_update_channel(struct omap_dss_devic=
e *dssdev, int vc)
 	DSSDBG("dsi_update_channel: %d", vc);
=20
 	/*
-	 * Send NOP between the frames. If we don't send something here, the
+	 * Transition to LP here. If we don't send something here, the
 	 * updates stop working. This is probably related to DSI spec stating
 	 * that the DSI host should transition to LP at least once per frame.
 	 */
-	r =3D _dsi_send_nop(dsi, VC_CMD, dsi->dsidev->channel);
+	r =3D dsi_vc_send_bta_sync(dssdev, vc);
 	if (r < 0) {
 		DSSWARN("failed to send nop between frames: %d\n", r);
 		goto err;



Regards,
Andreas
