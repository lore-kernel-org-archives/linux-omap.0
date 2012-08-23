From: Andreas Kemnade <andreas@kemnade.info>
Subject: Re: receiving data from mcbsp1 in master mode
Date: Thu, 23 Aug 2012 11:32:44 +0200
Message-ID: <20120823113244.1307371d@kemnade.info>
References: <20120821074205.0a36f648@kemnade.info>
	<5033903B.8000009@ti.com>
	<20120822221942.2ebb4fd3@kemnade.info>
	<5035EE3F.9000903@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/j+9f6siMDX/38JipWITJ0oq"; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from h1355771.stratoserver.net ([85.214.105.140]:35165 "EHLO
	h1355771.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758204Ab2HWJcH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Aug 2012 05:32:07 -0400
In-Reply-To: <5035EE3F.9000903@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: linux-omap@vger.kernel.org

--Sig_/j+9f6siMDX/38JipWITJ0oq
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Thu, 23 Aug 2012 11:47:59 +0300
Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:

> On 08/22/2012 11:19 PM, Andreas Kemnade wrote:
> > if I understand the TRM correctly, according to Figure 21-26 in chapter=
 21.4.2.3.
> > if GSYNC is set, the receiver uses the signal from the sample rate gene=
rator,
> > so CLKX does not need to be the CLKR source.
> > But I tried also with the DEVCONF0 MCBSP1_CLKR bit as you proposed.
> > I tried
> >  snd_soc_dai_set_sysclk(cpu_dai, OMAP_MCBSP_CLKR_SRC_CLKX, 0,
> >                                      SND_SOC_CLOCK_OUT);
> >  snd_soc_dai_set_sysclk(cpu_dai, OMAP_MCBSP_FSR_SRC_FSX, 0,
> >                                      SND_SOC_CLOCK_OUT);
>=20
> There is an issue with the 6pin mux code, try to add this patch:
> http://mailman.alsa-project.org/pipermail/alsa-devel/2012-August/054041.h=
tml
>=20
That is exactly the patch I was talking about in the next line, see
http://marc.info/?l=3Dlinux-omap&m=3D134540540412165&w=3D2

> >  That is why I send you my patch about that mux settings. But I had no =
success.
     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > The CLKX as CLKR source and FSX as FSR source setting I have only seen =
when
> > mcbsp1 is used in slave mode. If you know any working code which uses m=
cbsp1 in
> > master mode then let me know.
>=20
> No, I don't have board which uses McBSP1.
>=20
> --=20
> P=E9ter
>=20
>=20

--Sig_/j+9f6siMDX/38JipWITJ0oq
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlA1+LwACgkQvUy8S31NDeaqwACgk+35zD7F6s9XoH3bbeSLKFSn
MqEAmgMjpT5D2PyIdxv9tBOJZFbO3IG+
=A5hp
-----END PGP SIGNATURE-----

--Sig_/j+9f6siMDX/38JipWITJ0oq--
