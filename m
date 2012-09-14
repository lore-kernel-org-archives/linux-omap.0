From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 09/21] OMAPDSS: DISPC: Calculate scaling limits in a
 more generic way
Date: Fri, 14 Sep 2012 12:49:05 +0300
Message-ID: <1347616145.2559.70.camel@deskari>
References: <1347538505-25359-1-git-send-email-archit@ti.com>
	  <1347538505-25359-10-git-send-email-archit@ti.com>
	 <1347612788.2559.57.camel@deskari> <5052F547.9090102@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-tPNs4HRqpS00ToqnlSGe"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:45641 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751502Ab2INJtL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 14 Sep 2012 05:49:11 -0400
Received: by lbbgj3 with SMTP id gj3so2617453lbb.19
        for <linux-omap@vger.kernel.org>; Fri, 14 Sep 2012 02:49:08 -0700 (PDT)
In-Reply-To: <5052F547.9090102@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <a0393947@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-tPNs4HRqpS00ToqnlSGe
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2012-09-14 at 14:43 +0530, Archit Taneja wrote:
> On Friday 14 September 2012 02:23 PM, Tomi Valkeinen wrote:
> > On Thu, 2012-09-13 at 17:44 +0530, Archit Taneja wrote:
> >> Scaling calculations for an overlay are done by comparing pixel clock =
of the
> >> connected overlay manager and the core clock of DISPC. The pixel clock=
 is the
> >> output rate of the scalar. The scalar block needs to provide pixels at=
 this rate
> >> since the manager is connected to a panel, which has real time constra=
ints.
> >>
> >> In the case of writeback in memory to memory mode, the output of the s=
calar
> >> blocks aren't connected to a display, and hence there isn't a pixel cl=
ock which
> >> causes downscaling limitations.
> >>
> >> Make the input to scaling calculations a bit more generic by passing t=
he scalar
> >> output rate rather than passing pixel clock of the overlay manager con=
nected to
> >> the pipeline, as we now have use cases where the scalar's output may n=
ot go to
> >> a manager connected to a panel.
> >
> > Pixel clock is the rate at which pixels are processed. I don't see it
> > only meaning a clock that's related to actual video signal going out of
> > OMAP. So if in normal case the scaler outputs pixels at the rate of
> > pixel clock, we can call it pixel clock with WB's case also, instead of
> > renaming it to output clock.
>=20
> Pixel clock, in OMAP DSS terms, is the rate at which the video port of=
=20
> an overlay manager provides pixels to an output. It is a fixed rate at=
=20
> which the scaler needs to push out data.
>=20
> If we stick to this terminology of pixel clock, I don't think it applies=
=20
> to writeback. As far as I see it, there is no specific rate at which the=
=20
> scaler outputs data, it adjusts itself based on how much scaling is=20
> done, and at the rate we can get/push data to the interconnect. That's=
=20
> why I didn't want to call it pixel clock. Because, that sounds a lot=20
> like a fixed rate at which pixels need to be output.

I see your reasoning. I'm a bit reluctant to add a new clock term to
omapdss. You can't (probably) find it in the TRM. Does the TRM talk
about clocks with regard to WB?

I do think pixel clock can be used as well here. While normally used for
output, it's just a clock used for pixels, and at each tick we process
one pixel, which is exactly what happens with WB also.

Also, if I understood right, this pixel clock is not even used for WB,
and in a later patch you just use a dummy value of 1 for the clock for
WB. So even if pixel clock would not be the best name, would it make
sense to use the name of pixel clock, but return 0 as the pck for WB,
implying that pck is not valid/does not exist, and the scaling
restrictions can be skipped for that?

 Tomi


--=-tPNs4HRqpS00ToqnlSGe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQUv2RAAoJEPo9qoy8lh71WUoP/RjBhUR4h30pziMLyLxA23+7
NlVVFNbrNnsR432oWTNa3xcydFTQG+EKy7cdtyPdPAUG341BQUpOfVTTG/RtphT5
UrjlUMNXS1NDFEBnbLgm78uD0vrP3rF/udsCfEklSjmdyJSondldAbGYW1apBZhL
jHuNhTtDjB9Ns6np3HLJHxwZrtD/9cu6hVuSxQJ6Q4XgHPs5A+SU2UKJMqwOHNTK
cHuzWlkqKIAqdSYrx/k5OPXZlgMGrpv1mw04OAhzpT+L4ixqQXt0JjVOk6Be4OB5
eDdrSEbuSoFAeg8WGbmc99Cybuj8N0dPC8EAnGxFp11qIA2pv4vpFiF4DxHxU1Y7
1KsJu7RAwrwhHseYB7/Cvw7A5fmHJ87TwezObZvVee9COyWT0sOGmfMZWp/deEfH
rnXb1CFEro3//ve7qd8D7ybz+gQIVgiy2XvJn3DMyH76BU4I5H4drG7XQGWPck8S
0Qjd/xae4pYdA9ho1fsywUVhqCXWUk268kwOXFN0fdHIBoz9uJBV/Fa11w4rgkd+
bwmRV7+rtSHFCOGl85ckn0exJWpmFur2GNwckgOKwDaswrMADTtQuTyWEB2C5Bc9
kVqy4d+VbTWzGclIjJQwtK6VJSUQrRaNwQtsAgTfhfQELgdqVk//UxFrnN7CYAHD
DtZkh06fisrIQhW9qrAo
=jAV6
-----END PGP SIGNATURE-----

--=-tPNs4HRqpS00ToqnlSGe--

