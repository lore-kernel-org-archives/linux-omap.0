From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv3 8/8] i2c: omap: cleanup the sysc write
Date: Mon, 5 Nov 2012 16:25:17 +0200
Message-ID: <20121105142517.GG4815@arwen.pp.htv.fi>
References: <1352118223-3796-1-git-send-email-shubhrajyoti@ti.com>
 <1352118223-3796-9-git-send-email-shubhrajyoti@ti.com>
 <20121105141442.GD4815@arwen.pp.htv.fi>
 <5097CBF1.6060108@ti.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+1TulI7fc0PCHNy3"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5097CBF1.6060108-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--+1TulI7fc0PCHNy3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 05, 2012 at 07:53:45PM +0530, Shubhrajyoti wrote:
> On Monday 05 November 2012 07:44 PM, Felipe Balbi wrote:
> >> -							dev->syscstate);
> >> > -		}
> > not sure if this will work. What about the first time you call reset() ?
> > won't SYSC just contain the reset values ?
> No actually the hwmod sets the value.

ahaaa, ok good. Let's get an Ack from Benoit, then.

--=20
balbi

--+1TulI7fc0PCHNy3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQl8xNAAoJEIaOsuA1yqREAE4P/0t3r4SgK68i+0Vqj7d5bVFZ
qhkocze6ufwBlj/69ZJ1KgQqwCuzVzGOIq0MARrF+RTT6VpUG6wQYeeITkR53bGc
g5mE7P9Ec1dVRYEbGH1ClUvnzV3YeOHZ9Kf3uSkNIBMErUFeMF6F+Bj3GsP5AD8m
8NZQl/V/OtfmmedEfMXHo7SvAAYPh5SKjL4TVksPAQ5G/IePe06M8kE0phxHaz+z
gN2H88XXdpvvrSI+nlONvqwIix09sEZy6/EuTIVPOCHIbkkstBdBGFnGW+M4Q0Yb
BJvb3Jw/pEMjay3bwtRXmXwCTLy/jVsMKUz9Hhruu6L9d9TmCX/oTug3Uso4feup
WDyQrWpmz4dgrDId8Xq7hgjToeTh8BbREQc6SyC+jtvAQhzXCbYplxma5WGuCD09
0+pToomSi+Bxe3AjAS/zzOkH7AbJTrRltbuIcpXie6AWl1srEOQsgcbEPtrOtTsQ
LGF5Rvk/v/etH892WOkWHrStx/cHWg7Kh5OHaxLtBhZfKF5I9WioOX4Nqvt6jj8Q
kp8LPxKWN2uvqo/Gwr4d6GqWykcRiuh5FK9jadEcSodpznTZKL3jepgNjr1g9PBn
XPLOpWZ5NMzfApdH0WZQgKNvxZi4D0WUUOn7lYDAsGXvcGoL7aAuf0frzStpTbEQ
Uq99upMdPBM17DE8NVIZ
=Z6tu
-----END PGP SIGNATURE-----

--+1TulI7fc0PCHNy3--
