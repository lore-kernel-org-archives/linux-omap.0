From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCHv8 06/10] I2C: OMAP: Fix the crash in i2c remove
Date: Tue, 24 Apr 2012 20:18:06 +0200
Message-ID: <20120424181806.GF9007@pengutronix.de>
References: <1334842101-20670-1-git-send-email-shubhrajyoti@ti.com>
 <1334842101-20670-7-git-send-email-shubhrajyoti@ti.com>
 <20120423164944.GE27321@pengutronix.de>
 <4F96ED77.9070503@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="R6sEYoIZpp9JErk7"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:47124 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755956Ab2DXSSX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Apr 2012 14:18:23 -0400
Content-Disposition: inline
In-Reply-To: <4F96ED77.9070503@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti <shubhrajyoti@ti.com>
Cc: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, ben-linux@fluff.org, tony@atomide.com, stable@vger.kernel.org


--R6sEYoIZpp9JErk7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 24, 2012 at 11:44:15PM +0530, Shubhrajyoti wrote:
> On Monday 23 April 2012 10:19 PM, Wolfram Sang wrote:
> >>     [  154.901153] Exception stack(0xdf9b9fb0 to 0xdf9b9ff8)
> >> >     [  154.907104] 9fa0:                                     beaf1f0=
4 4006be00 0000000f 0000000c
> >> >     [  154.915710] 9fc0: 4006c000 00000000 00008034 ffffff40 0000000=
7 00000000 00000000 0007b8d7
> >> >     [  154.916778] 9fe0: 00000000 beaf1b68 0000d23c 4005baf0 8000001=
0 ffffffff
> >> >     [  154.931335]  r6:ffffffff r5:80000010 r4:4005baf0 r3:beaf1f04
> >> >     [  154.937316] ---[ end trace 1b75b31a2719ed21 ]--
> >> >=20
> >> > Cc: <stable@vger.kernel.org>
> >> > Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> > Is this really the correct solution? I do wonder that every driver using
> > runtime PM should enable the clocks on their own. That should be done by
> > the core,=20
> By core you don't mean the i2c core but the pm layer right?

Yes.

> > I'd say; it is not unusual that drivers need to write to
> > registers in remove(). If it is correct, can I get some acks?
> I did see the crash.

That was never a doubt. With "correct" I meant "correct solution".

> Will wait for the pm experts to comment.

Yup.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--R6sEYoIZpp9JErk7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk+W7l4ACgkQD27XaX1/VRvz3gCfb4ja4eybNhSqZNpjB547secD
7gAAoK0znYZS4TcWf1oq3+Ba45TLUamI
=1D5G
-----END PGP SIGNATURE-----

--R6sEYoIZpp9JErk7--
