From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Droid 4: suspend to RAM?
Date: Fri, 10 Aug 2018 13:03:50 +0200
Message-ID: <20180810110350.GA13431@amd>
References: <20180725200205.GA29594@amd>
 <CAOf5uwkyPoDT8TZe9V24p+nQMiee9XfD=943xwx0ThGi9_cPng@mail.gmail.com>
 <20180725212853.GA1965@amd>
 <20180727113214.GA32069@amd>
 <20180808090512.GQ99251@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180808090512.GQ99251@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>, nekit1000@gmail.com, mpartap@gmx.net, Merlijn Wajer <merlijn@wizzup.org>
List-Id: linux-omap@vger.kernel.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> * Pavel Machek <pavel@ucw.cz> [180727 11:35]:
> > Hi!
> > > > > high even before modem (and thus USB) is enabled.
> > > > >
> > > > > Interestingly, CyanogenMod and Jolla seem to have higher power
> > > > > consumption than stock operating system.
> > > > >
> > > > > (My Linux can survive for 10 hours, stock system could survive fo=
r 4
> > > > > days if I'm not mistaken).
> > > > >
> > > > > I thought I would experiment with suspend to RAM.. and it indeed
> > > > > seemed to suspend ok, but I could not wake it up. Do I need to se=
t up
> > > > > wakeup with button somehow? Is suspend to RAM required for good p=
ower
> > > > > consumption?
> > > >=20
> > > > Sorry but pm subsystem has debug mode that you can test in a easy w=
ay.
> > > > You can even wakeup by any rtc alarm easily.
> > >=20
> > > Yes, that is how it works on PC (but there power button works,
> > > too). Is it expected to work on Droid in v4.18?
> >=20
> > I tried setting up wakeup using RTC, but no, it does not seem to work:
> >=20
> > root@devuan:/my/tui/d4# rtcwake -m no -s 5
> > rtcwake: wakeup using /dev/rtc0 at Fri Jul 27 11:28:44 2018
> > root@devuan:/my/tui/d4# echo mem > /sys/power/state
>=20
> Works for me here as tested on next-20180808, maybe you don't have
> CONFIG_RTC_DRV_CPCAP? Maybe you are trying to use CONFIG_RTC_DRV_OMAP?

Mainline seems to fail suspend, with CONFIG_DRM turned off. Aha, and
same behaviour with CONFIG_DRM on. Why is it different today?


[  334.933532] Charging, 4350000 uV, 532000 uA
[  338.093109] PM: suspend entry (deep)
[  338.096710] PM: Syncing filesystems ... done.
[  338.138977] Freezing user space processes ... (elapsed 0.001
seconds) done.
[  338.147338] OOM killer disabled.
[  338.150604] Freezing remaining freezable tasks ... (elapsed 0.001
seconds) done.
[  338.159240] Suspending console(s) (use no_console_suspend to debug)
[  338.168212] phy phy-usb-phy@1.1: phy poweroff failed --> -19
[  338.181518] l4_wkup_cm:clk:0018:0: failed to disable
[  338.183227] PM: noirq suspend of devices failed
[  338.187377] g_ether gadget: reset config
[  338.187408] g_ether gadget: ecm deactivated
[  338.187408] usb0: gether_disconnect
[  338.513092] OOM killer enabled.
[  338.516296] Restarting tasks ... done.
[  338.529266] PM: suspend exit
[  338.698577] g_ether gadget: high-speed config #1: CDC Ethernet
(ECM)
[  338.704986] g_ether gadget: init ecm
[  338.708587] g_ether gadget: notify connect true
[  338.713958] g_ether gadget: activate ecm
[  338.717895] usb0: qlen 10
[  338.720550] g_ether gadget: ecm_open
[  338.724151] usb0: eth_start
[  338.727111] g_ether gadget: packet filter 0c
[  338.731414] g_ether gadget: ecm req21.43 v000c i0000 l0
[  338.993835] cpcap_usb_detect: 27 callbacks suppressed

With USB unplugged, suspend seems to behave as expected, even on
v4.18-rc8, and it seems to work even with X running and modem
online. Good.


> Then for deeper idle modes, you need to also idle UARTs, and unbind or
> unload USB related modules. You should get to something like 160mW
> power consumption with mdm6600 enabled and SoC suspended that way.
>=20
> Then again system running idle is about the same with timers and
> interrupts working so I'd just idle UARTs and unload USB modules :)

Ok, let me play with it some more.

Thanks for help,
								Pavel
							=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlttcRYACgkQMOfwapXb+vIypgCfcgKLQzYK40p4PzVpcv2pMZHL
bcwAn2VhDFGcPpmaF0dXg5zS4nK/fZMr
=hqAp
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--
