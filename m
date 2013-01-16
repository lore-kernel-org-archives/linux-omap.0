From: NeilBrown <neilb@suse.de>
Subject: Re: Help wanted with USB and OMAP3 off_mode
Date: Wed, 16 Jan 2013 18:26:06 +1100
Message-ID: <20130116182606.5249db0c@notabene.brown>
References: <20130109092915.1c2077b5@notabene.brown>
	<50ED3FA5.9030905@compulab.co.il>
	<20130109211931.0e00db5d@notabene.brown>
	<50ED4549.6080802@amarulasolutions.com>
	<20130109223456.7832c2bd@notabene.brown>
	<50ED5DBE.4000107@amarulasolutions.com>
	<50ED6868.1080900@compulab.co.il>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/Cv4mdiu5__yEAuJkrxGidoY"; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:34475 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751516Ab3APH0U (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Jan 2013 02:26:20 -0500
In-Reply-To: <50ED6868.1080900@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Michael Trimarchi <michael@amarulasolutions.com>, linux-omap@vger.kernel.org

--Sig_/Cv4mdiu5__yEAuJkrxGidoY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 09 Jan 2013 14:54:00 +0200 Igor Grinberg <grinberg@compulab.co.il>
wrote:

> On 01/09/13 14:08, Michael Trimarchi wrote:
> > Hi Neil
> >=20
> > I forget to answer to your questions
> >=20
> > On 01/09/2013 12:34 PM, NeilBrown wrote:
> >> On Wed, 09 Jan 2013 11:24:09 +0100 Michael Trimarchi
> >> <michael@amarulasolutions.com> wrote:
> >>
> >>> Hi Neil
> >>>
> >>> On 01/09/2013 11:19 AM, NeilBrown wrote:
> >>>> On Wed, 09 Jan 2013 12:00:05 +0200 Igor Grinberg <grinberg@compulab.=
co.il>
> >>>> wrote:
> >>>>
> >>>>> -----BEGIN PGP SIGNED MESSAGE-----
> >>>>> Hash: SHA1
> >>>>
> >>>>> Hi Neil,
> >>>>
> >>>>> On 01/09/13 00:29, NeilBrown wrote:
> >>>>>>
> >>>>>> Hi,
> >>>>>>  I'm trying to get off_mode working reliably on my gta04 mobile ph=
one.
> >>>>>>
> >>>>>> My current stumbling block is USB.  The "Option" GSM module is att=
ached via
> >>>>>> USB (there is a separate transceiver chip attached to port 1 which=
 is placed
> >>>>>> in OMAP_EHCI_PORT_MODE_PHY).
> >>>>
> >>>>> Which PHY is this (vendor/model)?
> >>>>
> >>>> Hi Igor,
> >>>>   it is the SMSC USB3322
> >>>>
> >>>> http://www.smsc.com/media/Downloads_Public/Data_Sheets/3320.pdf
> >>>>
> >>>>
> >>>> BTW I subsequently discovered that keeping USBHOST out off off_mode =
only
> >>>> sometimes avoid the problem, not always.  So there are probably mult=
iple
> >>>> issues :-(
>=20
> We have the same PHY and it has some issues with the OMAP USB code.
> First issue we experience is that if we reset the PHY more then once
> w/o power cycling it, the PHY dies until next power cycle.
> So, we stop providing the reset GPIO to the usb code and do the reset
> in the board code.

I've tried various change w.r.t the resetting and  I cannot fault it.
Resetting or not resetting neither causes a problem while the USB is
otherwise working, not fixed the USB while  it is otherwise failing.
So I don't think this is my problem - thanks.

>=20
> >>>
> >>> Are you sure that you don't have glitch on power, reset pin during su=
spend?
> >>>
> >>
> >> No, I don't really have the equipment to measure such things.
> >> But is it likely?  Would enabling off_mode make it more likely?
> >=20
> > I don't know the reason of the off_mode problem :(
>=20
> We have the equipment to check this and no - this is not the case.
>=20
> >=20
> >> Can you suggest some way I could test the hypothesis?
> >=20
> > I had the same problem on a rugged mobile phone, so it is just experien=
ce
> > Check the modem power and reset gpio too, but if you don't need to unbl=
ock it
> > with the pin after resume we know that modem is not the problem
>=20
> I don't think modem is the problem...
> We have plain USB connector ports that are dead after the resume from off=
-mode.
>=20
> The good news are that we have the off-mode working on v3.6.1,
> including the USB, but we had to do some horrible ugly hacking for this.
>=20

I assume this  means "some patches on top of 3.6.1" ??
Care to share your code?  Even horribly ugly hacks can be educational.

Thanks,
NeilBrown

--Sig_/Cv4mdiu5__yEAuJkrxGidoY
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIVAwUBUPZWDjnsnt1WYoG5AQKpRA/9Eb7DF7KU2MJxFkHvbv3I0klCh+MHGXDp
nYqyb7mnUqC+PiZYSUaXA+esZSVraiTSjR0mTBKWqHdnsEYcRbNrehpIB22R5V8P
RgASNzS/dpWaJ2SDG9kkjmmhiEXRUBqvAmF4YqQbxBTqdT2hmgbN+eeeyXfWjrJI
jaHeZlB86R89caFDJuQOFETKMN7mSeNgQLNI27YsPbDVzgp40RiRBpD9QmvqC8er
gGRZox5IW5g/BN1B0eioVR+iwR8Use2IXm2vc/8sPQjanY0KYMksecF3Zoxon1Vk
JaEJfYO5l1+But6nSi6BVytHhoLwkSDuGLsoWlHEZ1AJL/+T9dt1pnVYgLefEN90
QXAgE/wbVR5xz4Fl8Sedz1r+oqbV07f2hbCWjFiBub/Gf9BSt6kGoIosTgXprK6i
8Xrmf7RDpMiXdsGmDFwzFQIRJElQ1F5trcoZn8Q6E/PdHhf8dRflSCT4CwuWe8ao
GDljkRh68Qry7QyrKrOV5rshdt3BCOrEoppOlaGa1dIbG7CoRfr3pVl8WE9V5Cwj
/oKd79j8UOxYDg870CNuIC9Cs0U4tBgUm42p8OKUBmYGfz+Hqs3av8d7tVxTAAx5
vRjPOz2QOn9DBi7O8Efb+qrHPtDNUHVj6nVXTizCLzwZ2Pp7eqCRIk6wJ5U7XaOS
nHTz0ixYJKc=
=qrsg
-----END PGP SIGNATURE-----

--Sig_/Cv4mdiu5__yEAuJkrxGidoY--
