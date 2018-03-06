From: Mark Brown <broonie@kernel.org>
Subject: Re: Regulator regression in next-20180305
Date: Tue, 6 Mar 2018 19:12:18 +0000
Message-ID: <20180306191218.GF13586@sirena.org.uk>
References: <20180305231246.GB5799@atomide.com>
 <CAOMZO5CXy=7ZKVapp_2Q4wq=mY-dJ0owZZN84vqUj1j1xasOKg@mail.gmail.com>
 <20180306163035.GE13586@sirena.org.uk>
 <CAOMZO5DL_a8DOKgyZ4j2-bcPZLeUtQ9ekc74yVwtKYofbpOafg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8TaQrIeukR7mmbKf"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOMZO5DL_a8DOKgyZ4j2-bcPZLeUtQ9ekc74yVwtKYofbpOafg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Maciej Purski <m.purski@samsung.com>, linux-omap@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org


--8TaQrIeukR7mmbKf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 06, 2018 at 01:56:42PM -0300, Fabio Estevam wrote:
> On Tue, Mar 6, 2018 at 1:30 PM, Mark Brown <broonie@kernel.org> wrote:

> > -       for (i = 0; rdev; rdev = rdev_get_supply(rdev), i++)
> > +       for (i = 1000; rdev; rdev = rdev_get_supply(rdev), i++)
> >                 mutex_lock_nested(&rdev->mutex, i);

> With this change the log is a bit different, but still get a kernel hang:
> https://pastebin.com/eF08TnuT

Yeah, that's what I expected.  What we really need to figure out I think
is what exactly is taking the lock that we end up colliding with, I
don't seem to be able to reproduce so I'm having to just go on staring
at the code here.

--8TaQrIeukR7mmbKf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqe6BIACgkQJNaLcl1U
h9C6Mwf/TpWxJKwUprayYcpopNp7taEsA/MC6XT0/R7jcrCT1CsP/XbsgMT96yW5
NJ0zhtO2mt+z1aayp82JKS5fsx53kUwbkzaWAjBJZyhZOvvQpmcTttrB8WNThT6d
muYi9X/Vhhjo2sWBlJW1GdwNo2S6z+FKFeTjt2n9RKJFxXPGJCRFM/EDnrMz4YMD
V7piEh8RpFmgAlMU6USHZ/RUhIFwAUOOALOb2AKuZPRdYiP78ZNjnvDKpfT3wIBp
1WgAsDqj/LN1NQmbJIHS//g9e5HhIcxx43o0KLLFz0tXtZaltHEk9d+yjZ4/rWGU
9+33XhXTvtG+5NJ3cpCis3+E3H2f4w==
=NZwF
-----END PGP SIGNATURE-----

--8TaQrIeukR7mmbKf--
