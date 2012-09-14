From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 09/21] OMAPDSS: DISPC: Calculate scaling limits in a
 more generic way
Date: Fri, 14 Sep 2012 11:53:08 +0300
Message-ID: <1347612788.2559.57.camel@deskari>
References: <1347538505-25359-1-git-send-email-archit@ti.com>
	 <1347538505-25359-10-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-5oB7V5pY3udK4d/7qyXR"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog135.obsmtp.com ([74.125.149.84]:39127 "EHLO
	na3sys009aog135.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754362Ab2INIxO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 14 Sep 2012 04:53:14 -0400
Received: by lagy9 with SMTP id y9so2559941lag.19
        for <linux-omap@vger.kernel.org>; Fri, 14 Sep 2012 01:53:11 -0700 (PDT)
In-Reply-To: <1347538505-25359-10-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-5oB7V5pY3udK4d/7qyXR
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-09-13 at 17:44 +0530, Archit Taneja wrote:
> Scaling calculations for an overlay are done by comparing pixel clock of =
the
> connected overlay manager and the core clock of DISPC. The pixel clock is=
 the
> output rate of the scalar. The scalar block needs to provide pixels at th=
is rate
> since the manager is connected to a panel, which has real time constraint=
s.
>=20
> In the case of writeback in memory to memory mode, the output of the scal=
ar
> blocks aren't connected to a display, and hence there isn't a pixel clock=
 which
> causes downscaling limitations.
>=20
> Make the input to scaling calculations a bit more generic by passing the =
scalar
> output rate rather than passing pixel clock of the overlay manager connec=
ted to
> the pipeline, as we now have use cases where the scalar's output may not =
go to
> a manager connected to a panel.

Pixel clock is the rate at which pixels are processed. I don't see it
only meaning a clock that's related to actual video signal going out of
OMAP. So if in normal case the scaler outputs pixels at the rate of
pixel clock, we can call it pixel clock with WB's case also, instead of
renaming it to output clock.

Or was there some other reason for the rename, that I missed?

 Tomi


--=-5oB7V5pY3udK4d/7qyXR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQUvB0AAoJEPo9qoy8lh71zNcP/0eWijPCicbedLsFUW8+nabk
iaSvj5R92ebJNburrmoS2vv8YIIf782z0qA1+/ZgUkEtHmoxRdQ6Kvp828MVh+Sq
ZFQF67pQJncnjElyZCuyIMXGqhE37DsT48wzywF/yhyYfYB6hC24kmQj6G8uQJJD
YkIAqGeXBxMmtpq2ltLAAWDbcsxfKsXIgpieoL6tV4r0TFjl67yFhXemiKiDOZ3b
l5aqxhHjbsqfiRcuVNYL6MxOqihukmQmGZd5eZ95GY8Plf5zJv2olOv0KGrPnfGk
ICEX9MZuYrZL4HFL97WxpA7OHqP0gIyO1tA2Wsi5vaRr3CqMYYL3+q1TD4yXOTJm
2jx5ONZfXvR/OldKDNa2dvt/Qm7yYEPKDBDhN1yWZ7u04x8idgOSJ3QbC/2eG9EA
psaVAabc75wKq7WDy04MWtqmOEnP70bRIzGEOZh2wX/iSAsD3MNMZ2CWGA5GroNM
g/znZHaSBp/GAj3YuqN3at5VzK4xLMl1UgjGxDBLfuEwoSknLhmfDSSvGjFQ2CMU
IqvxGzcM6ZGzhbCf2/Ir4cSk71N+4nUVqCfXgz6hvKop3ytB06FI4FDvVxOZTRFE
cdE/21vYq5s3pce7fcaKhDHKRzxOSAsL8UhUZXz13OXnqU83wRmuDUmWUcbB8Mpu
1stPMkWvFl0XC5SoCTP3
=ketS
-----END PGP SIGNATURE-----

--=-5oB7V5pY3udK4d/7qyXR--

