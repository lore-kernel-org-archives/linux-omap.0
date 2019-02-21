From: Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [PATCH v2] phy: phy-twl4030-usb: fix denied runtime access
Date: Thu, 21 Feb 2019 20:39:58 +0100
Message-ID: <20190221203958.66d904f6@aktux>
References: <20180922094405.4067-1-andreas@kemnade.info>
        <20190220223132.GV15711@atomide.com>
        <20190221170840.5c970def@kemnade.info>
        <20190221164803.GX15711@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/B8oGZk5LWhpCHH7Ii9zachb"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190221164803.GX15711@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, kishon@ti.com, lee.jones@linaro.org, daniel.thompson@linaro.org, wsa@the-dreams.de, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>
List-Id: linux-omap@vger.kernel.org

--Sig_/B8oGZk5LWhpCHH7Ii9zachb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 21 Feb 2019 08:48:03 -0800
Tony Lindgren <tony@atomide.com> wrote:

> * Andreas Kemnade <andreas@kemnade.info> [190221 16:43]:
> > Hi,
> >=20
> > On Wed, 20 Feb 2019 14:31:32 -0800
> > Tony Lindgren <tony@atomide.com> wrote:
> >  =20
> > > * Andreas Kemnade <andreas@kemnade.info> [180922 09:48]: =20
> > > > When runtime is not enabled, pm_runtime_get_sync() returns -EACCESS,
> > > > the counter will be incremented but the resume callback not called,
> > > > so enumeration and charging will not start properly.
> > > > To avoid that happen, disable irq on suspend and recheck on resume.
> > > >=20
> > > > Practically this happens when the device is woken up from suspend by
> > > > plugging in usb.
> > > >=20
> > > > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > > > ---
> > > > Changes in v2:
> > > > * use pm suspend/resume callback instead of delayed_work
> > > >   as suggested by Dmitry   =20
> > >=20
> > > Hmm it just occurred to me that this issue too might be fixed with co=
mmit
> > > c6e2bd956936 ("i2c: omap: Use noirq system sleep pm ops to idle device
> > > for suspend"). Andreas, care to check? That is if this is still an
> > > issue.
> > >  =20
> > this one made already its way into 4.20. But for the records, I will
> > build the latest 5.0-rc and revert it and will check if the problem
> > still occurs. =20
>=20
> OK thanks.
>=20
first of all, suspend is totally broken in v5.0-rc7.
I booted with init=3D/bin/bash
and just loaded gpio-twl4030 and twl4030-pwrbutton

and did (rtc in compiled in) a
 root@(none):/# rtcwake -s 10 -m mem
rtcwake: wakeup from "mem" using /dev/rtc0 at Sat Jan  1 00:05:24 2000
[   86.434722] PM: suspend entry (deep)
[   86.438842] PM: Syncing filesystems ... done.
[   86.458770] Freezing user space processes ... (elapsed 0.003 seconds) do=
ne.
[   86.470947] OOM killer disabled.
[   86.474365] Freezing remaining freezable tasks ... (elapsed 0.002 second=
s) done.
[   86.485473] printk: Suspending console(s) (use no_console_suspend to deb=
ug)
[   86.555572] Disabling non-boot CPUs ...
[   86.555664] Successfully put all powerdomains to target state
[   86.563720] twl: Read failed (mod 1, reg 0x01 count 1)
[   86.563751] twl4030: I2C error -13 reading PIH ISR
[   86.563812] twl: Read failed (mod 1, reg 0x01 count 1)
[   86.563812] twl4030: I2C error -13 reading PIH ISR
[   86.563873] twl: Read failed (mod 1, reg 0x01 count 1)
[   86.563903] twl4030: I2C error -13 reading PIH ISR

and this goes on forever.
I will try to bisect that.

Regards,
Andreas

--Sig_/B8oGZk5LWhpCHH7Ii9zachb
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE7sDbhY5mwNpwYgrAfb1qx03ikyQFAlxu/o4ACgkQfb1qx03i
kyR1ug//UkCTfM2SkawNg+4dzVcqhdb3DWPTw31wGdGWMwcssBjeidM31orpwCi8
d2HoAfZcSmO9ISUwaR1HeojXCsY3FQJNEyLxfwjQWzKq7R6bFpTDlAgY/Dw5pY0D
XfbEs4LW9vH7RCCA/9qe7anj8DfIBRnzOuyMALvdSB0A6wXyTtOZxHxzAxYfGQUs
WQQhfxQY2HSxVWA81+un05SeDSeAct95uj4nc5hAf8NkKqRUgLseIhjJyXXVJchZ
GNFLvxDY9pOHP3V3zZlvGcyPZBaVyXbXG3iND7SecJXkXP41AVaRTbo+S9r8aCmj
uyxWgEnRm4Hz+N+EhG8F2Ogfyv5n3heY6VcqP5cHjkyQXGJe3s60a19DEt28fEI6
FIluHaJFtLSoTk9nmlbkCfhfiYniAzL9jvHDmb9GT70cLwBNJnKot4U1xapmONkb
Lkkj+A5TcH/cXRiG6nPoPB6hZJW0a0S0WWjwRRcuKCOsHmqns5uU/p5dWbtSJs4w
lFW5zgG3wzC2BcYV0r8m9py/KrMx+XPwsBXv4ZhpDlqA38Wh67ijzf7yLG5WST8w
/ktA4TAm4sk4hy+01yXSRsBeE9FgX8hsFRLz9ilcYDpBpom9EWGBD32KAYvdQeUz
fNiB11pazdRc3VOV7GILfdlZGJRZQFesZ5NSJshC0nUlns3ZOcw=
=hSVH
-----END PGP SIGNATURE-----

--Sig_/B8oGZk5LWhpCHH7Ii9zachb--
