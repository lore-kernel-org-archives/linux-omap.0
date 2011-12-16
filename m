From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] ASoC: OMAP: HDMI: Prevent DSS module from going idle
 when playing audio
Date: Fri, 16 Dec 2011 10:47:47 +0200
Message-ID: <1324025267.1859.29.camel@deskari>
References: <1324019032-31532-1-git-send-email-ricardo.neri@ti.com>
	 <alpine.DEB.2.00.1112160107380.12660@utopia.booyaka.com>
	 <1324023504.1859.11.camel@deskari>
	 <alpine.DEB.2.00.1112160121250.12660@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-1r4piwkoUaiEYF7+YE6b"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:46617 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751924Ab1LPIrw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Dec 2011 03:47:52 -0500
Received: by lahl5 with SMTP id l5so1801320lah.41
        for <linux-omap@vger.kernel.org>; Fri, 16 Dec 2011 00:47:50 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1112160121250.12660@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, Ricardo Neri <ricardo.neri@ti.com>
Cc: b-cousson@ti.com, linux-omap@vger.kernel.org, mythripk@ti.com, s-guiriec@ti.com, lrg@ti.com, peter.ujfalusi@ti.com


--=-1r4piwkoUaiEYF7+YE6b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2011-12-16 at 01:27 -0700, Paul Walmsley wrote:
> On Fri, 16 Dec 2011, Tomi Valkeinen wrote:
>=20
> > But with DT we can't use func pointers in platform_data either, right?
>=20
> In the future, if someone wants to run a platform_data-less kernel,=20
> they'll have to come up with a replacement mechanism for these.  Several=
=20
> replacements have been proposed internally, such as having an=20
> omap_bus/omap_device for devices with OMAP-specific integration, but righ=
t=20
> now there are more pressing crises to deal with...

Ok. Benoit was telling me not to use pdata, so I thought it's a hard
rule for DT. He didn't give me a clear alternative, though =3D).

Ricardo, struct omap_dss_board_info already contains a few function
pointers, for example get_context_loss_count. I think
omap_hwmod_set_slave_idlemode can be handled the same way.

Although I'm not sure should the function pointer be just
"set_slave_idlemode", and thus just a direct way to call the hwmod func,
or should it be something more use case specific, like, say
"hdmi_audio_start/stop".

I'm thinking it should be the latter. As far as I understand, the bug is
not in the HDMI IP, but somewhere in the L3 side? And if so, it's not
the HDMI driver's job to know how to fix the bug, but just to offer
hooks so that the platform code can fix it.

 Tomi


--=-1r4piwkoUaiEYF7+YE6b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJO6wWzAAoJEPo9qoy8lh71B0MQAIETHM2gu55Q/XHjNJ74nLlS
agOKwkCs7oVsNWWiYGwOIiEugPA5WKBPSC9WQhJjSJZxHKAlKMN+l5dpcdMsvavJ
XftvJQ/dlL0PMp0WwkdOuf7rZ6TaPvlePsMfU+zuo2hQi4oSCBA1RncEsPG6XRN8
3F58Qi+v273LxedkqZEiZ8djmb6U+/Nhi2csjribcLyCb0xzfdM5WI3QMOlbQ2Al
3PPJgVRdF6HmwdFwAlQJymci0o35cp/zp7n+B4eHIg/apMiiksiQQa0w4tvkni3N
nH/btQBkmUhyD0+X4JvN4j7ppNgd1Cxh8Fy4+pimlwfSwKd/Xf6VphISNCH4CbQd
J37FoDBRmCVQQ+BNrfLDuGrpOHFQheP5Af0bhNRzmwJTZh10JivudPZsWBHglMyb
Zm2FZzTFhf9xOCZqnoLSBEhV7m5nnCRQxXmbPuSFPcqotKVzBF7I3OssLsmroOYo
vlduo+3CSbfBdfteZniYxrJAGKOFb6X9j0qShVJYGeHVGYJZhGHhma5kSe1XXv0C
6Mhh0B7WQRznjalRUiJ3NEyX7a5PQDbjHbG82/yzcyqRcq6brl1GrWtW8/KtgaFm
DW4OkNdrgRzIkLbplrhxNpuisj3HtbXY/QD3ZJ6UFd/tVjllxG+hK+dJtXB4fCEC
ApN/9f3zn3CbUDwiu0sY
=4QlM
-----END PGP SIGNATURE-----

--=-1r4piwkoUaiEYF7+YE6b--

