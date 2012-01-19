From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: DSS2/PM on 3.2 broken?
Date: Thu, 19 Jan 2012 12:40:58 +0200
Message-ID: <1326969658.1935.24.camel@deskari>
References: <20120110080849.5a242adf@notabene.brown>
	 <alpine.DEB.2.00.1201110632100.31702@utopia.booyaka.com>
	 <20120112095940.0a54413e@notabene.brown>
	 <alpine.DEB.2.00.1201130253070.3659@utopia.booyaka.com>
	 <20120113222045.37f9b4ec@notabene.brown> <1326870839.1954.23.camel@deskari>
	 <20120118221538.342b4782@notabene.brown> <1326886940.1999.5.camel@lappy>
	 <20120119073032.74cc0992@notabene.brown>
	 <WC20120119101721.07072A@terrafix.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-FfqtnJyuUz8SkRUN6NDO"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:40490 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750978Ab2ASKlE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Jan 2012 05:41:04 -0500
Received: by laah2 with SMTP id h2so3545072laa.37
        for <linux-omap@vger.kernel.org>; Thu, 19 Jan 2012 02:41:00 -0800 (PST)
In-Reply-To: <WC20120119101721.07072A@terrafix.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joe Woodward <jw@terrafix.co.uk>
Cc: NeilBrown <neilb@suse.de>, Paul Walmsley <paul@pwsan.com>, khilman@ti.com, t-kristo@ti.com, govindraj.r@ti.com, linux-omap@vger.kernel.org


--=-FfqtnJyuUz8SkRUN6NDO
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-01-19 at 10:17 +0000, Joe Woodward wrote:
> ...snip...
> >=20
> >    cat /sys/kernel/debug/omapdss/clk
> >=20
> > is below and reports 66461538 for fck, so 66MHz?  Still safe for OPP50.
> >=20
> > And disabling SMART REFLEX had no obvious effect.
> >=20
> > If you can think of anything else I could try to explore to narrow down
> > the source of this, I am very happy to test or examine anything you
> > suggest.
> >=20
> > Thanks,
> > NeilBrown
> >=20
>=20
> I'm not sure if this will give you any pointers but i'll tell you what I'=
m fairly certain I'm seeing...
>=20
> If I run the stock 3.2 with the changes to dss.c and dispc.c to make the =
pm_runtime_put()'s in to pm_runtime_put_sync()'s then the DSS warnings when=
=20
> suspending do indeed go away.
>=20
> I have two wake sources, one being the UART the console is on and the oth=
er being a GPIO button.
>=20
> I've tested the following situations:
>  - If I sleep using the console and wake by typing a character then I *ne=
ver* get a SYNC_LOST error.
>  - If I sleep by pressing a button on the display (which does a system ("=
echo mem > /sys/power/state") and then wake by typing a character in to the=
 console then=20
> I *never* get a SYNC_LOST error.
>  - If I sleep by pressing a button on the display (which does a system ("=
echo mem > /sys/power/state") and then wake by pressing a button attached t=
o the GPIO=20
> then I get a sequence of SYNC_LOST errors which continue at a rate of abo=
ut one every 0.5 seconds until a type a character in to the console and the=
n everything=20
> settles down and starts working again.
>=20
> So, at least from what I'm seeing, the SYNC_LOST errors seem related some=
how to the UART, if that is indeed possible?

Well, I don't see how UART could directly affect DSS. The thing that
comes to my mind is that typing a char in the console causes a change in
the power management, which then "fixes" the DSS. But then again, I'd
expect the console to go into sleep/idle state after a short while,
which should again cause sync_losts. But that's not happening...

Can you show the dss clocks you use (cat debugfs/omapdss/clk)?

It's been a while since I did anything with PM, so I don't remember how
and if it can be done, but a simple test would be to lock the OMAP to
always use OPP100.

 Tomi


--=-FfqtnJyuUz8SkRUN6NDO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPF/M5AAoJEPo9qoy8lh71oagP+wQ+t9lFAntYU1zl8pCbgVsS
BU2UEXicEEE31q0mLHhJzH1b13dOM72sV2d/QhGMLzXw4BS3JsecfEYkRMJP3FIG
8ZYx14Im+/nEf4poagbbaO2HgK9mapzGt7ii/AoIe4z9rkb6gw1ywEXWxv+vhrjs
XbEaXbgb3Ws1bu7bwF/hlxczGCJaPqdNJwDNZGWMXOPMFw7Tg+nilkYBOJNQBfNW
QJ0vEDJa9OITANyf+TXcPRouOSAeLL/yGyieVSG4W/HdigPvk47+lsfDaJWttJz+
bndMj86lCBdMhZI6FJbuqh8asJ6aL39tukrF4yNsa+Vpr6oQkiCX9TipEE0VVcx6
Ory0kR1ZCWIFIUCUXj6Cvd6qCeLB9G1lJxLd0K0Tm50KX6oRrF5/iJqqAMjTDKGb
KHrttXFV43F4tpDiZDISlIk0D0WPf3WI2/8HtCnIONA/T6hcEia51RVvAiba/8/a
G50n/CC7uka3bBvP9svI+JYEm5yIftLPDUD/LmyMNNbJj5To1jmmVwqtMXVMNUNJ
LBb5SfC40iVToyNLpQJQOkhfkS0H0PIMLSw7KWshMsnBfNk7lguSR7OtwouNrNoy
RdPlnAQWZ1J77P9/Gxk2ZwvKQVNIwCytxgJ/fG/3Yx6+nEBpK6yABmnCDXTH2Hwg
uhJy+PqaZPGCkAlyHpK/
=EMSi
-----END PGP SIGNATURE-----

--=-FfqtnJyuUz8SkRUN6NDO--

