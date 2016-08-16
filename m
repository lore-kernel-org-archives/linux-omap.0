From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [RFC 5/7] Bluetooth: hci_nokia: Introduce new driver
Date: Tue, 16 Aug 2016 11:25:48 +0200
Message-ID: <20160816092548.swayvx4zu3vlg7as@earth>
References: <1471058078-5579-1-git-send-email-sre@kernel.org>
 <1471058078-5579-6-git-send-email-sre@kernel.org>
 <0528B894-39CB-4D18-971E-3209EEEA2583@holtmann.org>
 <20160816075217.GK30047@pali>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="o7bzbzsdqbdxhmu2"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160816075217.GK30047@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Ville Tervo <ville.tervo@iki.fi>, Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>, ivo.g.dimitrov.75@gmail.com, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--o7bzbzsdqbdxhmu2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Aug 16, 2016 at 09:52:17AM +0200, Pali Roh=E1r wrote:
> > > +		case HCI_NOKIA_RADIO_PKT:
> >=20
> > Are you sure you can ignore the RADIO_PKT commands. They are
> > used to set up the FM radio parts of the chip. They are standard
> > HCI commands (in the case of Broadcom at least). At minimum it
> > should be added a comment here that you are ignoring them on
> > purpose.
> >=20
> > > +		case HCI_NOKIA_NEG_PKT:
> > > +		case HCI_NOKIA_ALIVE_PKT:
> >=20
> > And here I would also a comment on why are we ignore these
> > commands and driving this all by ourselves.
> >=20
>=20
> Good question... In Pavel's version of bluetooth driver, which is
> working on Nokia N900, is sent whole firmware at one __hci_cmd_sync
> step. It does not skip any packets, plus he added this comment:
>=20
> /* Note that this is timing-critical. If sending packets takes
>  * too long, initialization will fail.
>  */
>=20
> So really, can we skip those packets? And is not this reason why
> this bluetooth driver does not work on Nokia N900?

Let's have a look - here is Pavel's version:
https://lwn.net/Articles/627201/

In pseudocode:

while(true) {
    cmd =3D get_cmd_from_firmware();
    if (!cmd) break;
    __hci_cmd_sync(cmd);
}

This is not "whole firmware at one __hci_cmd_sync step", is it?
And obviously that wouldn't work. Next let's have a look at
"It does not skip any packets":

/* Skip first two packets */
if (++num <=3D 2)
    continue;

Which are HCI_NOKIA_NEG_PKT and HCI_NOKIA_ALIVE_PKT. Those are
open-coded. By using the packets from the firmware we could drop the
negotiation/alive functions from the driver and remove quite a few
lines of code. I think it should only be done after finding the N900
bug, though. I found it quite useful, that first communication does not
happen through the firmware file.

Surely the radio packet is not ignored, but that part is not used on
N950 and N900 fails at first packet, so no way to test the radio
packet handling. I probably should add a /* TODO: check how to
handle radio packets */ for the radio packet entry. Or implement it
the way Marcel suggested and hope that it just works once the other
bug is found.

-- Sebastian

--o7bzbzsdqbdxhmu2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXstwXAAoJENju1/PIO/qaTZwP/1F4KCuwWEdThZPDApa6cW1A
Dv54llsXV1A907qhn58CWAm2OTYny/Ygl9m3V4Ox0aJ3JlNc1nJcGY5Y6rKibf/9
Hcq+VNXytc8NiZ0Q73NrtxbLqoJPBNs+qYy1GqO08q6+rxwv99dJLpN9DUPtgt/U
pm9crgkn96QdLt/R+XV2qupHBsCZOzagLZiCJPRCJX2pb/P0nyzKR20I6FX5cMjo
8IAXdhf+oJrV6RiGpcaVT7FPw/GG6DeoQ/7hBhsanAEgikl03DuHTjmgUx9wlwIp
OFLTlEj01ZNf63wZa9Qr7fbzsPJrQdFfycT/RHTMX8ExNGOu4zokyIDg998rqU1M
cdyAoOJ/ak1mygbF4Ae8d/RsAjhsL8JTmQgsgkkemDLlVZAuh54jZTJPFX97lZ2k
pxl0K6iCobu6bxTDz3lnHwgxnkg3Z7cdhl0ZMZkVEZ7GhzmhdoeTA2oVDA3AVKot
pxHfkcB/JNt7fd29arHFdz+m5x3Rb83yRjZVBuXz/+b0PDJQtLPRNkjElqA+uhYO
z31QVyxpA+SPgP0qUrAFuVA9NNPMwPo756ysSkTDS8drabOKaJBUri7wmcn2kfdF
TPVu3BZpX//5nOJDBSpn0notykZi0kh3SdnDUBljg1Og3GqIsOZ/poEA8lmbaGVU
8Y8yB4g7wpH2RxMWUGBZ
=C/Js
-----END PGP SIGNATURE-----

--o7bzbzsdqbdxhmu2--
