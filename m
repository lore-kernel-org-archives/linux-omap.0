From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/4] mfd: smsc: Add support for smsc gpio io/keypad driver
Date: Tue, 21 Aug 2012 15:08:03 +0100
Message-ID: <20120821140803.GK7995@opensource.wolfsonmicro.com>
References: <1345545940-2232-1-git-send-email-sourav.poddar@ti.com>
 <1345545940-2232-2-git-send-email-sourav.poddar@ti.com>
 <20120821124146.GA21557@sirena.org.uk>
 <20120821124243.GG10347@arwen.pp.htv.fi>
 <20120821132222.GF7995@opensource.wolfsonmicro.com>
 <20120821132741.GI10347@arwen.pp.htv.fi>
 <20120821134936.GH7995@opensource.wolfsonmicro.com>
 <20120821135240.GJ10347@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NhBACjNc9vV+/oop"
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120821135240.GJ10347@arwen.pp.htv.fi>
Sender: linux-input-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Sourav Poddar <sourav.poddar@ti.com>, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--NhBACjNc9vV+/oop
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 21, 2012 at 04:52:41PM +0300, Felipe Balbi wrote:

> Fair enough, we have "quiet", but I'm not sure that's enough argument to
> allow any simple driver to start poluting dmesg with whatever random
> messages.

I think if the driver is just logging to say "I'm running" that's noise
and I do push back on that routinely myself; if the driver is providing
information it's discovered from the running system then that seems much
more useful and we should have a sensible way of getting that out in a
place where users are likely to find.

--NhBACjNc9vV+/oop
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQM5YUAAoJEFJkBDiqVpZ4SrUP/j8p46LYoFa/yNQip8AKzcGk
e+Z111D79xMraAgsrFbNuHd+GOyr8y5n2L4e1RVwepJVWxTA1VOBCfKdHZdBWx4A
Y7iaBRVqCBdeEFiSAaYB6kTpt2tiInMi8EEXppRAnwwRYkYuJGUxg/y8iT8yFuma
dTcqmn2Bp4DFl/FttS6juzGPzdJj2PqJ1mo8ZTzsQ642nsuuL+74V65+V3qP8s8B
+cxDH4JxfJhTcKaZ8cyUBFhQrHxjcJzjr2ncpRcQLo5ehwX0dCL20SdTnq9/WJGl
xrXsR6SLFJ5sG19BW+0rXEB288CtodKJFu1iNm+D+D57xjFM3WrvSA9LE1LNeRvD
kUfYEOHmS43Fcou5X5KUAzu8gBWkMczoaLLIkbuPmeNm1WZKd8AYKRSoY6cUgCnq
5s6fpK0BKpwe5MZqqdPYSRp9IoRCWTQNQzumVoEA4KjA753WA42A+CQyUGKPxTK2
T+6ZFkpYTcVLClCZ5/YYiyUCRfN7aeVkDhlkhnkrw9+d19vAwcrKaeJ2eAIJgOts
RmAljvytI7Vrz3Xw+cDtRiSeUsspgJ1e3HdyUEZ7Lm/1Epaw8xW4yAk4LZqKHHi2
/aKpAAvaObZeDgO1HvSsSx9s42CaRoBe6Li4VIwzPL1DusJT5l+V+ERe8CHT8WIa
afA3sUoP6hfLj1XzoRL/
=4LvX
-----END PGP SIGNATURE-----

--NhBACjNc9vV+/oop--
