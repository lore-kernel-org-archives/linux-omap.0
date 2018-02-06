From: Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>
Subject: Re: power management problems in ehci-omap
Date: Tue, 6 Feb 2018 19:03:47 +0100
Message-ID: <20180206185452.34d01d77@aktux>
References: <20180204000335.29812776@kemnade.info>
        <CAOf5uw=6RCJBPZd1fCi6+xb23THLRmXcfqsNtiZQeM=oKx0VvQ@mail.gmail.com>
        <20180204093831.44322452@kemnade.info>
        <CAOf5uwnoQtS+PnPO0t7Mf1qP9u_BgLPAX0h4EhiXfY7380QXng@mail.gmail.com>
        <20180206074201.479405e7@aktux>
        <20180206160452.GA21573@atomide.com>
        <20180206175509.4d80e930@aktux>
        <20180206171737.GB21573@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/LAojc=+8fasEJgmIGcD22W8"; protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180206171737.GB21573-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Michael Nazzareno Trimarchi <michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Discussions about the Letux Kernel <letux-kernel-S0jZdbWzriLCfDggNXIi3w@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--Sig_/LAojc=+8fasEJgmIGcD22W8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 6 Feb 2018 09:17:37 -0800
Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:

> * Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org> [180206 16:56]:
> > On Tue, 6 Feb 2018 08:04:52 -0800
> > Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:
> >  =20
> > > * Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org> [180206 06:42]: =20
> > > > rechecked with a board with really nothing connected there
> > > > Same behaviour   =20
> > >=20
> > > I've just verified that my test board power consumption goes
> > > back to normal after rmmod ehci-omap with v4.15.
> > >  =20
> > yes, for me too, I initially used a test script which does an
> > echo rmmod ehci-omap
> >=20
> > without a real
> > rmmod ehci-omap =20
>=20
> Ah OK :)
>=20
> > It just seems to be consistent with my observations in a fully booted
> > system (where many things can play a role). Sorry for that confusion. =
=20
>=20
> Try with a minimal set of modules first, then modprobe and rmmod one
> at a time until you find the module breaking PM?
>=20
Yes, that is basically what I do with this script:

https://misc.andi.de1.cc/measure4.sh

and

https://misc.andi.de1.cc/measure5.sh

I start from a bare kernel, check currents, load ehci-omap (I have also
debugged many other pm things that way)
check currents again.=20
But since my rough observations with a fully loaded system
seem to match with the=20
echo rmmod behaviour, I did not notice my mistake.

> You probably know this already, but just in case it helps..
>=20
> First idle the UARTs and enable off mode with something like:
>=20
> uarts=3D$(find /sys/class/tty/tty[SO]*/device/power/ -type d)
> for uart in $uarts; do
> 	echo 3000 > $uart/autosuspend_delay_ms 2>&1
> done
>=20
> uarts=3D$(find /sys/class/tty/tty[SO]*/power/ -type d 2>/dev/null)
> for uart in $uarts; do
> 	echo enabled > $uart/wakeup 2>&1
> 	echo auto > $uart/control 2>&1
> done
>=20

hmm, this looks a bit like runtime suspend.

I mean suspend aka echo mem >/sys/power/state

> echo -n 1 > /sys/kernel/debug/pm_debug/enable_off_mode
>=20
In earlier times this just caused trouble and a little lower current,
maybe it is time to check again.

> Then if using omap3, the attached debug hack patch can be used to
> see which devices are not idling:
>=20
Yes, I will try out. It it about detecting whether the soc itself went
into low power mode. But it does not check e.g. whether the phy is put
into low power mode correctly. So ehci-usb in soc might be powered off
and phy is still on.

When I go to suspend, I get this message:
"Successfully put all powerdomains to target state"

@Nikolaus: Can you check IR at the end of the suspend time in
https://misc.andi.de1.cc/measure5.sh
the second suspend compared with the first whether the phy (the USB
2233) stays on.=20

Regards,
Andreas

--Sig_/LAojc=+8fasEJgmIGcD22W8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE7sDbhY5mwNpwYgrAfb1qx03ikyQFAlp57gMACgkQfb1qx03i
kyToBQ//aPZPPLsFSsL5feZs/yqq21zzc1Ytnjb57/tYKRClBU25cZ3+bP9/0qlw
JFnIZYadX18ySaxt39JoYRKwg/YjDishEjhas86GT6J7k2dXsmV4qJpjZeYdLeTs
gsE2SLeO4lBbYDIPM1oldhn0IyVocFWUkn9Lqvf109NMGs19AsIRzI7IY/RxpHJk
FD5YSUPeRean0AqyWnEM1TvsWlXsTMxUw8eqUxcfx1XWGH/4Dii9FzhCeCvXoRyh
MzBtUH4Qfa2EJh8Tc6OM6ntcOtTu0IxAOp48txpOi49xXbxZBITCGyBwuibuC4cM
+hTozqP+GUQyx7RaV3tnkJ6CyDUy1Ok5Sf8DEuVHiOJobwOeae6SBDgx2MgYpISX
oWtZNBf15lVNToou1P1lHYNYd1bnSXBKPt58kyVmDbeiCH7KbkMPbOZsI7AQ4/6r
N2rRJzp+EQji/UmIOMzcP5uwyrjvwmKapdpwhGcofC8thD/tKKisPINxIQPOFO/e
+8py/qe+Wkc56qZHrkf6Pz995eF1nA7SkyrXfI6EN0mP4csxFJXatY76G2xrmFwE
tT1aWAnBAozKa6D/bOJaBww8z46M3WCzyAWvRrlP40K20biLADXjt0cRigZxh5yg
BHK6jj7XpXeLRC7pjZVnR4ktKAEWHzfRB3Zz0UPSXq0qAFmf3vk=
=4wI3
-----END PGP SIGNATURE-----

--Sig_/LAojc=+8fasEJgmIGcD22W8--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
