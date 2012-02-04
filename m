From: NeilBrown <neilb@suse.de>
Subject: Re: patch "tty: serial: OMAP: ensure FIFO levels are set correctly
 in non-DMA" added to tty tree
Date: Sat, 4 Feb 2012 14:43:53 +1100
Message-ID: <20120204144353.0803fe23@notabene.brown>
References: <13274430881471@kroah.org>
	<alpine.DEB.2.00.1201251156361.5324@utopia.booyaka.com>
	<20120126042155.GA3185@suse.de>
	<alpine.DEB.2.00.1201252124470.11174@utopia.booyaka.com>
	<20120126191604.GA15516@suse.de>
	<alpine.DEB.2.00.1201261225520.32667@utopia.booyaka.com>
	<alpine.DEB.2.00.1202021302070.586@utopia.booyaka.com>
	<20120203150708.386951d2@notabene.brown>
	<alpine.DEB.2.00.1202022137150.586@utopia.booyaka.com>
	<20120203205401.5ddf241d@notabene.brown>
	<alpine.DEB.2.00.1202031255330.27947@utopia.booyaka.com>
	<20120204085940.2de44594@notabene.brown>
	<alpine.DEB.2.00.1202031532540.27947@utopia.booyaka.com>
	<20120204110131.7378b8fe@notabene.brown>
	<alpine.DEB.2.00.1202031900460.9453@utopia.booyaka.com>
	<20120204140923.063706c8@notabene.brown>
	<alpine.DEB.2.00.1202032014170.9453@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/z.q4=aAMemSNsuwP9Okc2EE"; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:59511 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751950Ab2BDDoK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 3 Feb 2012 22:44:10 -0500
In-Reply-To: <alpine.DEB.2.00.1202032014170.9453@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: greg@kroah.com, khilman@ti.com, govindraj.raja@ti.com, tomi.valkeinen@ti.com, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

--Sig_/z.q4=aAMemSNsuwP9Okc2EE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 3 Feb 2012 20:16:08 -0700 (MST) Paul Walmsley <paul@pwsan.com> wrot=
e:

> On Sat, 4 Feb 2012, NeilBrown wrote:
>=20
> > On Fri, 3 Feb 2012 19:06:19 -0700 (MST) Paul Walmsley <paul@pwsan.com> =
wrote:
> > >=20
> > > Here's a patch that helps.  It seems to work down to an=20
> > > autosuspend_delay_ms of 1 ms.  Without it, the best I can get is 8 ms.
> > >=20
> > > Of course, ideally it should work fine at autosuspend_delay_ms =3D 0,=
 so=20
> > > likely there's some other infelicity that we're currently missing.
> > >=20
> > > Neil, care to give this a test and confirm it on your setup?
> >=20
> > Yes, that seems to make the output corruption go away.
>=20
> Cool, thanks for the test :-)
>=20
> > Even with small autosuspend_delay_ms down to 0 it doesn't corrupt outpu=
t,
> > but as the first input byte is corrupted, I cannot really type with tho=
se
> > setting (so I ssh to gain control again).
>=20
> Could you try pasting in a buffer from another window?  If I paste in the=
=20
> buffer at the bottom of this message a few times, I see some output=20
> corruption.=20

I have to set autosuspend_delay_ms for omap_uart.3 as well before the
behaviour is significant.
But then I see no output corruption.  Lots of input corruption of course but
the output looks fine.

NeilBrown


>=20
>=20
> - Paul
>=20
>=20
> =20
> ;
> ;
> ;
> ;
> cat  /sys/devices/platform/omap/omap_uart.2/power/autosuspend_delay_ms
> echo 0 > /sys/devices/platform/omap/omap_uart.2/power/autosuspend_delay_ms
> cat /proc/interrupts
> ;
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--Sig_/z.q4=aAMemSNsuwP9Okc2EE
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQIVAwUBTyypeTnsnt1WYoG5AQKznRAAwJJNdnEAu42CEowscBKi5aYANuO8AED1
X3C+5nXQgr01lg/uTGpX95BvlVg0U8HXa/UT8pAf+08gPxpZvyVJSZjFkgfOE2yN
rjMq4DLTxcFwTJ1TNiVYLB/+CVTw8TiVvrZFSVe3YESFFCMP8uvtvUVG9AYWlCrc
NVbugEf3P8rGNyO5YjEOjaKsD3JCIT0mzkbBRd4d9K1/Kjen/JAJQ24+OZOuzxJR
BA9R+EiS9ZU9CFv0IC0SNHvfqPKQhNIFEfsOwFb3L2YJzOl2XVwmaRIeKWjedP5J
WbS4HvJWdPtoA4Vkq07C9XFxaKRQ0+V7dL5dSbUuKp2Fo1O6yJsUlNcnEpwoGTAP
/KeOkCu6z5i4lrSf7rzR1Td7jOzBm8ewt/pQALGA7hFqvYyiot4CQCrrkmYPL687
b05+254jhmcFJ9PLgwjbIzbaUiUjUX86zwuny6CF0MlwkaOExDKRg/viJxsCKLPp
uQzDK0PGD9am3B9m5/dMzh7TH6we9+qHHFBpqiVGfT2BPJIA4xvIZAdTwpr85ZGM
CzJIeOU5Sr7vImCh/b3iaf/ejmthRfLddP7mvDGoBOiHSIlI7Tc8eWvMYN1qx7eW
C4dLPdFsX6x4kKF680ysMvlXmtwnpdY4TTxGe9D4QReyWIXRNNrdj7Wo8uCjWbwe
NZnJpd0IgJs=
=dwyH
-----END PGP SIGNATURE-----

--Sig_/z.q4=aAMemSNsuwP9Okc2EE--
