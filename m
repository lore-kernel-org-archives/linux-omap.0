From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] Regression in next with codec unload and
 snd_soc_component_get/put
Date: Tue, 13 Aug 2019 12:29:20 +0100
Message-ID: <20190813112920.GC5093@sirena.co.uk>
References: <20190809070003.GA52127@atomide.com>
 <s5hwofmhkbs.wl-tiwai@suse.de>
 <20190809074643.GB52127@atomide.com>
 <s5hv9v6hhm9.wl-tiwai@suse.de>
 <20190813102451.GJ52127@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="raC6veAxrt5nqIoY"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190813102451.GJ52127@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Takashi Iwai <tiwai@suse.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


--raC6veAxrt5nqIoY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 13, 2019 at 03:24:51AM -0700, Tony Lindgren wrote:
> * Takashi Iwai <tiwai@suse.de> [190809 08:24]:

> > ... and it was already fixed in the later commit 0e36f36b04e7
> > "ASoC: soc-core: fix module_put() warning in soc_cleanup_component".

> Mark, looks like this commit is still not in Linux next, forgot
> to push out something?

There's a build failure the Intel guys haven't fixed.

--raC6veAxrt5nqIoY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1Snw8ACgkQJNaLcl1U
h9DF/Qf/WDdJEsNmRPfcsZFd9wcH/l/YYYCUVgA62rjOVqjdmJimIzjWXlc+W4xw
CZk3JtYhXgKz31j0/toBAkOS8bbArTQtWi5+40EuzExrZKV/MYBA2dlSSYKazuQO
bDQBxTg5kKAafEyViBEVMxCey+ubNGO4Ms69de/KW1lmZeEqtfSHPzOjWgrEI+H9
1xjLx4KVTDk2o3TaSc0iKj7MNCKJy0nBW/VnW8RxJiOnKu+kO2G4lBpCu+/0afjm
f+oufYCVjGXJKKv5SBsfB30/c11H+PindiU1ECSY5mn0YytmPY+cC2d00aE20GXY
v3jxVVy7d8M5zo4qooHjGF84oeCX7w==
=XIoR
-----END PGP SIGNATURE-----

--raC6veAxrt5nqIoY--
