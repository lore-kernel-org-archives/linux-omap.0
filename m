From: Mark Brown <broonie@kernel.org>
Subject: Re: Regression in v5.0-rc with regmap-irq level-irq changes
Date: Wed, 16 Jan 2019 12:52:10 +0000
Message-ID: <20190116125210.GA7186@sirena.org.uk>
References: <20190115192840.GK5544@atomide.com>
 <20190115210920.GJ5522@sirena.org.uk>
 <20190116001025.GL5544@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190116001025.GL5544@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Belisko Marek <marek.belisko@gmail.com>, "Dr. H. Nikolaus Schaller" <hns@goldelico.com>, Jon Hunter <jonathanh@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>, Keerthy <j-keerthy@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Tero Kristo <t-kristo@ti.com>, Thierry Reding <treding@nvidia.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 15, 2019 at 04:10:25PM -0800, Tony Lindgren wrote:
> * Mark Brown <broonie@kernel.org> [190115 21:09]:
> > On Tue, Jan 15, 2019 at 11:28:40AM -0800, Tony Lindgren wrote:

> > > Any ideas what's needed? Some triggering mapping data to palmas.c
> > > driver?

> > There should be a fix in -next already waiting for me to send it to
> > Linus, can you check there (a couple actually, in my for-linus branch)?

> OK great, yes the two drivers/base/regmap patches fix the issue
> for me.

Excellent, thanks for testing - I'm aiming to send them off this week, I
was going to send them off earlier but then the second fix came in.

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlw/KPcACgkQJNaLcl1U
h9DwqAgAgbp/wZ9ShYsmuBGRqZdnPQEW8wZpe9J1e5R5GTuMp3Cy1DCifx6ohZvk
IxQ8rb098HtKbLdK4ujaKoim33Q6e/du3O6hRUh1gYUBdh8TFVkYsFXkB01zPQyq
ZTfB46YNXuvMW7/ozyYA7C/nH1ELFSoxryuLOHFkgrZDOo90KwcrgkrnBzgoEvHb
4ZqwIcUXaEk1LkzR9XDiY+JjXe/pKLg4uiuwvCd7X3cjJSMOJeHTHwIYP91tK+yy
emHNsoG48aTVyBFjUIYf1Nni2YeZUj5/+Bi1Oo91rC2Z7k+glaPJnXwQsFBhbnH3
ue+lO3czhhIgW/jtnUe7uH+8LWNgpQ==
=DgRu
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
