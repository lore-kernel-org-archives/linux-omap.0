From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [RFC 0/3] solving omapdrm/omapdss layering issues
Date: Thu, 02 Aug 2012 16:15:38 +0300
Message-ID: <1343913338.2686.56.camel@deskari>
References: <1343437674-24246-1-git-send-email-rob.clark@linaro.org>
	 <1343742034.2633.56.camel@deskari>
	 <CAF6AEGuqi+E7i1cuZTCts1y46E3SDUzd8E3kuW52=jRC5EksaQ@mail.gmail.com>
	 <1343812870.2645.37.camel@deskari>
	 <CAF6AEGuoVaOwwXnS3MKcoeKrtA3=Oi108jqM3iObd3EqTmC9Bw@mail.gmail.com>
	 <1343891600.5767.12.camel@lappyti>
	 <CAF6AEGuCTu_KtH-G+gQDA=2pmKtbsoe5k8m78=bJT6cRDVFm0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-tXQrvagj5NsKbaHtbSgH"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog129.obsmtp.com ([74.125.149.142]:34255 "EHLO
	na3sys009aog129.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751540Ab2HBNPt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Aug 2012 09:15:49 -0400
Received: by lbon3 with SMTP id n3so206643lbo.0
        for <linux-omap@vger.kernel.org>; Thu, 02 Aug 2012 06:15:41 -0700 (PDT)
In-Reply-To: <CAF6AEGuCTu_KtH-G+gQDA=2pmKtbsoe5k8m78=bJT6cRDVFm0A@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Clark <rob.clark@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, patches@linaro.org, Greg KH <greg@kroah.com>, Andy Gross <andy.gross@ti.com>


--=-tXQrvagj5NsKbaHtbSgH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-08-02 at 07:45 -0500, Rob Clark wrote:
> On Thu, Aug 2, 2012 at 2:13 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wr=
ote:
> > On Wed, 2012-08-01 at 09:25 -0500, Rob Clark wrote:
> >> On Wed, Aug 1, 2012 at 4:21 AM, Tomi Valkeinen <tomi.valkeinen@ti.com>=
 wrote:
> >
> >> > I guess the fact is that DRM concepts do not really match the OMAP D=
SS
> >> > hardware, and we'll have to use whatever gives us least problems.
> >>
> >> Actually, I think it does map fairly well to the hardware.. at least
> >> more so than to omapdss ;-)
> >
> > Hm, I'm not sure I understand, omapdss concepts map directly to the
> > hardware.
>=20
> I think it is mainly exposing the encoder and panel as two separate
> entities.. which seems to be what Archit is working on

I still don't follow =3D) They are separate entities. Omapdss models the
HW quite directly, I think. It doesn't expose everything, though, as the
output drivers (dsi.c, dpi.c etc) are used via the panel drivers.

> in case of something like DVI bridge from DPI, this seems pretty
> straightforward.. only the connector needs to know about DDC stuff,
> which i2c to use and that sort of thing.  So at kms level we would
> have (for example) an omap_dpi_encoder which would be the same for DPI
> panel (connector) or DPI->DVI bridge.  For HDMI I'm still looking
> through the code to see how this would work.  Honestly I've looked
> less at this part of code and encoder related registers in the TRM,
> compared to the ovl/mgr parts, but at least from the 'DSS overview'
> picture in the TRM it seems to make sense ;-)
>=20
> KMS even exposes the idea that certain crtcs can connect to only
> certain encoders.  Or that you could you could have certain connectors
> switched between encoders.  For example if you had a hw w/ DPI out,
> and some mux to switch that back and forth between a DPI lcd panel and
> a DPI->DVI bridge.  (Ok, I'm not aware of any board that actually does
> this, but it is in theory possible.)  So we could expose possible
> video chain topologies to userspace in this way.

OMAP3 SDP board has such a setup, with manual switch to select between
LCD and DVI.

> The other thing is that we don't need to propagate timings from the
> panel up to the mgr at the dss level.. kms is already handling this
> for us.  In my latest version, which I haven't pushed, I removed the
> 'struct omap_overlay_mgr' ptr from 'struct omap_dss_device'.

You're thinking only about simple DPI cases. Consider this example, with
a DSI-to-DP bridge chip. What we have is the following flow of data:

DISPC -> DSI -> DSI-2-DP -> DP monitor

The timings you are thinking about are in the DISPC, but here they are
only one part of the link. And here the DISPC timings are not actually
the timings what the user is interested about. The user wants his
timings to be between DSI-2-DP chip and the DP monitor.

Timings programmed to DISPC are not the same. The timings for DISPC come
from the DSI driver, and they may be very different than the user's
timings. With DSI video mode, the DISPC timings would have some
resemblance to the user's timings, mainly the time to send one line
would be the same. With DSI cmd mode, the DISPC timings would be
something totally different, most likely with 0 blank times and as fast
pixel clock as possible.

What omapdss does currently is that you set the user's timings to the
right side of the chain, which propagate back to DSS. This allows the
DSI-2-DP bridge use DSI timings that work optimally for the bridge, and
DSI driver will use DISPC timings that work optimally for it.

And it's not only about timings above, but also other settings related
to the busses between the components. Clock dividers, polarities, stuff
like that.

> I think the problem was there were some cases, like ovl updates before
> setting the mgr, where the user_info_dirty flag would be cleared but
> the registers not updated.  This is what I meant by sequence of

Hmm, I'd appreciate more info about this if you can give. Sounds like a
bug, that shouldn't happen.

So you mean that you have an ovl, with no manager set. And you change
the settings of the ovl before assigning it to a mgr? That's something I
haven't really tested, so it could bug, true.

> operations at KMS level confusing omapdss.  This should be fixable
> with some debugging.  Although getting rid of the state tracking at
> omapdss level altogether was a much simpler solution, and is the one I
> prefer :-)

Yes, I don't prefer the state tracking either (we didn't have it in
earlier versions of omapdss), but I still don't see an option to it if
we want to support all the stuff we have.

 Tomi


--=-tXQrvagj5NsKbaHtbSgH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQGn16AAoJEPo9qoy8lh710AoP/0UlWbtE5ewAdWeFnyxYeoxG
DG5/BCcm8/UANRPwrf2fbLlod7PS9plQKQoMU+LNZkH9aBBOAH07kN+5s/5i6sVi
W8yPC1QwZNrZmmlqwhCRwlKy+c9y76sYt4yEWMdp2wu8LtCxAHM9tpmgZEQjXXj8
7bcHxw+tAw7T7LwHr55lFEmOQAM3F4StbQA7OqSmw8v2pJYq5lORvYZxM+1Dktbi
/GUtJCDuLOyTZyO0S9O6dMzihQisxFdWhW9jbg5iHbS+X05Gdgvfr5r4APQp01WA
pcOg+HAFHSgrb/fhyp5t2u2WQ1Jk7N6ek+U1u1lNwpzYBdfLhWzt6qnbnLQn9JP1
qyGPK4GKRIh/pCNUgjAtriEHMb36XUc6ANQjRkFsSs+O+/sHhsZN204r7KlH47ea
wJe97T+i3K+GgILjuvXxjjtzGXgOC0vCUUMHLKwl6KmuIwJRT8mIThTMh/pJfMEH
JtIdhGJHoVKF/jUYyWZU7B4cxA4cqjZcQTVYBSWUJUvIM+AmQ+wtbc7coi1zubEg
ByLL6WXTxniyOd1kP8evy1wHErpzWUJeb7JqkWUt5ZXTAKhfIbfazhV06OIsOuza
BK8aWfuyg66fVKuxpQ3Fdbx+Qa2o8yudI5E/B2Xb9o26cu32Uj5XJSWPBq6ESRlT
jSfU9/790lbSGfeuPvcd
=Keax
-----END PGP SIGNATURE-----

--=-tXQrvagj5NsKbaHtbSgH--

