From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 00/26] OMAPDSS: DT support (Christmas edition)
Date: Sat, 14 Dec 2013 09:34:48 +0200
Message-ID: <52AC0A18.30405@ti.com>
References: <1386160133-24026-1-git-send-email-tomi.valkeinen@ti.com> <1703598.NbqXAMAFOI@avalon> <52AADBE0.3030203@ti.com> <3426377.keoaFgiZkl@avalon> <52AB2C25.6000507@ti.com> <20131213172234.GD28184@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="HN2gNgUlOmJhB3MA1MBp3c8GkloW3oX5R"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38768 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751795Ab3LNHfL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 14 Dec 2013 02:35:11 -0500
In-Reply-To: <20131213172234.GD28184@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>, Stefan Roese <stefan.roese@gmail.com>, Sebastian Reichel <sre@debian.org>, Robert Nelson <robertcnelson@gmail.com>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Marek Belisko <marek@goldelico.com>

--HN2gNgUlOmJhB3MA1MBp3c8GkloW3oX5R
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-12-13 19:22, Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [131213 07:49]:
>> Hi Laurent, Tony,
>>
>> On 2013-12-13 16:37, Laurent Pinchart wrote:
>>
>>>>> - dsi_enable_pads, dsi_disable_pads: Those don't seem to be used in=

>>>>> mainline. What's their purpose, and how are they implemented on pla=
tforms
>>>>> that make use of them ? Is the pinmux API an option ?
>>>>
>>>> They are used in mainline, grep again =3D).
>>>
>>> The only implementations I can find in arch/arm/mach-omap2/display.c =
are
>>>
>>> static int omap_dsi_enable_pads(int dsi_id, unsigned lane_mask)
>>> {
>>>         return 0;
>>> }
>>>
>>> static void omap_dsi_disable_pads(int dsi_id, unsigned lane_mask)
>>> {
>>> }
>>
>> Yep. It seems Tony removed the muxing for -rc2 in
>> e30b06f4d5f000c31a7747a7e7ada78a5fd419a1 ARM: OMAP2+: Remove legacy mu=
x
>> code for display.c
>>
>> Tony, that patch removes DSI muxing, which is not done via DT. I can't=

>> test right now, but I presume DSI displays don't work at all after -rc=
2.
>=20
> Hmm I suggest you test against commit adfe9361b236 (ARM: dts: Add basic=

> devices on am3517-evm) as it does not yet remove the legacy data and
> that's what's heading to linux next soonish.

That commit is not in the mainline. I'm talking about mainline.
v3.13-rc3 contains e30b06f4d5f000c31a7747a7e7ada78a5fd419a1, and that
breaks DSI displays (just tested). It needs to be reverted (although the
HDMI parts can probably be removed).

Why was e30b06f4d5f000c31a7747a7e7ada78a5fd419a1 merged into -rc2? It's
not a fix, just a cleanup.

> With the DT configured displays that muxing needs to be done in the
> DSS driver(s) using pinctrl-single.

We don't have any DT configured displays in the mainline.

pinctrl-single doesn't support the kind of register that contains the
DSI muxing. I don't know yet how that should be done. In any case, the
muxing via DT should've been added at the same time as removing the
muxing via platform callback in e30b06f4d5f000c31a77.

> BTW, I suspect quite a few of the DSI using boards have been broken a
> while before 0b2aa8bed3e1 (gpio: twl4030: Fix regression for twl gpio
> output) as at least the following have been using TWL GPIO to enable
> the panel:
>=20
> board-3430sdp.c
> board-devkit8000.c
> board-ldp.c
> board-omap3stalker.c
>=20
> This was the case at least for LDP.

Only 4430sdp has a DSI display in the mainline. Those boards have DPI
displays.

 Tomi



--HN2gNgUlOmJhB3MA1MBp3c8GkloW3oX5R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSrAobAAoJEPo9qoy8lh71Pd0P/iMEaSCUKV5It0WEEayWYLcn
RXXBSukZWYixnmcsmrLZbhJcoQTqdm7lOOGoxodhIAhVnI37OfQgsbcAqjfQ0vwK
XtMgbj3a6EljlJMbNVQ1qc7gr7qzN0Qp+zRVbswikrovUly9rcgyP2gKWZVdhffJ
cFX3XbTnqEvBwCBmLZW9dB5LJJs801B5VSgr8+T/UH9Dipl1hXT7zGfibBvhwtrr
BAteVnSy5T6eqqj1Dn0mv8g3UXBuyWGrhlsVV7xCX0C4hjZIcOALou8gNw/+DORM
PvjOI0CbyOkFxRC9bLn3Uhfb4H6j7HyQRna7RbDHdMx6AbNV8McmyVYCXMrqm+zt
vMyEFxxY5LBy3UoS7LvfeVS3I89fNgDp72x6tikdQjpIaNrgdFESG+ZcpNFRH02y
WcR7qJY4uY6aEqthapur9eWz8TCQlIEoBTp06YruixIJ1wvUf2lbmU3+5+27GRDv
Ew1vuL2YgxFhMQkU964jm0GnxI0sm59S77tYjoafYAVrVGNJnUpuJ57JKB63zzLa
3Al7D5L1sZ+9z/RVRsF53oAI9hdjqQGaHU0pHc+A78QQdvBGELQaiWJ6xmRblOOX
cfgrhff0A58ILRD+YgIDKStZOKCiokHvmGNTStvSg2d1yCU8KDn9PQeUT6nmnWoe
hm00+j8XmY/uuLVCPYN8
=1ewl
-----END PGP SIGNATURE-----

--HN2gNgUlOmJhB3MA1MBp3c8GkloW3oX5R--
