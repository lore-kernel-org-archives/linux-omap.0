From: Felipe Balbi <balbi@ti.com>
Subject: CONFIG_DEBUG_SHIRQ and PM
Date: Tue, 25 Aug 2015 14:58:30 -0500
Message-ID: <20150825195830.GH27534@saruman.tx.rr.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9jHkwA2TBA/ec6v+"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

--9jHkwA2TBA/ec6v+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ingo,

I'm facing an issue with CONFIG_DEBUG_SHIRQ and pm_runtime when using
devm_request_*irq().

If we using devm_request_*irq(), that irq will be freed after device
drivers' ->remove() gets called. If on ->remove(), we're calling
pm_runtime_put_sync(); pm_runtime_disable(), device's clocks might get
gated and, because we do an extra call to the device's IRQ handler when
CONFIG_DEBUG_SHIRQ=3Dy, we might trigger an abort exception if, inside the
IRQ handler, we try to read a register which is clocked by the device's
clock.

This is, of course, really old code which has been in tree for many,
many years. I guess nobody has been running their tests in the setup
mentioned above (CONFIG_DEBUG_SHIRQ=3Dy, pm_runtime_put_sync() on
->remove(), a register read on IRQ handler, and a shared IRQ handler),
so that's why we never caught this before.

Disabling CONFIG_DEBUG_SHIRQ, of course, makes the problem go away, but
if driver *must* be ready to receive, and handle, an IRQ even during
module removal, I wonder what the IRQ handler should do. We can't, in
most cases, call pm_runtime_put_sync() from IRQ handler.

I'm guessing the only way would be to move pm_runtime calls into the bus
driver (in this case, the platform_bus) and make sure it only gets
called after device managed resources are freed ?

Any hints would be greatly appreciated.

cheers

--=20
balbi

--9jHkwA2TBA/ec6v+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV3MjmAAoJEIaOsuA1yqREtNYP/3dsI7WtNXXQSh2a240ysgMU
MWanrsb3LF7gtfW0mjL5zBfAvzUN2rHpSmfixS2qU2cv61VD9dVyrG0CgYdCxyqc
PuRDwKHCNcrUxdzQIHrQ/Xxeo9pONiJFwQevgqvMFZun+ciu83EDFdXlDEyGpsfS
EdZwBZH33h7P/K/tio/TEKPC5jrK2Elftd43SUitJYdiCL/4x46+Dm/hNK5jJw4n
22pxxE/WqCPEEaZ8tkqmzlW0Q1vaNDR37gb0WZniuZpJsYXwFTx7Il+X2Y2k0LyF
JdmUVK0F7hBbuCf3EPVSyR56F+Hin9B5g16Hhndt1v7b2MUvFJvKoOlNrMOKZct/
64atfNXrztTIw6i85QAYDrZ/BdV5+5LK0DShkiNnBd7ucghCjLh9a4ZursfSX1EK
TXzQF0kubBFkkxOnWXO5+hxeuLvna7reWMVTVGbOgLvBGG9c5CzYGfWU6iXED9E3
xmpeJS970SV+WvV+UAYAgHw2X7kmaL1RO1f6ir7U81Sqfs0DfKPh+iS9KavxzWhX
T4iHa1WiONcc5OZmrzalWGxM6foCQ/MWNR1fafWOvb+GOQeNsOBewuNTpSIslF37
UkDJ9vBRJ0zOHsin/BypYYDpMM6O1gyXe4lm07CTkpr2T65XDfad9ir5E+OnT/WU
9RUSLuBWO0RRXdT8kEgU
=95Ib
-----END PGP SIGNATURE-----

--9jHkwA2TBA/ec6v+--
