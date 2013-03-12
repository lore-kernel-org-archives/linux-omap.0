From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V2 2/2] ASoC: OMAP2+: Move McBSP, DMIC and McPDM to
 generic DMA DT binding
Date: Tue, 12 Mar 2013 18:26:34 +0000
Message-ID: <20130312182634.GG19942@opensource.wolfsonmicro.com>
References: <1362988223-22455-1-git-send-email-s-guiriec@ti.com>
 <1362988223-22455-3-git-send-email-s-guiriec@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HKEL+t8MFpg/ASTE"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:51781 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932355Ab3CLS0g (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 12 Mar 2013 14:26:36 -0400
Content-Disposition: inline
In-Reply-To: <1362988223-22455-3-git-send-email-s-guiriec@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastien Guiriec <s-guiriec@ti.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <b-cousson@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org


--HKEL+t8MFpg/ASTE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 11, 2013 at 08:50:22AM +0100, Sebastien Guiriec wrote:
> Update OMAP2+ driver in order to use OMAP DMA DT binding for OMAP2+.
> In case of DT boot snd_dmaengine_generic_pcm_open function is used.

Applied, thanks.

--HKEL+t8MFpg/ASTE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRP3NTAAoJELSic+t+oim9lIcP/0wVeLOZfRLb8OKvb9mZnKE0
E+8JPeQIyC8M93AlQUJWP8Bjgtnb+d4qkaSHT6yVObsLVNvPm6QhU+smwNax4AGq
e1DDLOGSeGDjfXeUwx37ONyLWI4lj8PytwAgZSeTwKeJ2z8etRI7SXzhRQixzdlK
yMLmhzxmsqY79M3ZUWn+mf94PUVI3cOSSxNEmyeKrHdevgNFbvbqfhVGJZ2njhRW
2go72VWhGgGOsYCt9r0eg8qzKqhYsddC7zeaGC0J0X0vDy0vtyMKzE6J7RT85k64
NsSdGJZ2JJDEMInx6jWmWXpWK8kGCWDEyG7180hpwPr3bjwU+BfBvcVZr0eHk/RK
pDnkTRm/L16iakjabRP9hOynozYWSVzJKAHh9s3fpvdpdHueLGqEN/hejMwJqoVb
nkFJxXu/Pxevo/REFl4INH8KG5BAWAvRFQhkmBjpb6uQzQgaog0i1x47a7mT1sbq
imFV8GATkAk4ZEjEsiBngNtmGqjQjjNb8CQHMVic4hgZJxHBFF2JqhBZapSGqMqn
CyGD4Iq8ZHyGE01yoDGEgeS+go9+4BfzjMZ+fPRNUZsUcBiobTb8KREzhtzYvMLj
L1U05WL4XtnvcTfohUd7omK1jfLkZFgl0ESbqS3lOmElk7I7ot/sZZbOfO8/VTGg
vD8F8JsdnJWFTX9/jqpa
=2DyV
-----END PGP SIGNATURE-----

--HKEL+t8MFpg/ASTE--
