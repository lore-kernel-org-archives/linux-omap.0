From: Felipe Balbi <balbi@ti.com>
Subject: Re: [patch] dwc3: add a kfree() on error to dwc3_testmode_open()
Date: Fri, 26 Aug 2011 13:48:59 +0300
Message-ID: <20110826104858.GG22532@legolas.emea.dhcp.ti.com>
References: <20110826092113.GO5975@shale.localdomain>
 <20110826103240.GA6060@linutronix.de>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NIe73rPL8TFc/U1V"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:47086 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751249Ab1HZKtD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 26 Aug 2011 06:49:03 -0400
Content-Disposition: inline
In-Reply-To: <20110826103240.GA6060@linutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Dan Carpenter <error27@gmail.com>, Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman <gregkh@suse.de>, "open list:DESIGNWARE USB3 D..." <linux-usb@vger.kernel.org>, "open list:DESIGNWARE USB3 D..." <linux-omap@vger.kernel.org>, kernel-janitors@vger.kernel.org


--NIe73rPL8TFc/U1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Aug 26, 2011 at 12:32:40PM +0200, Sebastian Andrzej Siewior wrote:
> * Dan Carpenter | 2011-08-26 12:21:13 [+0300]:
>=20
> >Btw.  This function returns -EBUSY on success.  Was that really what
> >you want?
>=20
> At that time yes. The idea was to enable the self-test mode of the core
> and let it do transfers forth and back and see if it works. There is
> also no off switch. I wasn't aware that this piece of code is going to
> merged but now I think we need an off switch.

yeah, this is rather useful to test the underlying HW. We had the same
feature on MUSB and it helped check if EP0 handling and FIFO access was
working fine.

> Thanks for spotting this.

indeed.

--=20
balbi

--NIe73rPL8TFc/U1V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOV3oaAAoJEAv8Txj19kN17yYH/jXcdW3qCOAIIisnlV4+fTMi
nuccXqIi97XFa01OTmo/tJWNalpAhe7nR+oVmgfhfftgigGzUBvTLXt1FDp99coP
42E3Si8JSkjDukfIjqQP8uGjEwbTFuPxBjurZCxUbGR6sRzygmvsHJxeeJwcjBtP
UFt1gc179UCm0bOfyc8RYqwAJAwyY+vAxoshumRJ6R491VQSSZtypgSWvvmO4e0U
WyS8FjXJcX82yqJ9ERrLO7tJdoaJ+ScrF6wUxHMqlbI1gu6hNfVNTOvsU1mLu+jj
bJVKnhZWVW5khkzcZgqGf+xRtmNzPmYiOMOrRxsKYDChp6lxjKe1nthafRaEPf4=
=tCnB
-----END PGP SIGNATURE-----

--NIe73rPL8TFc/U1V--
