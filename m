From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC PATCH] clk: ti: set CLK_SET_RATE_NO_REPARENT for
 ti,mux-clock
Date: Tue, 17 Jun 2014 08:23:13 -0500
Message-ID: <20140617132313.GC9070@saruman.home>
References: <1402992272-21413-1-git-send-email-tomi.valkeinen@ti.com>
 <1402992272-21413-2-git-send-email-tomi.valkeinen@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C1iGAkRnbeBonpVg"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43559 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755372AbaFQNXi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Jun 2014 09:23:38 -0400
Content-Disposition: inline
In-Reply-To: <1402992272-21413-2-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, Paul Walmsley <paul@pwsan.com>, Mike Turquette <mturquette@linaro.org>, linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>, Felipe Balbi <balbi@ti.com>

--C1iGAkRnbeBonpVg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2014 at 11:04:32AM +0300, Tomi Valkeinen wrote:
> When setting the rate of a clock, by default the clock framework will
> change the parent of the clock to the most suitable one in
> __clk_mux_determine_rate() (most suitable by looking at the clock rate).
>=20
> This is a rather dangerous default, and causes problems on AM43x when
> using display and ethernet. There are multiple ways to select the clock
> muxes on AM43x, and some of those clock paths have the same source
> clocks for display and ethernet. When changing the clock rate for the
> display subsystem, the clock framework decides to change the display mux
> from the dedicated display PLL to a shared PLL which is used by the
> ethernet, and then changes the rate of the shared PLL, breaking the
> ethernet.
>=20
> As I don't think there ever is a case where we want the clock framework
> to automatically change the parent clock of a clock mux, this patch sets
> the CLK_SET_RATE_NO_REPARENT for all ti,mux-clocks.
>=20
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

am437x-sk presents no problem with this patch:

Tested-by: Felipe Balbi <balbi@ti.com>

--=20
balbi

--C1iGAkRnbeBonpVg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJToEFBAAoJEIaOsuA1yqRES0IQAKL3m45W9aAzJqBA4b0poImL
TzOykM8M5U3cVoJnqnjlphAzHHHAMELd/Uz08FREB8Ta8sYny4Ski5okqrzqMKN6
kAa4PFXqqRMnEK8GVo40YH2Q1bYH5lRtkLQwc0RhhaXExMC9urU1VfsSjZsQSsa+
DIpNlmA7OG1MVzfZR9otTpOZ1aqBKm3EObo7ED7e3DZ2qpFriVizP/y7MXxhpjaU
9telKA5nE6V+5oUgmRy7QD2yqLYDnmBw598GqDdeg14+ROvW6bM3HhENYLJQgFUp
MX6bm25PgGh5vDIvfxF4p0EsPXTicO7baRtPNA9zzMOCPTMd1BWP8gLdN0sdJ9R2
uqaijG7zn0iiHJ+JaWaIsqvY71CiF0Ly6+ZR2JiL8KhET6avNxO4WhR8I0gpVAP9
dOlyhNYMNt+VtVDavxlpdgzdFby3QRGjNl6eMtEaE9bO7U4OFKm87UYDIshuXaJ5
S4APziyS+GemXK9f+RlPZoBgxpDTIOWXeX9R7bbt0SeTnW2nhaALpqnAcfb/OaUr
CrKr2JX5MXafHSKSQFzFTbk4fss/u1ygHe4A9RgMD8tlYo1msQcI0NDtnWB/GCDl
/dY6phsm/a0Jiv98VBKVmPWOLPSjiqbVwboIO6Tln20hZLAuHbb4lWQEl4Xqs7Hc
w1jU06B6+ddnFZQIvUU/
=EetK
-----END PGP SIGNATURE-----

--C1iGAkRnbeBonpVg--
