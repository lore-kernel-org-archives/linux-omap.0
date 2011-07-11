From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 00/22] Tahvo cleanups and Retu optimization
Date: Mon, 11 Jul 2011 16:45:53 +0300
Message-ID: <20110711134551.GC2680@legolas.emea.dhcp.ti.com>
References: <1310383055-20211-1-git-send-email-balbi@ti.com>
 <20110711132842.10606a31@maggie>
 <20110711131231.GB2680@legolas.emea.dhcp.ti.com>
 <20110711154126.082c1514@maggie>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mfP1iJBimQeSOP+4"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:58127 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756441Ab1GKNp6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jul 2011 09:45:58 -0400
Received: by yic15 with SMTP id 15so2090030yic.40
        for <linux-omap@vger.kernel.org>; Mon, 11 Jul 2011 06:45:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110711154126.082c1514@maggie>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Michael =?iso-8859-1?Q?B=FCsch?= <m@bues.ch>
Cc: balbi@ti.com, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Michael =?iso-8859-1?Q?B=FCsch?= <mb@bu3sch.de>


--mfP1iJBimQeSOP+4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 11, 2011 at 03:41:26PM +0200, Michael B=FCsch wrote:
> On Mon, 11 Jul 2011 16:12:32 +0300
> Felipe Balbi <balbi@ti.com> wrote:
> > > Are you planning to implement a backlight driver for tahvo? I'm actua=
lly
> > > using the functionality that you removed in this patchset in the Open=
WRT
> > > distribution.
> >=20
> > if you have some extra documentation available, I could implement it
> > whenever I have some extra couple hours to play with this again... I
> > have no docs at all, but a led-tahvo.c would be really simple to get
> > done :-)
>=20
> All I have is the old code. No docs. It seems rather simple, though.
> Only a PWM register. That's pretty straightforward.

cool, any pointers would be good ;-)

--=20
balbi

--mfP1iJBimQeSOP+4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOGv6PAAoJEAv8Txj19kN1dDwIAK2IIHRw/JVKJJx61D0b/k0h
nc1XMnRDWaXCys0Q44c5Xv5xw0/LJ/V9aeyo+lq1wfAIKjTRAEThARmEoExauuHF
ZeIE3U3J30FZxZ0fLDGZvCQZzlTtwQM0QGW/NAJc1dERBRi4sMWagrNj2rpxmT47
Wb7xjVgSVGzNoIF4YjiyBqcK5TU/ON34vqYDOYQxdXaNF7UWhFD0HprIb7sr2yjx
1AO887QmyMMldBCA6c0wiZxPu3a/M47p0m6RD28144dnfelOAGKA/V0whDGnm66n
w967/X4rqsBFJr61/pJIfdpxbqP4XqEjpibrz9RDRJAyq5RE8/7fir32wBdfVQs=
=t5Nb
-----END PGP SIGNATURE-----

--mfP1iJBimQeSOP+4--
