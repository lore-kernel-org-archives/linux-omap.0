From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 0/8] OMAPDSS: Misc improvements
Date: Fri, 07 Sep 2012 19:59:00 +0300
Message-ID: <1347037140.2646.60.camel@deskari>
References: <1345729514-2441-1-git-send-email-tomi.valkeinen@ti.com>
	 <1346743368.2586.1.camel@deskari> <20120906201330.GF1303@atomide.com>
	 <1347012960.2646.5.camel@deskari> <20120907162258.GT1303@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-u/KRcP6vnzuwphJUaaDA"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog128.obsmtp.com ([74.125.149.141]:39364 "EHLO
	na3sys009aog128.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752901Ab2IGQ7H (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Sep 2012 12:59:07 -0400
Received: by lbbgj3 with SMTP id gj3so2012101lbb.19
        for <linux-omap@vger.kernel.org>; Fri, 07 Sep 2012 09:59:03 -0700 (PDT)
In-Reply-To: <20120907162258.GT1303@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, archit@ti.com


--=-u/KRcP6vnzuwphJUaaDA
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2012-09-07 at 09:22 -0700, Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [120907 03:16]:
> > On Thu, 2012-09-06 at 13:13 -0700, Tony Lindgren wrote:
> > > * Tomi Valkeinen <tomi.valkeinen@ti.com> [120904 00:23]:
> > > > Hi Tony,
> > > >=20
> > > > Can you check the arch/arm patches below, and suggest how you'd lik=
e to
> > > > go forward with them?
> > >=20
> > > Acked them, then as soon as we have the initial immutable header
> > > move branch available, you should merge with that to avoid
> > > merge conflicts in upstream.
> >=20
> > Thanks, but you missed the first patch "[PATCH 1/8] OMAPDSS: HDMI: Move
> > GPIO handling to HDMI driver".
>=20
> Oops sorry, that's a nice one, acked that too. BTW, do you have any
> platform code callbacks remaining for DSS?

Yes, for quite many boards:

$ git grep platform_enable arch/arm/mach-omap2/|wc -l
17

Some of those are trivial, I just need to move the panel's reset gpio
handling to the panel driver. But some fiddle around with board specific
gpios that do not belong to the panel driver. Also some board files
contain backlight handling.

Those are for panel drivers, then there's also callbacks for the omapdss
driver itself. get_context_loss_count, set_min_bus_tput, and dsi pin
enable/disable.

 Tomi


--=-u/KRcP6vnzuwphJUaaDA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQSifUAAoJEPo9qoy8lh71KYcQAI2Qexe4KZBCMDISgBbUaQs9
IdQulM12jhdPf+qp6e/shrIidgpgKcXEhS0jMk1kcUiNm0PoK0geBk2Uwu+RI8rJ
RA/AiZfxi2mJ+xj4Zwyi11SwwXrKnf8s0/rjlAYKIQo9NdH9GKeGThWWw2RWz56j
JWUs2NRXepjb2TxyrtwQFma4tMcovwjbtkVBw96B1Ok53irHsg+hlyrCeJsCsPSr
pQqaLU5R4qSFRPfI/tf+qWmX0LcplSAnCDiZVtMps7Jo9S32Yg2VeHTVOhTESjm4
8eh1pNNtvvVh0bgqKiDQckv0yZDLEw1yibOpbdfJiQek6Sq3ZEvA7wqdoefzN5L9
ZqYKoPHYNoBCd+q0lrssuLHKr/J6xvb7vsmBO3v8ovDtBWMSr9MMnmgqbTaFo3QH
WuHRDbLTpaCEH+/ebKVBsV5cMZwkTPrLephkGQnPIMQyn1H6mWbkvBSs6AUui+K+
ETnMBUWwPmBf7U7ObhJCsN/4nbpQBze45dwmLM4Lg53sDX1HHf6P4SkX1Nfrd9ya
Sgeg45B6HXqBKvexeAlAuweQ3Gh6+Sv6pRB5veUN6qxyCLne6YupfTYjiKtCqlE5
xwHAr8uVYw7DnibYJQhL+5JapVqalQN0QidMdhnoDEUEmvURVN2o10hmUzoprcWX
GqqTgrMgnFJQZfOtIJz6
=BzcY
-----END PGP SIGNATURE-----

--=-u/KRcP6vnzuwphJUaaDA--

