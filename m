From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2] usb: host: ehci: allow ehci_* symbols to be unused
Date: Wed, 15 Feb 2012 18:03:43 +0200
Message-ID: <20120215160342.GC32073@legolas.emea.dhcp.ti.com>
References: <Pine.LNX.4.44L0.1202141505400.1544-100000@iolanthe.rowland.org>
 <1329291266-15798-1-git-send-email-balbi@ti.com>
 <CAAL8m4z72at5heepktM1ieQHFKkApzVY9OzO-hte-U=AZfA=nw@mail.gmail.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z4+8/lEcDcG5Ke9S"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAAL8m4z72at5heepktM1ieQHFKkApzVY9OzO-hte-U=AZfA=nw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Govindraj <govindraj.ti-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--z4+8/lEcDcG5Ke9S
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 15, 2012 at 09:27:35PM +0530, Govindraj wrote:
> On Wed, Feb 15, 2012 at 1:04 PM, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> wrote:
> > not all platforms will use all of those ehci_*
> > symbols on their hc_driver structure. Sometimes
> > we might need to provide a modified version of
> > a certain method or not provide it at all, as is
> > the case with OMAPs which don't support port handoff
> > feature.
> >
> > Whenever we compile a kernel for an OMAP board with
> > EHCI enabled, we get compile warnings:
> >
> > drivers/usb/host/ehci-hub.c:1079: warning: 'ehci_relinquish_port' \
> > =A0 =A0 =A0 =A0defined but not used
> > drivers/usb/host/ehci-hub.c:1088: warning: 'ehci_port_handed_over' \
> > =A0 =A0 =A0 =A0defined but not used
> >
> > In order to cleanup those warnings, we're adding
> > __maybe_unused annotation to those functions.
> >
> > Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> > ---
> >
> > Changes from v1:
> > =A0 =A0 =A0 =A0- only add __maybe_used to relinquish_port, port_handed_=
over
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0and port_change
> >
> > =A0drivers/usb/host/ehci-hub.c | =A0 =A08 +++++---
> > =A01 files changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/usb/host/ehci-hub.c b/drivers/usb/host/ehci-hub.c
> > index 77bbb23..01011dd 100644
> > --- a/drivers/usb/host/ehci-hub.c
> > +++ b/drivers/usb/host/ehci-hub.c
> > @@ -107,7 +107,7 @@ static void ehci_handover_companion_ports(struct eh=
ci_hcd *ehci)
> > =A0 =A0 =A0 =A0ehci->owned_ports =3D 0;
> > =A0}
> >
> > -static int ehci_port_change(struct ehci_hcd *ehci)
> > +static int __maybe_unused ehci_port_change(struct ehci_hcd *ehci)
>=20
> should be __maybe_used ? and in rest of the patch

why ? That isn't even defined anywhere. Take a look at
<linux/compiler-gcc.h>

| /*
|  * From the GCC manual:
|  *
|  * Many functions have no effects except the return value and their
|  * return value depends only on the parameters and/or global
|  * variables.  Such a function can be subject to common subexpression
|  * elimination and loop optimization just as an arithmetic operator
|  * would be.
|  * [...]
|  */
| #define __pure				__attribute__((pure))
| #define __aligned(x)			__attribute__((aligned(x)))
| #define __printf(a,b)			__attribute__((format(printf,a,b)))
| #define  noinline			__attribute__((noinline))
| #define __attribute_const__		__attribute__((__const__))
| #define __maybe_unused			__attribute__((unused))
| #define __always_unused			__attribute__((unused))

did you try to search for a definition of __maybe_used ? It doesn't
exist, try:

$ git grep -e __maybe_used include/

on a git kernel tree. Besides, if we had a __maybe_used flag, it
wouldn't survive very long as semantically they would be essentially the
same.

--=20
balbi

--z4+8/lEcDcG5Ke9S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPO9deAAoJEIaOsuA1yqREe5AP/iRW0KugtbdionWgTqDxZQpQ
IcYk0ZRZBLntn+v1Z+DL0xPOC4u8qdHs9nIemY8+vAq0P8vNQy04SsCQMyPGMK2n
aEdRwmZEquSF738DZJ/7PuQJyqKRy0dqpWb5bexqAicYrVTU5GLP4MhZm5jIBjU7
Lc7ualszBeqFN7CY5ejdmGSdvI0uU5USAxlG0eBvoIvf1RuWz+G2VLWcBb/tdF+c
BShjQ+g/aLQScusZN3I54JX5Ehg0f0+OsirtLDmvrr3Ng1u38x/wU0bKI2CMXEMo
oLbyxETTyv2OmktFYTDZ9CSpOCCoQntc2JZcYEtl2dpvQxDWkHR6zdJOxxsCcr54
Us72Tgmdlc514EQMJ4mMYdw+tn/SCqy7StoOb0ammYSCSjkgS7zNIpL6DMLHBcSp
UncMkXVvWrrhzWgCjxZXNws7CDSbFTR/TnrnUsj15s0rJVYWlt3/JTmU4A/ltmWP
u9BOghoeR9r0TEMJW/pYPo+89q2MSWAkxTRlsyic2FWKCi3UaLfTuIkd9C7+ufv9
+EwEIrwSAwjFVc3ul9bQQ66k8Wa7xPO54MVm684c+uvxll9FjRFX9JjcG1S82/fY
ejkNdEOknj1mmEHYNmpIsQMTo2Hgs4Lt6u/DrFR1XQGuFtvFhvOqwn5lszwsi2pD
gETvfESO906yxJHd6LAR
=n0Gb
-----END PGP SIGNATURE-----

--z4+8/lEcDcG5Ke9S--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
