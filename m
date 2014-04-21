From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH V2 05/19] bus: omap_l3_noc: switch over to relaxed
 variants of readl/writel
Date: Mon, 21 Apr 2014 10:09:19 -0500
Message-ID: <20140421150919.GE27341@saruman.home>
References: <1397492726-17203-1-git-send-email-nm@ti.com>
 <1397767775-10965-1-git-send-email-nm@ti.com>
 <1397767775-10965-6-git-send-email-nm@ti.com>
 <20140417215228.GD8504@saruman.home>
 <53504DFF.7090907@ti.com>
 <20140417220329.GF8504@saruman.home>
 <53551A2C.8060404@ti.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7LkOrbQMr4cezO2T"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <53551A2C.8060404-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Sricharan R <r.sricharan-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--7LkOrbQMr4cezO2T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 21, 2014 at 08:16:28AM -0500, Nishanth Menon wrote:
> On 04/17/2014 05:03 PM, Felipe Balbi wrote:
> > On Thu, Apr 17, 2014 at 05:56:15PM -0400, Santosh Shilimkar wrote:
> >> On Thursday 17 April 2014 05:52 PM, Felipe Balbi wrote:
> >>> Hi,
> >>>
> >>> On Thu, Apr 17, 2014 at 03:49:21PM -0500, Nishanth Menon wrote:
> >>>> Currently we use __raw_readl and writel in this driver, however, the=
re
> >>>
> >>> __raw_* and *_relaxed variants are the same, just have a look <asm/io=
=2Eh>
> >>>
> >> Except the relaxed version can take care of endian conversion if
> >> needed. :-)
> >=20
> > right, but according to commit log, this commit is more concerned about
> > the memory barriers which writel()/readl() add, not endianness. Just a
> > matter of fixing up commit log.
> >=20
>=20
> yep, this patch does replace writel with writel_relaxed there is no
> strong need for barriers in the operations that we perform here.
>=20
> I agree that the commit message should probably be a little more
> detailed at this point.
>=20
>=20
> How about:
> Currently we use __raw_readl and writel in this driver. Considering
> there is no specific need for a memory barrier, replacing writel with
> endian-neutral writel_relaxed and replacing __raw_readls with the
> corresponding endian-neutral readl_relaxed allows us to have a
> standard set of register operations for the driver.
>=20
> While at it, simplify address computation using variables for register.

reads a lot better, thanks

Acked-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>


--=20
balbi

--7LkOrbQMr4cezO2T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTVTSfAAoJEIaOsuA1yqREu90P/3ELCyVQIx21nLdXbJdn5XSA
oORPpzrVVd5gtGcUEFh2wm1VxpYQCDa67dFyZiT5XO+yZMGHxxyBRqwziBEVax8r
fzArrEO3IFGVBzc/+E1QH/EmcLhaGr2pYdGQhLDNLxJaEDQgyGk4D4zGRxvXqAfb
MoQztqTzoPXhvxsbpKSIZHD8yylKrv2A3diXqyZcoOORP0YjEjSoZGgEs/+lR9/S
bve6JW/QLvgUyBdW9eHcu8XwUOmZzgmUAA63Pi76vBmEx2/qj4xyC2wIHaMDQ2Ij
rcS3vsSgFwc7kKGDOG0iEAlTou2nnl57HQOlcDRpxA2FB7ohwj2Mfjoqkdl/A2Bw
6MiUP39OrBksF101MahcBdMBY8SGAcr1ZTDRsRO/K0pGNyYgrS1oWIg5jUD7UZcz
uur2cYU0CbY6KiM/Z9QhJSvyvXHeRNyrbgml2DuB9cbH644DoNlVtCqi+SyIybcL
4hqlJeXgYdiJBoXjLS46uJIm4GHLTOvsw/QKHZLL6onnDPFHUekeWkMYHcaEuLj6
R8nPfZcfm5bQp05BgR8SHCo6tXnDD8+6zyzTg9LZScYjBIwKZqPFztwMaDUMzJqQ
BbW5Gnt2JxFxi7W2TtTmM3Vh5Zw9Q3f7LcTw0OQLBJNN3tD1GfXzSIM+Ps0sudhg
SSUmlxJYbw3UTVArJtp3
=2gOW
-----END PGP SIGNATURE-----

--7LkOrbQMr4cezO2T--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
