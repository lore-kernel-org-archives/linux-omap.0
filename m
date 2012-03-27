From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 0/3] OMAPDSS: HDMI: Interrupt and PHY state handling
 support
Date: Tue, 27 Mar 2012 13:29:49 +0300
Message-ID: <1332844189.1867.109.camel@deskari>
References: <1332249307-26875-1-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-NqI2Zq/vVdvXkT2gr/Cy"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:53045 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750956Ab2C0Kbp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Mar 2012 06:31:45 -0400
Received: by mail-lpp01m010-f46.google.com with SMTP id j13so6628883lah.33
        for <linux-omap@vger.kernel.org>; Tue, 27 Mar 2012 03:31:43 -0700 (PDT)
In-Reply-To: <1332249307-26875-1-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mythripk@ti.com
Cc: linux-omap@vger.kernel.org


--=-NqI2Zq/vVdvXkT2gr/Cy
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-03-20 at 18:45 +0530, mythripk@ti.com wrote:
> From: Mythri P K <mythripk@ti.com>
>=20
> Add support for handling the DSS_HDMI interrupt in HDMI, A line that serv=
es to
> notify HDMI of status change in PHY, PLL and CORE based on the registrati=
on.
> Also logic to support enabling of the PHY in TX_ON state only when a PHY_=
CONNECT
> which would make sure that TMDS lines are high before putting it in TX_ON=
 state.
>=20
> Mythri P K (3):
>   OMAPDSS: HDMI: support for interrupt enabling
>   OMAPDSS: HDMI: Add support for DSS_HDMI Interrupt
>   OMAPDSS: HDMI: wait for TMDS to be high before putting phy in TX_ON

Sorry, but this patch set is quite bad.

First of all, the subject on your third patch is again cut short. How do
you even do that? The subject seems to be fine above. I've never seen
other people do that, but you somehow manage to do it all the time. So,
please, read the git manual, fix your environment, your way of working,
or whatever is causing this so that we'll never see it again.

Then, the intro text above is rather confusing. Are there words missing
around the part with "PHY_CONNECT"? Please spend more time on the
descriptions, and possibly ask someone to proof-read them so that at
least there aren't words missing and they are somehow understandable.

I'll comment on other things in later mails.

 Tomi


--=-NqI2Zq/vVdvXkT2gr/Cy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPcZadAAoJEPo9qoy8lh71e4UQAKu+bO4Sn3bf+caT9Eb5cuM5
2X5jSchbyZ0Tq3yfZDGgYuH55GMsQwfXWQ1u+9sXxWU7ca9ETsQQXgO83A6BFJzj
R5ilMBf05rDYieon7RhjcNg7eqMuKJ5FoZNMx7qZyqIniob2pamWQ2m4pIpZqMMP
nHyDPlKs8hVAa9kG/N1x9/+DSP9DtsPnnswdKDv2Ypl8G5O2Iv62iWYKqK0isSLM
xy1IY+leXtp96Iow0DpZijKqiIsXay1hCjSMNRUOO4isu13ZD3dgpAL9nEthEb3x
2Y9i7ulmYiG/8itEbkqTaaqQG/b8z60jAFXJ5Z40oPWHX2DW/9F3877SF9Wawfml
4pmdB/6pEPg9oqR0tsCz7AV6gfZM+3fPSScSqQH4HV1GWSotuR/tsTcM9f0ZzqMl
xGWVQtWNuQTtm51KcbH/puRXVyh3/vGZEA63tCptxeKQzAzj9Gck4L7Se/SxpSJa
CDUgZJ511bZoqvaMpnENw8qNOuzvGiLnDM8XL2P19vMYUoJdstCbWTWki4NP3dPG
YBMqZFBHHtus7HHuIiz2UnjlsfqvImFrHHX+C2gQsrsNADOWD0dI8whZEYHQHS0B
E3q1JrYDbiUNrbS3Sw6Jb/aMqk4hgKsSfguc456WrypqmFu7G02y47KuXf6wJ+KP
96DfN9rGU1nIaZMDcpKe
=UpMl
-----END PGP SIGNATURE-----

--=-NqI2Zq/vVdvXkT2gr/Cy--

