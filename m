From: Sebastian Reichel <sre@kernel.org>
Subject: Re: Questions about bluetooth on N900
Date: Sun, 1 Oct 2017 16:50:51 +0200
Message-ID: <20171001145051.7pyzz4bpodkd6i2b@earth>
References: <87tvzow7jv.fsf@sange.fi>
 <20170927160611.GA10775@xo-6d-61-c0.localdomain>
 <87h8vkpvtu.fsf@sange.fi>
 <20171001090133.GA16848@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ujascafppx5qlisr"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171001090133.GA16848@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Aura Kelloniemi <kaura.dev@sange.fi>, pali.rohar@gmail.com, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com
List-Id: linux-omap@vger.kernel.org


--ujascafppx5qlisr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Oct 01, 2017 at 11:01:33AM +0200, Pavel Machek wrote:
> Hi!
>=20
> >  > There is some interest. I'd like to have working bluetooth, and peop=
le from postmarketos
> >  > would probably like something, too. Unfortunately my experience is s=
ame as yours -- current
> >  > mainline does not work well on N900.
> >=20
> > I might try debugging that at some point, but I doubt I can resolve the=
 issue,
> > because I have no experience in serial port programming. With latest Bl=
ueZ I
> > got my braille display working for few seconds, before it stalled.
> >=20
> >  > > I'm considering to rebase the old hci_h4p driver on current mainli=
ne, because
> >  > > I just need a working BT connection, not code that is of good qual=
ity. Some
> >=20
> >  > Ok, I may save you some work. I have rebased version, it should be in
> >  > linux-n900 on kernel.org.
> >=20
> > I found a repo from
> > https://kernel.googlesource.com/pub/scm/linux/kernel/git/pavel/linux-n9=
00/. I
> > assume that's what you meant.
> >=20
> > The latest version is based on 4.13, but it has also some changes which=
 seem
> > not to be related to BT. I incorporated them also, but I don't know if =
they
> > are valid.
>=20
> Feel free to take those or not.
>=20
> > I was lucky that you had done rebasing of nokia_h4p, because I wouldn't=
 have
> > known what to do with DTS.
> >=20
> > Unfortunately the driver does not work properly. I can access N900 to s=
ome
> > extent with my braille display, but the connection has random freezes, =
and
> > accessing my GPS receiver (through RFCOMM) causes the whole system to h=
ang.
> >=20
> > I get the following message to syslog something like 100 times per seco=
nd when
> > BRLTTY (the braille display daemon) is communicating with the display:
> > Got IIR_RX_TIMEOUT, handling it as IIR_DRI
> >=20
> > Active BT connection also seems to trigger a bug in nokia_h4p related to
> > spinlocks. This happens in random intervals between 0.1 s and 30 s.
> >=20
> > The bugs are:
> > BUG: scheduling while atomic
> > and
> > BUG: workqueue leaked lock or atomic
> >=20
> > Stack traces suggest that it is (at least sometimes) caused by h4p_set_=
clk
> > calling clk_prepare_enable and clk_disable_unprepare functions, which s=
hould
> > only be used in non-atomic context.
> >=20
> > So, I thought it would be good for you to know that BT does not really =
work. I
> > would like to work on this, but I'm afraid my knowledge is too limited =
to
> > track this down. It would be good to know what is causing those IIR RX
> > timeouts.
> >=20
> > Also working on an obsolete driver feels like stupid now that there is a
> > driver written more properly.
>=20
> Yes, fixing obsolete driver is hard and has drawbacks. The new one
> should be fixed.
>=20
> I believe the way forward would be
>=20
> a) add logging to the old driver, to see exact data being exchanged
> during initialization.
>=20
> b) add logging to the new driver, and compare old and new driver
>=20
> c) fix the new driver to do the initialization same way the old driver
> did

FWIW I don't think the problem on N900 with hci_nokia ("new") driver is
related to incorrect data/packets being sent. I'm pretty sure there is
still some problem with the handling of flow control signals (RTS/CTS +
the GPIOs) resulting in packets not being sent and/or received properly.

-- Sebastian

--ujascafppx5qlisr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlnRAMYACgkQ2O7X88g7
+prOqBAAiGtGlh0qATuW52QzTNQ+ntRXOzzmFzVbnwAAEbBuDZRT1+eyUKM0i6LE
ThmqrJhhVzF5Lrbi/Zym8F/BE5NLX/QIbVHm7HDP6NLO3YJpRc9QluDN3uzP8ml8
RuiMNTD99OpsvFrTDuWv4qghnx0j+iUo5J2Rqd5fNuo6yBRB8vBGJRDqURAVggAf
vcSHSrm7OsyOawvkkOgt7m4aBNheu9Qj2S1yBJNUHm3pp+xhGPQwoJQfndckAaDs
3oksJVNkIfeUuaMFTJnFzGo31WFd2hnf0R9H2Sv4HdgFtZWAACU5Gu/3xMK8lrgh
B1GfxfUktPm2mE3D0c2vjsb53nVh//Vtj4i/RNkGnI7llrr3xdCrvP26XD/R7Vda
K4sKsACpwJl4rB2Ga+lA/L436rGvyul+SQ1rnKJcBP4Eqj6Rgv24dLhgfBJQpTBv
GEEXHI2qjGF3ngLBMwdt+5tKa+vTW/r+cmGO6HE4feRsPdinbqVbVm3RcR3Dp3X1
fyGiCF4lwiDu9mIenIX93taXWUH+Y2peumi+BMmmhXDF26VKvXPPHanvteQBw3qy
8LBY6mHekq1LmjWljvq9/74pqNYWIC6Yq3FO5VQuMYgkzWTHUL+NdSa5F/B5mrTB
osDj1GoRJKu7swpagG76IgJPUPlQ3LUutM0mhIxStY3MWx+Qejo=
=gias
-----END PGP SIGNATURE-----

--ujascafppx5qlisr--
