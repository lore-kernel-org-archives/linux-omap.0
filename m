From: Sebastian Reichel <sre@kernel.org>
Subject: Re: partial bluetooth success on n900 [was Re: bluetooth/uart
 timeout handling]
Date: Wed, 14 Dec 2016 16:52:09 +0100
Message-ID: <20161214155208.ocs4vw77expduefr@earth>
References: <20161016002454.ul5rdqwubvkct4pf@earth>
 <20161018224259.jrwbaal27irzjqyo@earth>
 <20161019092506.GA1461@amd>
 <201612141321.30181@pali>
 <20161214125323.GA4951@amd>
 <20161214133158.mwvs574l4otbc7hf@earth>
 <20161214151056.GX4920@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wwwmwy7mq5jtwy32"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161214151056.GX4920@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Pavel Machek <pavel@ucw.cz>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com
List-Id: linux-omap@vger.kernel.org


--wwwmwy7mq5jtwy32
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Tony,

On Wed, Dec 14, 2016 at 07:10:56AM -0800, Tony Lindgren wrote:
> * Sebastian Reichel <sre@kernel.org> [161214 05:32]:
> > Hi Pali & Pavel,
> >=20
> > On Wed, Dec 14, 2016 at 01:53:23PM +0100, Pavel Machek wrote:
> > > > > [  220.248596] tty ttyO1: Radio packet sent
> > > > > [  220.249328] Bluetooth: hci0: Frame reassembly failed (-84)
> > > > > [  220.272949] tty ttyO1: wakeup received: 1 -> 0
> > > > > [  221.283477] tty ttyO1: radio packet timeout!
> > > > > [  221.283630] enqueue: hu c304cc80 skb cd4a9b40
> > > > > [  223.363372] Bluetooth: hci0 command 0xfc18 tx timeout
> > > > > pavel@n900:~$
> > > >=20
> > > > In log are still some failures, but ... is bluetooth working now?
> >=20
> > I could scan for devices. The code is still racy, though. It's
> > most likely related to the newly introduced idle code. (Without
> > sending the BT module to correctly idle the bcm2048 does not
> > work correctly at all)
> >=20
> > I was quite busy the last few weeks and did not manage to find
> > much time for kernel work. Now I will first have to catch up
> > with my power-supply tree.
> >=20
> > > It is... for Sebastian. I'm playing with camera now.
> > >=20
> > > > I see that you applied this patch:=20
> > > > https://git.kernel.org/cgit/linux/kernel/git/pavel/linux-n900.git/c=
ommit/?id=3D051aa3fbf03ac770d8344690f5a936a7f04c6884
> > > >=20
> > > > Looks like that pinmux is in DTS file incorrect. Can somebody verif=
y it?=20
> > > > Maybe Tony?
> > >=20
> > > Yes, it is. Sebastian was pretty certain about that.
> >=20
> > Yes, I'm certain. The bootloader enables the pullup resistors.
> > Note, that the wrong DTS entry is not in mainline. My bluetooth
> > branch has a fixed DTS patch instead of a fixup patch on top of
> > the broken one:
> >=20
> > https://git.kernel.org/cgit/linux/kernel/git/sre/linux-n900.git/commit/=
?h=3Dnokia-bluetooth-dev&id=3D6b63c111a979d100cfbdd76cb4a6bbadace35216
>=20
> Maybe send it so we can merge it as a fix during the early -rc
> cycle?

Sorry if I was not clear enough: mainline does *not* contain
incorrect DT information. My bluetooth RFC patches did. So
this can go into the kernel once the driver is there and
the binding got accepted.

Alternatively I can prepare a patch, which just adds the
cts/rts pinmux for the bluetooth UART, but it's not very
useful on its own.

-- Sebastian

--wwwmwy7mq5jtwy32
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlhRaqYACgkQ2O7X88g7
+pqhCQ//eXFku1giVb+5GrdJsMCugBEPstARmXWCebzR1QOmNtRF3PAypREDw1iK
kTsjDDR/s/FjSRfbpVoEB/xmSP/nPxEIdfBJwNtMNm/Zc3ngoPtL6Ckf7wCQiMwo
tWuv81AYRs509083qDze8jtVOqZIe0iqe2ZDty5BxfoFft+pO+UwZ7jxCNtOkdYf
3kOyXUNWKpRrNznqzJh0NZguR1/ZJBYxs2rw9LkdZhuo+JdIbUTPed7rIsp8ysfi
EnIUNAF2lls4DUB5yYX+DGRx6MtM0vdwrNsHpgHpMjE9kJ/vByIJpquSksUMLzSk
e+4igqq+lAXG2TGMMbpHOxw4jFUAsX5CdyzcR/+QBPxV7EsUK1IXejUUvRo14PXH
Ns9GReK7emxJpWYI2HzpHr3f3VhKepKjN8SO79FeJLtqcZgPCEM468wLuLZ4NpGL
FHRPVhVXUG3PLT6kFUuoyupGIn3s5RVkkq/zAlNu+1JxA8jfZg+dvSmdAwJDo2AT
t4c2jRAXFadtI/Co3hxep5D/mZ8SnokKzLFSu2uGI9wX+jGO0c8Bl1wSAoXQvNzy
Rh/jAAZKlILT0WFCznwM2R0N+nzLR+F0WoE3PK78WvyxXj+U88XCYuV9K6hzAUvw
qhNFhdYrsJWHAaVtXlB35TZ1KyqQ8D75nKoZO5CamN1G2bysCSo=
=ojJl
-----END PGP SIGNATURE-----

--wwwmwy7mq5jtwy32--
