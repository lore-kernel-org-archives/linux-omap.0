From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFT/PATCH 6/7] arm: omap: smartreflex: fix IRQ handling bug
Date: Tue, 11 Oct 2011 15:19:37 +0300
Message-ID: <20111011121936.GN10155@legolas.emea.dhcp.ti.com>
References: <1318249579-4089-1-git-send-email-balbi@ti.com>
 <1318249579-4089-6-git-send-email-balbi@ti.com>
 <4E942748.80901@ru.mvista.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WU3I8Do+sziGY3UL"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:49894 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750756Ab1JKMTm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Oct 2011 08:19:42 -0400
Received: by mail-bw0-f50.google.com with SMTP id zt19so11249254bkb.37
        for <linux-omap@vger.kernel.org>; Tue, 11 Oct 2011 05:19:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4E942748.80901@ru.mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>


--WU3I8Do+sziGY3UL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 11, 2011 at 03:23:52PM +0400, Sergei Shtylyov wrote:
> Hello.
>=20
> On 10-10-2011 16:26, Felipe Balbi wrote:
>=20
> >fix a bug which has been on this driver since
> >it was added by the original commit 984aa6db
>=20
>    Please also specify that commit's summary in parens.

sure, no problem

--=20
balbi

--WU3I8Do+sziGY3UL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJOlDRYAAoJEIaOsuA1yqREbvIP/0Fiq4VZG7HLR2QK7qpgddqR
rynbtZYz+m46XuH8Nlj+bopwDAxomfRhqGgUmOmdwnE9xc6/9z6zwPDkawnXyOTV
BNpZ7TGg7cKXeW9aQpg9V3zz2v2EvYkPn3ZgNPVfMr4N+Lf/dK/aJpZQkExToom4
4QsgazFUXuLvcE5kuCkqLwJhXc+WZThaU0M/r+9Xd+gwUrPkKV95FKL7nF/2FvT2
QjhDtFKIcr0mWQETrXPLbMuN3+0CVOBjcTfAvtqvBZzaxIOevBLjoEqOeXqQNaa0
MCGyeRslilFo0zfX/6OaRZMEpX0z4VCOwq5Y9L+uvlFsE5s9VBCjDowehQiJpMUp
0pH1iROrwhmJS44I/n8j9Yf8f2W7BpNVQmy5q3aDTzoYwN82zTzEWchcAb7YU6D0
+3pIt0SJ2eFavM4UMz3YqLaxmELTT/vGhVaLnMpoXWQG82NSomxPgHpJgesfsCyN
z1Ic4DLPceinvw9TlKiUwmDhC1LRf365JAxYlLI9xQGf23SHIS1XRKXJxu5inooT
72TohJNgS04LUOJ4YahQ0S0DnrybjetVFM4mkCilPpsI7am+CSrGL56DjR3HKwH0
EIj8FNvmnLztPB5m5ofern6QTEojn1EplPIIjp7sEDQcnSC1XSfIPML/31VK6GJI
FaW3jir3zzPGy7cE1vnU
=DVTG
-----END PGP SIGNATURE-----

--WU3I8Do+sziGY3UL--
