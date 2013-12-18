From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: OMAP display subsystem - does it work?
Date: Wed, 18 Dec 2013 15:54:42 +0200
Message-ID: <52B1A922.6020901@ti.com>
References: <20131218120023.GG4360@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="USqh7vjKhMD4nVDtnkH6BCpNXuQEbJP2P"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49287 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753842Ab3LRNzQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Dec 2013 08:55:16 -0500
In-Reply-To: <20131218120023.GG4360@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

--USqh7vjKhMD4nVDtnkH6BCpNXuQEbJP2P
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-12-18 14:00, Russell King - ARM Linux wrote:

> So, here goes.  LDP3430:
>=20
> OMAP DSS rev 2.0
> omapdss DPI error: can't get VDDS_DSI regulator
> omapfb omapfb: failed to connect default display
> omapfb omapfb: failed to init overlay connections
> omapfb omapfb: failed to setup omapfb
> platform omapfb: Driver omapfb requests probe deferral
>=20
> I don't see evidence of it being re-probed, but I do see this during bo=
ot
> which implies that there's nothing there:
>=20
> XIO:  fatal IO error 104 (Connection reset by peer) on X server ":0.0"
>       after 0 requests (0 known processed) with 0 events remaining.

I don't have an LDP board at hand, and I wasn't able to find out anything=
 from
the logs.

I think I should change omapfb to print something if it's probed succesfu=
lly,
as the deferred probing makes finding out if something is probed fine or =
not
quite murky. Without deferred probing, it was simpler: no errors -> the d=
river
must be (most likely) ok.

Although... In an earlier log, where there was no panel driver, the log h=
as
these errors:

Error opening /dev/fb0: No such device

There are none in the latest log, which makes me guess the omapfb has bee=
n
probed, and fb0 is actually there. But the X is still dying for some reas=
on...

I'll look at this more. Maybe someone in our team can find a board to tes=
t.
=20
> For the SDP4430, it used to detect the displays, even though nothing ha=
s
> ever been displayed on them.  Now it just spits out this:

Those particular LCDs are supposed to be updated manually using custom io=
ctl,
so normal software using fb won't put anything on the display. For testin=
g
purposes, a SW based automatic update (~20 fps) can be enabled by kernel
cmdline parameter "omapfb.auto_update" or via sysfs:

echo 1 > /sys/class/graphics/fb0/update_mode

> OMAP DSS rev 4.0
> omapdss DSI error: can't get VDDS_DSI regulator
> panel-dsi-cm panel-dsi-cm.0: Failed to connect to video source
> omapfb omapfb: failed to connect default display
> omapfb omapfb: failed to init overlay connections
> omapfb omapfb: failed to setup omapfb
> platform omapfb: Driver omapfb requests probe deferral
> ...
> omapdss DSI error: failed to set complexio power state to 1
> panel-dsi-cm panel-dsi-cm.0: failed to enable DSI
> omapfb omapfb: Failed to enable display 'lcd'
> omapfb omapfb: failed to initialize default display
> omapfb omapfb: failed to setup omapfb

Commit e30b06f4d5f000c31a7747a7e7ada78a5fd419a1 (ARM: OMAP2+: Remove lega=
cy mux
code for display.c) was overly enthusiastic in removing legacy code which=
 was
already in use. Tony has a partial revert for that queued up. It can also=
 be
reverted fully for testing. After that, the panel wakes up.

 Tomi



--USqh7vjKhMD4nVDtnkH6BCpNXuQEbJP2P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSsakiAAoJEPo9qoy8lh71mZwP/3ybyN6VF0AQUB0BKaIDmojX
oq48uOZ2N/F4gnnEbdh3Fn0MNg77eyBGNeJwsDAWEkZwM5g88U3YqhdJdlJ55eYK
Ky46+L2NAFOzzH7gSzmqB2qWD+XY7RU3vDReuvakpLFIUQMlcdRYoHNrjEhJdfnK
zQX7N2xBeVizc6UgUD7liRRFFYiH0/Nsd7Dxoxyw7eDXYSU//YnbDKZKicdC0n1y
RjyGvZmi0lk8zmoFpg88LokmIVCYjytEgoSnopmOifV0i42D+4k4emzMNbwSSEpr
tPdHixyqfZAMSx7teYTe0ppLSppm+6DMf2Xwyga2/7tRBnw5wqGSrGtqeECHGlN4
rLGzkbc95qTARUh9eY+Ax13E6RfULag3YYeFjD4ErAXfDsfwOJYmxcFvnPt/eI43
3/qZh3cjNmg7QfoK4m5wOUndcskbCAPEQvPO7aFI/RnLx6U88WRz4bOmHAaodG9C
USzW53d/Iil/J1UaSlul+6AUKXC2l5pKbNvyozLBk+bPrqfgzirzDfemApi1mP/h
UPoMAgHYmHDU5oMJCvJsGkVhkDoYUHjzFEVAyjPM2szPmGEszqbPdtCA/3KHwwbN
jXvDYvpXQAAH34HvbALG72lWxKYdMbmHDnYz6b7Clk1DrkfoBd6CTQGww6OVtSGf
F5Ve2n3jwbSDa31/AM3y
=AOSb
-----END PGP SIGNATURE-----

--USqh7vjKhMD4nVDtnkH6BCpNXuQEbJP2P--
