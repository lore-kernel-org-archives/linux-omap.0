From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] usb: musb: omap2430: handle charger OTG xceiver event
Date: Fri, 15 Jul 2011 11:14:47 +0300
Message-ID: <20110715081446.GD2611@legolas.emea.dhcp.ti.com>
References: <1310424197-22909-1-git-send-email-dima@android.com>
 <20110712060126.GB2588@legolas.emea.dhcp.ti.com>
 <CAPz4a6C_Y797S5kQVVdUyN-xiuEaz415nEcp-CDOYPwZ4xzNuA@mail.gmail.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MAH+hnPXVZWQ5cD/"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAPz4a6C_Y797S5kQVVdUyN-xiuEaz415nEcp-CDOYPwZ4xzNuA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dima Zavin <dima-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--MAH+hnPXVZWQ5cD/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 12, 2011 at 10:44:19AM -0700, Dima Zavin wrote:
> On Mon, Jul 11, 2011 at 11:01 PM, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> wrote:
> > Hi,
> >
> > On Mon, Jul 11, 2011 at 03:43:17PM -0700, Dima Zavin wrote:
> >> Set a flag on OTG charger event and check it on cable
> >> remove event (i.e. USB_EVENT_NONE). This way we will
> >> not need to power up the PHY when an external charger
> >
> > s/PHY/LINK
>=20
> Actually it's both, I should update the commit message.

the PHY has to be powered up during charger detection. You could power
it down after charger has been started and power it back up on the
rising edge (or high level, don't remember if this is edge of level
triggered) of the VBUS IRQ.

> >> is detected by the transceiver itself.
> >
> > ... your logic is inversed. Link shouldn't be powered up to start with.
> > We should only power up the Link after we know it *will* be needed. The
> > way you're doing this is:
>=20
> The link *isn't* being powered up by my patch. On an already detected

not by your patch, true. My point is that we're powering it up too early
and if you want to change anything regarding Charger Detection you need
to change at the right place.

> charger you should do nothing at all in musb. That's the whole point
> of the patch: add the ability to process the USB_EVENT_CHARGER event
> in musb from the otg_transceiver that has already detected the
> charger. Today, on USB_EVENT_VBUS, you'd resume your link and then

and what I said (or tried to) is that USB_EVENT_VBUS isn't an event to
be handled by the link at all. The link should be pm_runtime_suspend()ed
right after probe() and should be kept that way until PHY sends
USB_EVENT_CHARGER_DETECTION_DONE or something similar.

> call otg_init, which would powerup the phy on omap4, which we do not
> need to do for USB_EVENT_CHARGER.

That is wrong true. Still your patch only adds a flag. It's not
implementing what you're describing here.

> > connect cable -> resume PHY -> resume Link -> if is_charger suspend
> > Link.
>=20
> Not at all. Have even you looked at the patch? With the patch,
>=20
> 1) "connect cable", detected by otg_transceiver.
> 2) otg_transceiver does the detection of ID pin and/or VBUS and/or
> dedicated charger.
> 3) otg_transceiver sends USB_EVENT_xxx

yes, and it will send USB_EVENT_VBUS which is resuming link.

> 4) In musb_otg_notification(), check if the transceiver detected a
> charger (USB_EVENT_CHARGER).
> 4.1) If yes, then do nothing and leave the LINK *and* the PHY in their
> off states.

this is not what your patch is doing. It only enables/disables a flag
which your patch added.

> > Where it should be:
> >
> > connect cable -> resume PHY -> if is_charger goto done.
>=20
> We only have to resume the PHY if the transceiver didn't do the
> charger detection. The TWL6030 doesn't do that, but depending on your

PHY =3D=3D transceiver.

Like I said before, if you want to put any changes regarding charger
detection, do it at the right location. First add some events for
different USB port types (SDP, CDP, DCP), then notify those, then add
handling of those events to MUSB and PHY drivers, then fix up musb to be
runtime suspended right after probe, then you only need to wake musb UP
in case of SDP and CDP. If you're attached to a DCP you don't even need
MUSB to handle that.

Also, while you are doing Charger detection, be sure to disable
SoftConnect bit on MUSB and put PHY in NONDRIVING mode, this will
prevent MUSB from even knowing there's a cable connected.

--=20
balbi

--MAH+hnPXVZWQ5cD/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOH/b2AAoJEAv8Txj19kN1s9EIAKNYFtp8fg7RxnMXu+8W7BIo
OHwKEm15IyaDxbi0h+biMNfPNgnsWP1ugJo1TO/uYfiMYDdPpR+1g3fPA63O9XSX
L3TrV6qE49IJX9hoWY5PMmuVc5wjGWuf9oLJIC7sNb3xXmsG/LbV/TOTl38dqlhD
JnCRxv6kblAI62WweYScVn8FMxdUIF0HKXODXzI2mRVUOGE2O/efiYenTp0BA9Op
EWM/oLE0ianGCWRX/KfjYFS1WybszJMIA/h0rtGDUmBvncsnHf6X0ffKVoGJqKxD
YltyUXeiMnNcSNchh2LC4zh19EK6nRelGsfDMDZxzi3t+1QlsAvHTr8JdXlAmwA=
=NV01
-----END PGP SIGNATURE-----

--MAH+hnPXVZWQ5cD/--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
