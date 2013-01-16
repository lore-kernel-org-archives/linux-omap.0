From: NeilBrown <neilb@suse.de>
Subject: Re: Help wanted with USB and OMAP3 off_mode
Date: Wed, 16 Jan 2013 18:28:31 +1100
Message-ID: <20130116182831.2c7b45ad@notabene.brown>
References: <20130109092915.1c2077b5@notabene.brown>
	<50ED3FA5.9030905@compulab.co.il>
	<20130109211931.0e00db5d@notabene.brown>
	<50ED4549.6080802@amarulasolutions.com>
	<20130109223456.7832c2bd@notabene.brown>
	<50ED57B3.9060507@amarulasolutions.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/qwnrqwJ_mnqiOgcWNXVvx6a"; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:34532 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752864Ab3APH2n (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Jan 2013 02:28:43 -0500
In-Reply-To: <50ED57B3.9060507@amarulasolutions.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Igor Grinberg <grinberg@compulab.co.il>, linux-omap@vger.kernel.org

--Sig_/qwnrqwJ_mnqiOgcWNXVvx6a
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 09 Jan 2013 12:42:43 +0100 Michael Trimarchi
<michael@amarulasolutions.com> wrote:

> On 01/09/2013 12:34 PM, NeilBrown wrote:
> > On Wed, 09 Jan 2013 11:24:09 +0100 Michael Trimarchi
> > <michael@amarulasolutions.com> wrote:
> >=20
> >> Hi Neil
> >>
> >> On 01/09/2013 11:19 AM, NeilBrown wrote:
> >>> On Wed, 09 Jan 2013 12:00:05 +0200 Igor Grinberg <grinberg@compulab.c=
o.il>
> >>> wrote:
> >>>
> >>>> -----BEGIN PGP SIGNED MESSAGE-----
> >>>> Hash: SHA1
> >>>
> >>>> Hi Neil,
> >>>
> >>>> On 01/09/13 00:29, NeilBrown wrote:
> >>>>>
> >>>>> Hi,
> >>>>>  I'm trying to get off_mode working reliably on my gta04 mobile pho=
ne.
> >>>>>
> >>>>> My current stumbling block is USB.  The "Option" GSM module is atta=
ched via
> >>>>> USB (there is a separate transceiver chip attached to port 1 which =
is placed
> >>>>> in OMAP_EHCI_PORT_MODE_PHY).
> >>>
> >>>> Which PHY is this (vendor/model)?
> >>>
> >>> Hi Igor,
> >>>   it is the SMSC USB3322
> >>>
> >>> http://www.smsc.com/media/Downloads_Public/Data_Sheets/3320.pdf
> >>>
> >>>
> >>> BTW I subsequently discovered that keeping USBHOST out off off_mode o=
nly
> >>> sometimes avoid the problem, not always.  So there are probably multi=
ple
> >>> issues :-(
> >>
> >> Are you sure that you don't have glitch on power, reset pin during sus=
pend?
> >>
> >=20
> > No, I don't really have the equipment to measure such things.
> > But is it likely?  Would enabling off_mode make it more likely?
> > Can you suggest some way I could test the hypothesis?
> >=20
> > The power pin is connected to a 3v3 regulator which certainly should st=
ay on
> > the whole time and other things which depend on it keep working.
> >=20
> > The reset line is connected to GPIO174 which is configured:
> >=20
> > # cat /sys/kernel/debug/omap_mux/mcspi1_cs0
> > name: mcspi1_cs0.gpio_174 (0x480021ce/0x19e =3D 0x011c), b ac2, t NA
> > mode: OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE4
> > signals: mcspi1_cs0 | sdmmc2_dat7 | NA | NA | gpio_174 | NA | NA | safe=
_mode
> >=20
> > The "PIN_INPUT" seems a bit odd, so I changed it to OMAP_PIN_OUTPUT but=
 that
> > didn't appear to make any difference.
> >=20
>=20
> Can you try to add this OMAP_PIN_OFF_OUTPUT_HIGH or LOW? It's suppose to =
be the off_mode status of the pin.
> Is it correct?
>=20

You only set OMAP_PIN_OFF_OUTPUT_HIGH etc if you want the status  in
offmode to be different to what is was before off mode.
In the normal case without any of these bits set, the current value is
latched when output in entered and it remains like that that until you
leave off_mode.

Thanks,
NeilBrown

--Sig_/qwnrqwJ_mnqiOgcWNXVvx6a
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIVAwUBUPZWnznsnt1WYoG5AQKVrxAAlmXf0Jf1uxjhQfntaP96Pnikxt2Y86w3
tY5wJF9TjQ+yp0Q7ZDM4/cdPmarn5mbfmG2Z45IVvD9CxHHGK64HipEw5rQJLJeK
ay2brjUetGZVHrnELto6rIqxRKgrjqK0+of29tCxr//kTxykGxzd32nep+bfn3+s
Q2YBbj65RoVOWbZYfc86LlP7hRj27qoEY7txkMVx7I1mUz8VsaV7tXD1MA1y/hXC
FhtiAJLlMNDdeYMJFMSgOA7aNUrr142rBQsO20zMb5222Qay1D9YrAS0SK4jAq4C
loI8K99kmPTZk6A39pifeZ+tZx4DMHCPs31BEKmP5R0HWpxewkJFtmQ8ObsybgwV
8SxdWtdheG2aCSzIXU7qx6RESwbhomvyu2excjkMh49mJZZrbZyTFk6olZVtvYlH
wwW05HDhMWu2YFhkftKeqBVR659cVRhnyfXL6/xyoeWELEbEDRvTA5gxyNZWhJjF
3Y/inKdTIsGnyzIDOG63H8lZ3kkWz489B/1GOgCzSaNe6emxUFMopiX9ZxQ9koQe
DrQaKAHYQ0XBcXULncQFplp5GMt+WhqWNAHSrV/zD4hRciWaZg3nJhJHmMe3JjcR
as0RbVSaOCcoIjGEaYInpjA4c/SUrfWhxAnsQj8vyZWnfv+uHMFS7/VfXyrm9hnc
ucUOWO1CxjQ=
=Q9qe
-----END PGP SIGNATURE-----

--Sig_/qwnrqwJ_mnqiOgcWNXVvx6a--
