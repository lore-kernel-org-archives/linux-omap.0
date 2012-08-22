From: Andreas Kemnade <andreas@kemnade.info>
Subject: Re: receiving data from mcbsp1 in master mode
Date: Wed, 22 Aug 2012 22:19:42 +0200
Message-ID: <20120822221942.2ebb4fd3@kemnade.info>
References: <20120821074205.0a36f648@kemnade.info>
	<5033903B.8000009@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/r2AlVISuDfx0u3D_hSaF_.I"; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from h1355771.stratoserver.net ([85.214.105.140]:42324 "EHLO
	h1355771.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932126Ab2HVUTZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Aug 2012 16:19:25 -0400
In-Reply-To: <5033903B.8000009@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: linux-omap@vger.kernel.org

--Sig_/r2AlVISuDfx0u3D_hSaF_.I
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, 21 Aug 2012 16:42:19 +0300
Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:

> On 08/21/2012 08:42 AM, Andreas Kemnade wrote:
> > Hi,
> >=20
> > I tried a couple of times with different kernels to use mcbsp1 of dm3730
> > in master mode (so that it sends out clocks).
> > The result always is that I can send data out. but arecord gets no inpu=
t. It
> > waits for input but does not get anything, although clocks are generate=
d,
> > checked that with a scope.=20
> >=20
> > I even took a driver which works in master mode on another mcbsp and ju=
st changed
> > the mcbsp number.
> > What needs to be done to receive data from mcbsp1?
>=20
> You should check the PIN mux configuration of McBSP1 FSR/CLKR pins. McBSP=
1 on
> dm3730 have 6 pin configuration. I think the capture should work fine if =
you
> select the FSX as FSR source, and CLKX as CLKR source.
>
if I understand the TRM correctly, according to Figure 21-26 in chapter 21.=
4.2.3.
if GSYNC is set, the receiver uses the signal from the sample rate generato=
r,
so CLKX does not need to be the CLKR source.
But I tried also with the DEVCONF0 MCBSP1_CLKR bit as you proposed.
I tried
 snd_soc_dai_set_sysclk(cpu_dai, OMAP_MCBSP_CLKR_SRC_CLKX, 0,
                                     SND_SOC_CLOCK_OUT);
 snd_soc_dai_set_sysclk(cpu_dai, OMAP_MCBSP_FSR_SRC_FSX, 0,
                                     SND_SOC_CLOCK_OUT);

 That is why I send you my patch about that mux settings. But I had no succ=
ess.
The CLKX as CLKR source and FSX as FSR source setting I have only seen when
mcbsp1 is used in slave mode. If you know any working code which uses mcbsp=
1 in
master mode then let me know.

Greetings
Andreas Kemnade

--Sig_/r2AlVISuDfx0u3D_hSaF_.I
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlA1Pt4ACgkQvUy8S31NDebrzACgrBp5Msw9zD6b1+oAn5USN7MA
40cAoJuxwMMve2b3QSNzkBHO8Il0aeRX
=qSxZ
-----END PGP SIGNATURE-----

--Sig_/r2AlVISuDfx0u3D_hSaF_.I--
