From: Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>
Subject: Re: power management problems in ehci-omap
Date: Tue, 6 Feb 2018 07:42:01 +0100
Message-ID: <20180206074201.479405e7@aktux>
References: <20180204000335.29812776@kemnade.info>
        <CAOf5uw=6RCJBPZd1fCi6+xb23THLRmXcfqsNtiZQeM=oKx0VvQ@mail.gmail.com>
        <20180204093831.44322452@kemnade.info>
        <CAOf5uwnoQtS+PnPO0t7Mf1qP9u_BgLPAX0h4EhiXfY7380QXng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/4wifI7Dt.qzmlWh8EmFXEBD"; protocol="application/pgp-signature"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAOf5uwnoQtS+PnPO0t7Mf1qP9u_BgLPAX0h4EhiXfY7380QXng-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Nazzareno Trimarchi <michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>
Cc: USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Discussions about the Letux Kernel <letux-kernel-S0jZdbWzriLCfDggNXIi3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--Sig_/4wifI7Dt.qzmlWh8EmFXEBD
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sun, 4 Feb 2018 09:43:45 +0100
Michael Nazzareno Trimarchi <michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org> wrote:

> Hi Andreas
>=20
> On Sun, Feb 4, 2018 at 9:38 AM, Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org> wr=
ote:
> > On Sun, 4 Feb 2018 00:10:50 +0100
> > Michael Nazzareno Trimarchi <michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org> wrote:
> > =20
> >> Hi
> >>
> >> On Sun, Feb 4, 2018 at 12:03 AM, Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org=
> wrote: =20
> >> > Hi,
> >> >
> >> > I booted a 4.15 kernel without udev and loaded modules piece by piec=
e to analyze
> >> > pm problems. modprobe ehci-omap increases current by around 35mA and
> >> > also rmmod ehci-omap does not let it go down at all.
> >> >
> >> > I expect that removing hardware does the same thing =20
> > nonsense sentence from me, was to tired. I would expect that removing t=
he modules
> > properly powers down the device. =20
> >> >
> >> > Also suspend current increases by around 15mA if that module is load=
ed.
> >> > I tested with having everything disabled which is attached to that u=
sb bus.
> >> > =20
> >>
> >> Do you have an LTE connected to the usb?
> >> =20
> > Yes, there is a UMTS modem attached, but it was off during the tests.
> > It did not enumerate on the modem.
> > =20
>=20
> Just to understand if the suspend current drop was connected to the
> suspend of lte modem on your side.
> So you don't have anything connected on usb bus?
>
rechecked with a board with really nothing connected there
Same behaviour

Regards,
Andreas

--Sig_/4wifI7Dt.qzmlWh8EmFXEBD
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE7sDbhY5mwNpwYgrAfb1qx03ikyQFAlp5TjkACgkQfb1qx03i
kyS6yw/9FAtrtPRrcP4m7bEEjOYdDASEiuF9lKttUdgJ4ptd6Wte1WJE0lgFRWdG
19wll/LB91N3Pd3lBlI1cBv+mt8KANAJcqoOLdKymRKGNmbxPXxfDswfMF7Ba5WT
lDDngTEyHiNWV33ayR21UADA5m572DtcwBFrKfpVqCg4bASZ46Z/VB1zNBpROXyZ
sbZOmS0Nh1rUIETelFv1mp/DKqltpRxrHZQdV3LP+46PpQS6QBHUPYG47cJphsS0
DcxeJvwuG2DG6pfdIXLR5ShPorrqNAAoIfo/mPxiZUUraKu+I469VbRKo+3UhEKA
aq1p7k+v8nPzv/r7JOMX9mImUZyi60k/CUdHgNjhGTneCvwvqaIl+2TtQi69507I
deS29IuartQLpIp3idLgTEYujvTgmfvQOyL+ix8szVux5Q1IZTE6bIgL5SC1824Q
PJei4tFxAueLDloVo/9vW541BLSwo2YG8+c6PB6ua3MQuk55+LCDaduTCdO/Sc8c
JzZjJ+7fPjzBguIo5Zd5H+JowkGKGJ+Jm1jspqTiQDVyMnbQHmG8vLwOk0doDCwK
AExsCqNCsiO8BDO36tD8Z8mYuDwAX4VabaXIYbIZ8Z/Va1FDAAyQpByMC5W2Bt8a
t6DomEbpMwUeb2JAPdCG/bttgQPZeqwU0KQXyxKVkWAfW1HArew=
=qkdW
-----END PGP SIGNATURE-----

--Sig_/4wifI7Dt.qzmlWh8EmFXEBD--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
