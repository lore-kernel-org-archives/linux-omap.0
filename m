From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] fix NULL pointer dereference in DSS2 VENC sysfs debug
 attr on OMAP4
Date: Wed, 25 Jan 2012 12:49:53 +0200
Message-ID: <1327488593.1858.22.camel@deskari>
References: <1327419882-13578-1-git-send-email-danny.kukawka@bisect.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-KmMn3KwoIS7xzRTTbZFH"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:59329 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751903Ab2AYKuA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Jan 2012 05:50:00 -0500
In-Reply-To: <1327419882-13578-1-git-send-email-danny.kukawka@bisect.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Danny Kukawka <danny.kukawka@bisect.de>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-KmMn3KwoIS7xzRTTbZFH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-01-24 at 16:44 +0100, Danny Kukawka wrote:
> Commit ba02fa37de80bea10d706f39f076dd848348320a disabled the
> venc driver registration on OMAP4. Since the driver never gets
> probed/initialised your get a dereferenceed NULL pointer if you
> try to get info from /sys/kernel/debug/omapdss/venc
>=20
> Return info message about disabled venc if venc_dump_regs() gets called.
>=20
> Signed-off-by: Danny Kukawka <danny.kukawka@bisect.de>
> ---
>  drivers/video/omap2/dss/venc.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/ven=
c.c
> index b3e9f90..82865be 100644
> --- a/drivers/video/omap2/dss/venc.c
> +++ b/drivers/video/omap2/dss/venc.c
> @@ -699,6 +699,11 @@ void venc_dump_regs(struct seq_file *s)
>  {
>  #define DUMPREG(r) seq_printf(s, "%-35s %08x\n", #r, venc_read_reg(r))
> =20
> +	if (cpu_is_omap44xx()) {
> +		seq_printf(s, "VENC currently disabled on OMAP44xx\n");
> +		return;
> +	}
> +
>  	if (venc_runtime_get())
>  		return;
> =20

Thanks. A bit hacky, but so is the whole omap4/venc problem. I'll apply
to dss tree.

 Tomi


--=-KmMn3KwoIS7xzRTTbZFH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPH95RAAoJEPo9qoy8lh71FysP/2OIsyMeX7pf+o/atOdqgDqz
QNnSuJyZKqt+7Ld2LQdSCj/auJr72gTlTt9PQfHUqBPjYtbAtUIl3eWGHLTL6qDS
vvnyW+jGNODiMG8RpFGB+7F+SsSZ8iyjXLk32WAQquerxLNEhNnwyLp21B0A7PmI
wT4prZFYLjstx1DqwYQo6jmlXcdn6U3/LAdoq8FLN27qd6MwN2Bv+EUaE/fMUyUp
FDShqjV6cvywbVTe/sT63OjCns9p5L8MEab9z4/UuywqCv31ET37zQDTegfzLBSi
5kLTmDri8l4lJlIcxyDVb3b3IlLbsUv/ke92chlqTHT82hVgOscZYFLw9neM9HwY
AhOsYa8jQqC3ItzgNZpUf1okfI2BfYBy4CMDzqzYszsWaWQ41PUVFJGMunamI/XS
pueAUX8gr7aCaMUgdKwQD7Zw+X57Rn0fSnXAFp95RN2Vh9XfP0qToeYlZ11CpQcb
cMereSe0OddKRvLlTRmlLAE3ea83pLgEfgpHXxf3j9Kf51e2yWeFIwqZ1l8sHTuO
LX9nzzxJMFa51ivZucLu6Y/jjTWD3EpDrh0snsSaAGBrTPFMFoutwqF/Ze3VwzgB
Z/NMPKSrT3oEPb/IpmuKA+BQ0CgnDbFNsKPaygmgWqtUmkdzPhK/xrlx9U8aJn5t
6u8FH2IuiJYImxQh1a0s
=Y2zd
-----END PGP SIGNATURE-----

--=-KmMn3KwoIS7xzRTTbZFH--

