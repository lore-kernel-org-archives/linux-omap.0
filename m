From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] serial: omap: Fix missing pm_runtime_resume handling by
 simplifying code
Date: Thu, 10 Apr 2014 16:47:53 -0500
Message-ID: <20140410214753.GE27668@saruman.home>
References: <20140325184846.GB31906@atomide.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ytoMbUMiTKPMT3hY"
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140325184846.GB31906@atomide.com>
Sender: linux-serial-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Kevin Hilman <khilman@linaro.org>, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

--ytoMbUMiTKPMT3hY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2014 at 11:48:47AM -0700, Tony Lindgren wrote:
> The lack of pm_runtime_resume handling for the device state leads into
> device wake-up interrupts not working after a while for runtime PM.
>=20
> Also, serial-omap is confused about the use of device_may_wakeup.
> The checks for device_may_wakeup should only be done for suspend and
> resume, not for pm_runtime_suspend and pm_runtime_resume. The wake-up
> events for PM runtime should always be enabled.
>=20
> The lack of pm_runtime_resume handling leads into device wake-up
> interrupts not working after a while for runtime PM.
>=20
> Rather than try to patch over the issue of adding complex tests to
> the pm_runtime_resume, let's fix the issues properly:
>=20
> 1. Make serial_omap_enable_wakeup deal with all internal PM state
>    handling so we don't need to test for up->wakeups_enabled elsewhere.
>=20
>    Later on once omap3 boots in device tree only mode we can also
>    remove the up->wakeups_enabled flag and rely on the wake-up
>    interrupt enable/disable state alone.
>=20
> 2. Do the device_may_wakeup checks in suspend and resume only,
>    for runtime PM the wake-up events need to be always enabled.
>=20
> 3. Finally just call serial_omap_enable_wakeup and make sure we
>    call it also in pm_runtime_resume.
>=20
> 4. Note that we also have to use disable_irq_nosync as serial_omap_irq
>    calls pm_runtime_get_sync.
>=20
> Fixes: 2a0b965cfb6e (serial: omap: Add support for optional wake-up)
> Cc: stable@vger.kernel.org # v3.13+
> Signed-off-by: Tony Lindgren <tony@atomide.com>

FWIW:

Acked-by: Felipe Balbi <balbi@ti.com>

--=20
balbi

--ytoMbUMiTKPMT3hY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTRxGJAAoJEIaOsuA1yqREecEP/15jyTAy0k9m/Gb2nEoGFPqt
oqvebBw5mlLJZj2RzuWYrjaiQb6fbg1Zx4adKgZ51npo1EcVxHCz2PPVzMtwqv3b
5KxcCDivHKZmhvB662Nf8IEOBQZua3qTlLlmS88CTakmQig67gWllwEpkv96oG1f
BRlVexql6YmR/DYZk0EX0/nh5FxeBsA6eMn+UhTqxxeOof4ud+xi8kvVPF7cJOQl
tfl+Qy+SoT7TKfbsNiH/dJ8duQJGgPvqaxRUUIbRlVSzxmTxwD/wIz8CdE+Z/bLH
6fcY+mYdS60Q7yzkgSk+qbiPKpHWClRqoRN+nRvC6imSIUt0xGlkNmlgy8xCQHJu
ozwKRTmmBnKje8LSTYNGM/eZOEmyk7E/zhw4+M8pdOvOqrsO/uQuwSPR6bPC5bJS
xXIOV+mrtYRk1BiCEdEbRdPPaUGzy0aDnA2UnTOpQi8i/jfXbJMmY9T9xatB1PMy
WTQmrttFt8qvO73eKJOLb6uTMmXgnS6/eYsn5njdnBEcBjSUPA7hShA9ReMVdBij
lZh95Jn7tJ8hMQQwOCBvI1Hukq/mYy65b4Cp/tgZJ0lr3rEfTKdUVyRqNCvwYwLU
Jg42ke4a/R9jEQe+iAJTDj20BlBzYxL5UIZ3W5+uVKAoErX6Bwjf5zRMxDn84GmM
ryimmypFgaEMB7OY4caL
=6EzG
-----END PGP SIGNATURE-----

--ytoMbUMiTKPMT3hY--
