From: Mark Brown <broonie@kernel.org>
Subject: Re: Regulator regression in next-20180305
Date: Wed, 7 Mar 2018 14:45:05 +0000
Message-ID: <20180307144505.GH7290@sirena.org.uk>
References: <20180305231246.GB5799@atomide.com>
 <CAOMZO5CXy=7ZKVapp_2Q4wq=mY-dJ0owZZN84vqUj1j1xasOKg@mail.gmail.com>
 <20180306163035.GE13586@sirena.org.uk>
 <CAOMZO5DL_a8DOKgyZ4j2-bcPZLeUtQ9ekc74yVwtKYofbpOafg@mail.gmail.com>
 <20180306191218.GF13586@sirena.org.uk>
 <CAOMZO5BfEfXN6OgxXswm8qFDbxDJKdUJmhDZGr_DBOh8fbtodA@mail.gmail.com>
 <20180306213350.GH13586@sirena.org.uk>
 <CAOMZO5BPyY3WUYUhV76HGdb_NbCv9riFdtEFaku2k4dd9-A_FQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/9ZOS6odDaRI+0hI"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOMZO5BPyY3WUYUhV76HGdb_NbCv9riFdtEFaku2k4dd9-A_FQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Maciej Purski <m.purski@samsung.com>, linux-omap@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org


--/9ZOS6odDaRI+0hI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 06, 2018 at 07:10:01PM -0300, Fabio Estevam wrote:

> Yesterday I spent a few hours trying to understand this locking issue,
> but didn't get any success on this task.

Right, so I'm thinking that if it's taking this much effort to think
about the problem we should just drop the patch set for now.  I've moved
the code to a branch test/coupled in my git so it's not getting in
people's way in -next.  Maciej, I suspect that you might be able to
reproduce this if you set supply names in the regulator definitons for
the PMICs on your boards.  I think that's the difference here.

--/9ZOS6odDaRI+0hI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqf+vEACgkQJNaLcl1U
h9BKogf9F0boHNGnHBqZtD2wGZhRaJ8/T7H8EYEeUHUCTxywbLrKSKy2VMRlSzTZ
0ImVGUxHInTddk/Q9SNcG1FPg1mkrdt/hqhKeeZrlYJ/T9SgJrni2AGccctcmmKB
av34yHlGfusEpAa8EhfLbkh4dH9K6F8UG0BF4+Z6NP8D65aUDg/AEwo1sF/cIN0k
lhwIRyj2Z9ZPCsLyZP9QtQwNxFQ0i4k4IdV1ffWlITEhrhgVoU/nNOd5dJ3vf76Z
rV+2LokVtu38YmKdlgLYTgLtwFj9bLfBduFS6pf0XjmHvLil8YcBw9xhejg6fbqX
IJoVUs1e/K/UlsZWn2JoKErlIvOK2Q==
=Bkec
-----END PGP SIGNATURE-----

--/9ZOS6odDaRI+0hI--
