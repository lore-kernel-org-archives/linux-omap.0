From: Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>
Subject: Re: power management problems in ehci-omap
Date: Tue, 6 Feb 2018 19:40:20 +0100
Message-ID: <20180206194020.349468da@aktux>
References: <20180204000335.29812776@kemnade.info>
        <CAOf5uw=6RCJBPZd1fCi6+xb23THLRmXcfqsNtiZQeM=oKx0VvQ@mail.gmail.com>
        <20180204093831.44322452@kemnade.info>
        <CAOf5uwnoQtS+PnPO0t7Mf1qP9u_BgLPAX0h4EhiXfY7380QXng@mail.gmail.com>
        <20180206074201.479405e7@aktux>
        <20180206160452.GA21573@atomide.com>
        <20180206175509.4d80e930@aktux>
        <20180206171737.GB21573@atomide.com>
        <20180206185452.34d01d77@aktux>
        <20180206181623.GC21573@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/NlgT=Om1wCuoDpuw0H2eBki"; protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180206181623.GC21573-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Michael Nazzareno Trimarchi <michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Discussions about the Letux Kernel <letux-kernel-S0jZdbWzriLCfDggNXIi3w@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--Sig_/NlgT=Om1wCuoDpuw0H2eBki
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 6 Feb 2018 10:16:23 -0800
Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:

> * Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org> [180206 18:04]:
> > On Tue, 6 Feb 2018 09:17:37 -0800
> > Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote: =20
> > > uarts=3D$(find /sys/class/tty/tty[SO]*/power/ -type d 2>/dev/null)
> > > for uart in $uarts; do
> > > 	echo enabled > $uart/wakeup 2>&1
> > > 	echo auto > $uart/control 2>&1
> > > done
> > >  =20
> >=20
> > hmm, this looks a bit like runtime suspend. =20
>=20
> Not only that, it enables wakeup for UART also for suspend :)
>=20
We are using the rtc for wakeup and measure discharge of battery
for a time frame of about 300 seconds.

> That is if your dts has it configured with interrupts-extended
> for the console UART like omap3-beagle-xm.dts has for example.
> Seems like the gta04 dts don't have these.. And you also want
> to have chosen with stdout-path =3D &uart3 or whatever the debug
> UART is for earlycon to work.
>=20
> > I mean suspend aka echo mem >/sys/power/state
> >  =20
> > > echo -n 1 > /sys/kernel/debug/pm_debug/enable_off_mode =20
>=20
> And the above will enable SoC and PMIC off modes, which will also
> take the suspend power to some much much lower value :) You need
> to configure the PMIC too depending if the oscillator can be turned
> off, in that case set "ti,twl4030-power-idle-osc-off". That too
> seems to be missing in gta04 dts files..
>=20
It was in our tree. It can be enabled for the gta04a5. We have even done
that. But then suspend while charging breaks. I have no idea how to do a
proper if-not-charging-power-idle-osc-off patch...=20

Yes there are other places where we can optimize suspend current. But
lets first find out why ehci-omap seems to cause trouble here.
So we are looking for around 15mA of additional suspend current when the
module is loaded.=20
Shouldn't the reset line of the phy (usb-nop-xceiv) be set to low when
going to suspend? I do not see code how to do it. I guess that is the
reason.

BTW:
root@letux:~# cat /sys/bus/platform/devices/48064800.ehci/power/runtime_sta=
tus=20
active

Regards,
Andreas

--Sig_/NlgT=Om1wCuoDpuw0H2eBki
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE7sDbhY5mwNpwYgrAfb1qx03ikyQFAlp59pQACgkQfb1qx03i
kySKYRAAtKsfXEMi8XNopUQ4/C8SLYP7IStKTboj8rlVDypsGMm0yOcl+Baqzhel
ZlFZeXjQ+qTTvK6RSoXTdwmx3ymOqu6wxJzSOvFppwvfJpTswbIVOa47BcS6g7uK
qKOonuW4k5CJUIz13m8dpAUD6u554NKtmI0gtWaeqiador5+fUgAbDPG7xb4bzPF
FHEP4dG4Fxh7TTsPJFj79fz55Qf2c2hkqBwbCpUCcuEMRoePQfVtpj3h9BeYwGZ3
glG5wFqmJXsP9+44uUPlnZYPuc46MjYba1VD165VQIknLQNc8cG1fGmghSxv8663
3u2lBNn2Jbpoa+qoFF4J7O+p60km58ziHOKksJqvomTwr5kcz9AhTxjBMILyCqrc
tjHjXllIGkeWmSiWX9y8J2rxfb8aQjVT8ItjzpEBUY51JjCHXDT27xP0qxDCzP/L
8oztbok90eKw5U/b3fz1G4XrMU9fU5LzP9hvXf+S98GIWdaYc2qQgsRA57uY8DCm
P95vc2KAVngI/MZYcCB/Vd+pE/lmWyUrEsVZ9KEB9Z110kgE0cyyaU3/UC5CbIpe
jKwfFL8R8A3NyoMdm8NtYHUqHU9bvIhchi+VTbQMMyNdAKaailZYNvUTpSXkXWO4
65uj54+QtgJYbDkrEyMNGkKlmX3lOL7N7MFw2ljnnDnLVqS8io4=
=oMQo
-----END PGP SIGNATURE-----

--Sig_/NlgT=Om1wCuoDpuw0H2eBki--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
