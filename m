From: NeilBrown <neilb@suse.de>
Subject: Re: patch "tty: serial: OMAP: ensure FIFO levels are set correctly
 in non-DMA" added to tty tree
Date: Sat, 4 Feb 2012 15:17:38 +1100
Message-ID: <20120204151738.0cbafa47@notabene.brown>
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
	<20120204144353.0803fe23@notabene.brown>
	<alpine.DEB.2.00.1202032050560.9453@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/e/9FKqPZP=jDlCInRWfybtP"; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:60049 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753669Ab2BDER4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 3 Feb 2012 23:17:56 -0500
In-Reply-To: <alpine.DEB.2.00.1202032050560.9453@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: greg@kroah.com, khilman@ti.com, govindraj.raja@ti.com, tomi.valkeinen@ti.com, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

--Sig_/e/9FKqPZP=jDlCInRWfybtP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 3 Feb 2012 20:56:07 -0700 (MST) Paul Walmsley <paul@pwsan.com> wrot=
e:

> On Sat, 4 Feb 2012, NeilBrown wrote:
>=20
> > I have to set autosuspend_delay_ms for omap_uart.3 as well before the
> > behaviour is significant.
> > But then I see no output corruption.  Lots of input corruption of cours=
e but
> > the output looks fine.
>=20
> OK.  Is the input corruption at the beginning of the pasted buffer, or th=
e=20
> middle?  And this is with CPUIdle enabled?
>=20
> With CPUIdle disabled here, what I thought was output corruption occurs i=
n=20
> the middle of the pasted buffer occasionally.  But it might be input=20
> corruption, if the CPU manages to empty the RX FIFO while the TX FIFO is=
=20
> empty.
>=20
>=20
> - Paul

Yes, cpu-idle is enabled.

I think corruption is mostly early, though it isn't very consistent.

e.g.

# C!jHhzys/Y?omap/omap_uart.2/power/autosuspend_delay_ms
-bash: !jHhzys/Y?omap/omap_uart.2/power/autosuspend_delay_ms: event not fou=
nd
# echo 0 > /sys/devices/platFK/////mpWWt.]au%e_mHHHhQ 5
-bash: /sys/devices/platFK/////mpWWt.]au%e_mHHHhQ: No such file or directory


NeilBrown

--Sig_/e/9FKqPZP=jDlCInRWfybtP
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQIVAwUBTyyxYjnsnt1WYoG5AQL2/Q/+LlCccSQWsCO2QEI3zLwf2QHi0DnK6u2Y
ZSUlVt0SYGYT71Ck73jmJs+6OVwsiJqx5Nn5EKKVbttoSoc5985xFsot5FBwa96p
YpUkAgZp/dOCpx2XAY6FBHxGHmmuKTXq+VCADSCQHVgr8ojopLao6roEPNyEK0VZ
n3B59ySRa4IPsmv9tpo8Yh1axJ5XtUQuHhiqpipOZG9ysPVJj/Fw/HbZzPItx01M
D/ZJYvu+Nqx0GBXnpSJ6ANuhQTUFx3EFy6bKlAgFyWf7z6f75I1VrS3ZX1yN9Iwh
lpCM9PfTQDjbLLVVzYz/ScfEXhlG9h63EuELirjU8qI9tgFFymY1cj9SWruh1Y2R
B9vxaLrYrpSnVXeQOW5nkWPBrGfYmBN0Y483dj26jgz+Fj1DmK+uQxb9QDrQMAex
NVp1mNi71xDcIQj/kEYXQ6si03Hx5RQGvBV6tE1Hi9xOTuwnJoRUWy8xC0bee6xw
A1NULObyKDDTqHdcKgzyemclkLItM9Y6YfiJoqNcB2WKJ8Hk8CZEmfFPq5UhgqTJ
rnMlNGeDVKNjAowFyy0Wch8OZuRBQsJy3uMGLTrfCSrgEURh08VvQR5910w5CBUe
6wsnZIQpcF7qtcQ0b0bMq3mDV0408/0XNK45sIO0UP4g7V8whegeIQX4bby4nRlD
YFSySChZBVw=
=pHA4
-----END PGP SIGNATURE-----

--Sig_/e/9FKqPZP=jDlCInRWfybtP--
