From: Mark Brown <broonie@kernel.org>
Subject: Re: commit c368e5fc2a190923b786f2de3e79430ea3566a25 regresses MMC
Date: Wed, 20 Nov 2013 20:34:00 +0000
Message-ID: <20131120203400.GL2674@sirena.org.uk>
References: <20131120175814.GC27423@saruman.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BOHdEyqYAbgZNeC0"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20131120175814.GC27423@saruman.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: ldewangan@nvidia.com, lgirdwood@gmail.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org


--BOHdEyqYAbgZNeC0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 20, 2013 at 11:58:14AM -0600, Felipe Balbi wrote:

> commit c368e5fc2a190923b786f2de3e79430ea3566a25 (regulator: fixed: get
> rid of {get|list}_voltage()) regresses any MMC host controller which
> uses fixed regulator for functionality.

This is already fixed in -next.  Please remember to always CC
maintainers on mails and please try to write subject lines which are
readable by humans - full SHA1s for commits that obscure any actual
content don't help.

--BOHdEyqYAbgZNeC0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSjRy1AAoJELSic+t+oim9oVoP/0lfe126LNuvhEwFW1mvHlm3
VoO7QFg6lP2OHzgMx7rfvCeFspVumerWIvMFqyGFd8zZdcN1sYN/BVJqg0YUbx1q
ZBQ0FLMTkc0S0c8BPifI+U8T4wTeiYyjrB9AjkOx+xRymR6E9sMjgoLkqm7sB9oe
bpv1FGzu8CzSoEdfm6mfKyhwnIAxHT+mMTCLA1wiC0gUXbYJrDibn1mYaiTamFjQ
4P+cttDpT5AeAwOIBu8sFnAbChB3bLGzTyhu9WkI5maY6RhemsKrWu0n95gP83jo
35AgciUQNdRVwXti2HpE3eEIZASF9uuBwIzBBCJmzU3IE8wccnjQ7z5BG/iAhoGC
h+4B+byBTk8GxrYpi2ka4yxsW03IDaV1/K1xbH6QgKmGwk+Vo0gzf68+lTOdB64l
gLya//KndYHOM3I6b2HSkBzYuPgvOThrYujJ7LoBNZJeEn4w2cLJNEE5qkgas6uv
rjYSgTk1Ct7XuoSF7/NGxSGZ+MmUfsxSJVcj0UXstplCUoZrSzw36N88A1GlGGN+
Pqnygc/rtLyCSSudv8C2RmMCxHRaUIBXY+N1OO/Dq0dyDWsdnc7kqo7aElTNeC/2
xQov1AiNfBOOjtp0C+jpjh0zQvYNk3zAfJgdm8P/T72adMI/QhqRg6KQpwOowgUH
JAsZlWsGYlpy3ev/1kh3
=Qmyd
-----END PGP SIGNATURE-----

--BOHdEyqYAbgZNeC0--
