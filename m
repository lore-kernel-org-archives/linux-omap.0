From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V2 2/2] ASoC: OMAP2+: Move McBSP, DMIC and McPDM to
 generic DMA DT binding
Date: Mon, 11 Mar 2013 14:33:03 +0000
Message-ID: <20130311143303.GC10617@opensource.wolfsonmicro.com>
References: <1362988223-22455-1-git-send-email-s-guiriec@ti.com>
 <1362988223-22455-3-git-send-email-s-guiriec@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xesSdrSSBC0PokLI"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:53296 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751093Ab3CKOdG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Mar 2013 10:33:06 -0400
Content-Disposition: inline
In-Reply-To: <1362988223-22455-3-git-send-email-s-guiriec@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastien Guiriec <s-guiriec@ti.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <b-cousson@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org


--xesSdrSSBC0PokLI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 11, 2013 at 08:50:22AM +0100, Sebastien Guiriec wrote:
> Update OMAP2+ driver in order to use OMAP DMA DT binding for OMAP2+.
> In case of DT boot snd_dmaengine_generic_pcm_open function is used.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

or I can apply to ASoC if people prefer, I don't think it makes much
difference either way.

--xesSdrSSBC0PokLI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRPesSAAoJELSic+t+oim9OzsP/jeqct/lwEiSuCtkBOC9YnXb
Ngrq4OTQtgPhrosdE7lDExDLDKeyhJe0binhaPmlW87nrgrYphfVe+j/jU6qWMOZ
gigzqL0Kl7d0OYPZ2vpXSYT2pmId1LUrF7vec68gLfelu68iPh/6zlVmfIHmxDfg
PzlYna830BsTESUhBoFEmAYKaAHFG6LHntXojc20CjrPh4cuM/ZsimYwtAQy4Eu8
8Xxl0IcgkwxeSoM3cUHET5gtAZ4BWx9T/DMOnD8HZdd172+9eFZE7AlhT5SSJW9k
fm+/+6p5m5XdIqwIo4X4UPq2hH4BH/EW8Op0+0YCSy/7IUZuEhK9GvC6WNA9Pua4
8QIo/5/4jk6HEQ34EaHbv1hyq/PIFvs0XRh17KY0ICeCfAQA+ezgPXPNSnxT+xDh
t8mtf47oLVVOYZv2RehMhtKhhiF4B9zSvBxCke1NDgL+43uZcFlkU1S0nQgTBSNT
4FSTaG7bEeJIUE02P1/t9XITWqHo7NBtoouRr8ZaFdeqbp8sgn7EcdJDv12bs8ik
4hr01pAGrXqpXKbo5Z8+xhA4e74QPAYrPtTZGhuw+GJnRjK1k8dLya6WaSNoWV80
fpzwma/heVPH7TUl4ho9f8NrjeZ7Wld19eT/gfJ1naRFqN3Vq2/Wtgq3BOUEgxBq
cw8kOgSTVpTD7j/ln9Oc
=CKC/
-----END PGP SIGNATURE-----

--xesSdrSSBC0PokLI--
