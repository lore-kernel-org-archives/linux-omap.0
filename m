From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: omap: Call omap_mcbsp_set_threshold() from mcbsp
 hw_params
Date: Tue, 26 Mar 2013 14:11:42 +0000
Message-ID: <20130326141142.GY18316@opensource.wolfsonmicro.com>
References: <1364227096-12232-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ECAkxgSy0pGoHfdA"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:47188 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757619Ab3CZOLo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Mar 2013 10:11:44 -0400
Content-Disposition: inline
In-Reply-To: <1364227096-12232-1-git-send-email-lars@metafoo.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org


--ECAkxgSy0pGoHfdA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 25, 2013 at 04:58:16PM +0100, Lars-Peter Clausen wrote:
> The omap PCM driver provides a set_threshold callback which gets called by the
> PCM driver when either playback or capture is started. The only DAI driver which
> sets this callback is the mcbsp driver. This patch removes the callback from the

Applied, thanks.

--ECAkxgSy0pGoHfdA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRUayWAAoJELSic+t+oim9segP/R4cQBUXbDFqAxjUHWKzLaIt
J4qUth6mmYClPdGwsJh2zoO48qr7ChtT3xwEb6wUZI7zOMMmkoqGA42I2izIKkDo
wa8iEyI67AiZEY2TcJECG8iu2ngSdrt649LQZBwLOu17YhKbQO5vi/vDCQwHCjUU
sTTtZd38w+Z2RBtb6TVJmfcavnjffLXMRdLdiRujY9wpOmRmRx9V4X5scCvtnVdT
qycI7+AGV7oIIJcvqn6HGL/mozAT/Jpz3OoHdmPlH61+SezxoO+9zl+Lnp8pQvLh
vs7F4BA/cnv8A+Sesc+pMCAnA0XW6Fg2Xg/mmKLz8BL8iSTen76R3C8EI5gakXAq
P6AkuMW+xksoOaDuj54l7p1UjX8aEzARB6Foo2rxXlW9Q4NjBP4aKC0HEKp2vSuk
J2aU6P++JwzL8HJNxKwmRggRYLEQMaiH7hX7PfWi0Z8/nbmdBnA6W/KoFJp6VUY2
5HlUSRc2j8fTwgp1CnRIQbHIdKKpL59BSFrHO0VEslpufrvogxj/tp2vcLjjxPRB
y4MCOZgqvRjp4VzNsc4jrWVymPoGCSeDcQ3a6xc4tBM7esfIYAMuT5ZfmD8uhJ0q
x2Syf4iw3RamKpXqv4aLoVNU/toeNVWGbg+b78wAR7BW95imsQ0wYoCbVrBRZ16S
6S7hmUNGnU9/rCS0GFMr
=pOhl
-----END PGP SIGNATURE-----

--ECAkxgSy0pGoHfdA--
