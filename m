From: Mark Brown <broonie@kernel.org>
Subject: Re: Regression in v5.0-rc with regmap-irq level-irq changes
Date: Tue, 15 Jan 2019 21:09:21 +0000
Message-ID: <20190115210920.GJ5522@sirena.org.uk>
References: <20190115192840.GK5544@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ONvqYzh+7ST5RsLk"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190115192840.GK5544@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Belisko Marek <marek.belisko@gmail.com>, "Dr. H. Nikolaus Schaller" <hns@goldelico.com>, Jon Hunter <jonathanh@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>, Keerthy <j-keerthy@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Tero Kristo <t-kristo@ti.com>, Thierry Reding <treding@nvidia.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--ONvqYzh+7ST5RsLk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 15, 2019 at 11:28:40AM -0800, Tony Lindgren wrote:

> Any ideas what's needed? Some triggering mapping data to palmas.c
> driver?

There should be a fix in -next already waiting for me to send it to
Linus, can you check there (a couple actually, in my for-linus branch)?

--ONvqYzh+7ST5RsLk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlw+TAAACgkQJNaLcl1U
h9AwIwf8C1ynMQh1N1yNP3/lscQNBS3K8lg9krjtYsdc+zKtloGVvHZLf8rafYsE
gnWZ8hF5cwMEAkCULG7/iW565WQ5p023DMPmNtk6u9jn3mrbsfk7eYJjapwXrDnL
vXwdJwQra2PVqQzlwjye7R2cg8sVHpt93e2tv1wCETqTqTZNLIrt+CV8qn9JniCG
auqMlP/rGMEjNENMh/rslWbpOrVbWnvWOND8h81q4uqFicr67LTSlwBOOkFom1n5
mlkXLgeFQgsqIaf3T8YVg3vyFmcp1ynTvCKLepDAIDdJyyY6AXbSCL6UoMPkyLQc
L6ks69fcLXODh7IT0NQaCZaYamiI2w==
=0Hrj
-----END PGP SIGNATURE-----

--ONvqYzh+7ST5RsLk--
