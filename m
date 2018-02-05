From: Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>
Subject: Re: power management problems in ehci-omap
Date: Mon, 5 Feb 2018 09:23:30 +0100
Message-ID: <20180205092330.51fe397a@aktux>
References: <20180204000335.29812776@kemnade.info>
        <CAOf5uw=6RCJBPZd1fCi6+xb23THLRmXcfqsNtiZQeM=oKx0VvQ@mail.gmail.com>
        <20180204093831.44322452@kemnade.info>
        <CAOf5uwnoQtS+PnPO0t7Mf1qP9u_BgLPAX0h4EhiXfY7380QXng@mail.gmail.com>
        <20180204115052.2fe3e1db@kemnade.info>
        <CAOf5uwk_CYNBavy=miFEskAOdr9Hpa9jesJbXWRMLAEKseg8vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/g_jR_Zm.kdB1GuBvlWAa.Ov"; protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAOf5uwk_CYNBavy=miFEskAOdr9Hpa9jesJbXWRMLAEKseg8vg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Nazzareno Trimarchi <michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>
Cc: USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Discussions about the Letux Kernel <letux-kernel-S0jZdbWzriLCfDggNXIi3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--Sig_/g_jR_Zm.kdB1GuBvlWAa.Ov
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sun, 4 Feb 2018 11:55:02 +0100
Michael Nazzareno Trimarchi <michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org> wrote:

> Hi Andreas
>=20
> On Sun, Feb 4, 2018 at 11:50 AM, Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org> w=
rote:
> > Hi,
> >
> > On Sun, 4 Feb 2018 09:43:45 +0100
> > Michael Nazzareno Trimarchi <michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org> wrote:
> > =20
> >> Hi Andreas
> >>
> >> On Sun, Feb 4, 2018 at 9:38 AM, Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>=
 wrote: =20
> >> > On Sun, 4 Feb 2018 00:10:50 +0100
> >> > Michael Nazzareno Trimarchi <michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org> wrote:
> >> > =20
> >> >> Hi
> >> >>
> >> >> On Sun, Feb 4, 2018 at 12:03 AM, Andreas Kemnade <andreas@kemnade.i=
nfo> wrote: =20
> >> >> > Hi,
> >> >> >
> >> >> > I booted a 4.15 kernel without udev and loaded modules piece by p=
iece to analyze
> >> >> > pm problems. modprobe ehci-omap increases current by around 35mA =
and
> >> >> > also rmmod ehci-omap does not let it go down at all.
> >> >> >
> >> >> > I expect that removing hardware does the same thing =20
> >> > nonsense sentence from me, was to tired. I would expect that removin=
g the modules
> >> > properly powers down the device. =20
> >> >> >
> >> >> > Also suspend current increases by around 15mA if that module is l=
oaded.
> >> >> > I tested with having everything disabled which is attached to tha=
t usb bus.
> >> >> > =20
> >> >>
> >> >> Do you have an LTE connected to the usb?
> >> >> =20
> >> > Yes, there is a UMTS modem attached, but it was off during the tests.
> >> > It did not enumerate on the modem.
> >> > =20
> >>
> >> Just to understand if the suspend current drop was connected to the
> >> suspend of lte modem on your side.
> >> So you don't have anything connected on usb bus?
> >> =20
> > Suspend current is increased when the ehci-omap module is loaded
> > in comparison to the state. I tested with the modem disabled, so there
> > is nothing on the bus. Increased suspend current is one thing,
> > current_before_modprobe_ehci_omap !=3D current_after_rmmod_ehci_omap.
> >
> > I am testing with init=3Dsome_testscript.sh, so no userspace
> > is doing strange things. No module autoload or something.
> > =20

Ok, there is some heavy EBCAK involved. I just did an
echo rmmod
without a real rmmod. But the suspend thing is still valid.

Sorry for the confusion.

To avoid further confusion I have uploaded these two scripts
I have given to the kernel.
http://misc.andi.de1.cc/measure4.sh

output from that:
no modules: cur: 61047 delta: 61047
before: 423462
after: 421326
average 25632 uA over 300 seconds
 cur: 60333 delta: -714
+ehci-omap cur: 93712 delta: 33379
-ehci-omap cur: 60511 delta: -33201
before: 420792
after: 418656
average 25632 uA over 300 seconds


http://misc.andi.de1.cc/measure5.sh
output from that:

no modules: cur: 61225 delta: 61225
before: 427734
after: 425598
average 25717 uA over 299 seconds
 cur: 59797 delta: -1428
+ehci-omap cur: 93712 delta: 33915
before: 425242
after: 421860
average 40719 uA over 299 seconds

The 40mA is too high. We have had measurements below 30mA even with
modem enabled with some pre-dt setup (Kernel 3.7)

Regards,
Andreas

--Sig_/g_jR_Zm.kdB1GuBvlWAa.Ov
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE7sDbhY5mwNpwYgrAfb1qx03ikyQFAlp4FIIACgkQfb1qx03i
kySn2Q/+KSda51Pfa4CCDno0AyGjg5MZdeA0vg7JnsCqXJfNv3jt9kTxoYW1CSuG
KngvUrSIU4dnNF0+bYgqP74Hz40wDL3OGEKWhePA4NzQdFoSbFA3yjH4KZ58kc9t
hI3skg5pTWKOgzX27A1hcT4z+8niIgT/VZCcWcaKVs/w0RC4Qs6fqgv5hSqUfNBF
gvJIWcTCY/+M2zyQo8nFT9M4fpuO5sn3sTd1Z+BdBZG8j/g0/5o5dMLnnv1vgEVP
hGr9iMOt3Lmxe6jWQZNLC3XcNO1XWaw+o4Gx9g7fYXzDFH0xfDUiPlskKnKZY+0x
E5HPX4PKp7yjO4joSF1ylze94qTh0/tVPSvPy+jmU8vaHvGuYFJE6Um7dy3YlC2A
LK4woVupbsk8f2lkq212HN7cGDNalpi9xQukpVDujbzMwNZWJNIsHOztjInfhkNk
Q1aQ2lAO2cIwBJTYHNi2wLqUcDlZvRC46Mho1mkAHWUaDmdswxd941vHVASKLHGE
w2PZ3OddVzxlZFGS11PU/89WgIn0DOmiuiEKpR04kSLWNDGtpCyNEjdeP1hvbJ8/
zv2R9TVSLTLdnIZADlc+Ma4dvularPcnTNa8+7GzJu2kO8pzdnZlThIVOzwQNtb4
izJHViMIz9XiVPBC7xZT/Ik/yg2205YJnUK50IkPQWcUVCLqxpw=
=gUye
-----END PGP SIGNATURE-----

--Sig_/g_jR_Zm.kdB1GuBvlWAa.Ov--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
