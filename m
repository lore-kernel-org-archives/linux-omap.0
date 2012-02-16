From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 4/5] OMAPDSS: Export functions to enable dynamic linking
Date: Thu, 16 Feb 2012 08:34:58 +0200
Message-ID: <1329374098.2046.9.camel@lappy>
References: <1329004530-28029-1-git-send-email-ricardo.neri@ti.com>
	 <1329004530-28029-5-git-send-email-ricardo.neri@ti.com>
	 <1329140906.2817.6.camel@deskari>
	 <1329264022.2031.1570.camel@dexx0075479.dextra-mty.naucm.ext.ti.com>
	 <1329294205.1892.36.camel@deskari>
	 <1329360397.2016.149.camel@dexx0075479.dextra-mty.naucm.ext.ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-jQX+RrkiGmdkFIpmrBTl"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:40062 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753941Ab2BPGfU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Feb 2012 01:35:20 -0500
Received: by mail-lpp01m010-f45.google.com with SMTP id i5so2664884lah.18
        for <linux-omap@vger.kernel.org>; Wed, 15 Feb 2012 22:35:19 -0800 (PST)
In-Reply-To: <1329360397.2016.149.camel@dexx0075479.dextra-mty.naucm.ext.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ricardo Neri <ricardo.neri@ti.com>
Cc: mythripk@ti.com, s-guiriec@ti.com, lrg@ti.com, peter.ujfalusi@ti.com, linux-omap@vger.kernel.org


--=-jQX+RrkiGmdkFIpmrBTl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-02-15 at 20:46 -0600, Ricardo Neri wrote:

> What other display types featuring audio and video should be considered
> at this point?

I guess they are a bit theoretical, so I wouldn't worry too much about
them. But if it's easy to make the API generic, instead of HDMI
specific, let's aim for generic one just to be on the safe side.
=20
> > The audio driver should iterate the dss devices to find the ones (there
> > could well be multiple HDMI outputs) that support audio when the driver
> > starts.
> >=20
> > Does the above make sense?
>=20
> At first glance, I think the omapd_dss_audio_* functions should cover
> the following:
>  * CEA-861 infoframe configuration
>  * IEC-60958 configuration (IEC-61937 support added later)
>  * audio start/stop
>  * whether audio is supported by the current video configuration
>  * a notifier power and video events (e.g, DVI/HDMI mode, changes in
> pixel clock and deep color configuration) to the ASoC driver. Maybe an
> enum can encompass DisplayPort and HDMI events.

Sounds fine to me (not that I understand anything about the audio side
=3D). For notifications, I've long planned to implement notifications for
omapdss/displays, mainly for hotplug but also other events. So I think
we should try to make the notification system not audio-specific, but
usable for other events also.

As for the API, I don't think omap_dss_audio_* is the way to go. The
audio functions should probably be function pointers in the
omap_dss_driver struct.

> I think that this is generic enough to cover DisplayPort and HDMI,
> unless you consider that I am missing some important display type.
>=20
> I can try to make it similar to omapfb.

Don't look too closely at omapfb, it's horribly ugly in many places =3D).

 Tomi


--=-jQX+RrkiGmdkFIpmrBTl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPPKOSAAoJEPo9qoy8lh71OXkP/0LVPYh+96v2pUrc/HVcWSHU
Y0Dt6ocYf6sSWpWdfiM2iLXj9b2T3i0u/FhgRev0qzMkMi+FaBA2JDUQgzQMcM6N
PI47HOn0QtZ/ogyCzNvcHIbmN9k5Rbpy9sS8xFSkDUSMtBYQlS6sXxSlmUC69A4q
kmIIW/h/mT6/cBnD4qujcuFMHALlOfWojacwU56obJJ2L9FgZ9ZVOLKshc6caOE9
giVRBk3hKyU/xZmiSwTqgM6+R5cwgIP2R11GBrTqwexsL/w/qX65vaRKZEs4ob9O
o+PeWJJSy6NMUAE2bGE/hBeql0zCaTm3YpftkUZ1QIQRrTMWkQVVqyDqsHQgg/HL
iAonIpjl3NT6GX1+W8OVKbRivpbJ6WHZcUoGPSHygLcwG1iwdDCLjQOjSWTIliOt
lihPTvAgIwyMvdEXXcgZha1pvHHIpGrXVx5LFqU9UKWrA16pYZQ4GrjVcuI2zA27
JXVXtwssJHbtKf9cyJF9EWyH+tcgJPGbfVlLOdbtaB2t1XlY5ytz8RdXI66fR9fk
NpWy/JSLacW8b9A3+TQI7klrt/zWzP6vQ3w8U20et7ygjb28lCuYSIG5eX1Hn+EH
bHQiSaaUgqdZ68UJVBwgQeY//ir3n2te8mMoJ+qAM6TpnKmK2CPm47N1o2HSO8lo
bmhnSIA4Ck3KjcBuQvNn
=ZjUs
-----END PGP SIGNATURE-----

--=-jQX+RrkiGmdkFIpmrBTl--

