From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] input: keypad: lm8323: convert to threaded IRQ
Date: Sun, 19 Jun 2011 22:56:06 +0300
Message-ID: <20110619195604.GC14262@legolas.emea.dhcp.ti.com>
References: <1307999812-3802-1-git-send-email-balbi@ti.com>
 <a07cbd61db83c3308dd76f7c0f481477@doppler.thel33t.co.uk>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2JFBq9zoW8cOFH7v"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:33806 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754698Ab1FST4N (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 19 Jun 2011 15:56:13 -0400
Content-Disposition: inline
In-Reply-To: <a07cbd61db83c3308dd76f7c0f481477@doppler.thel33t.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Leigh Brown <leigh@solinno.co.uk>
Cc: Felipe Balbi <balbi@ti.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>


--2JFBq9zoW8cOFH7v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Jun 19, 2011 at 07:00:13PM +0000, Leigh Brown wrote:
> Many thanks for trying to assist me with my problem. To recap,

yeah, no problem ;-)

> I'm seeing the keypad lock-up on my N810 using this driver,
> when I type quickly.
>=20
> I tried your patch, and it doesn't fix the issue.  However, I've
> read the datasheet for the lm8323 and it looks to me like the
> interrupt should be level rather than edge triggered.
>=20
> The following additional patch makes things work for me.  I
> couldn't tell you if it's the correct thing to do but I can no
> longer cause the keypad to lock-up by typing too fast.

good good. Looks like IRQF_ONESHOT is what did the trick.

Did you check if IRQF_ONESHOT alone was enough ?

--=20
balbi

--2JFBq9zoW8cOFH7v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJN/lRUAAoJEAv8Txj19kN1jpgH/22do1oTUvvNkkVPUJDbb8Gn
b979TbkugSX7G8rKgekqHS9Oa+yrBWLKOU9beCjz2NdvArNp3zr2+pOf1F6x1UlQ
hIHi92sebIPX3yldTV5/Hzo2FhFG5z7e2kLbcJefJYQUPEZE8o4IYifnyQ4BDdGZ
3FdjhPxeS9OUtYtT/xB5qIZBcbbiVFClfIXODPVPUf0VKUhQa8SerHNzyjybRuFW
bTsiIgQmMkW12XDFTys8MvZk9Kks7cYOgaT6GMCJhI1/5RK98VP/992DFLR2sydB
fmce6Ge0D25emCyaVzDqaMNIkHgTjqnT2Yitnlatae1ZiujoI0F54LCPVZt9IMc=
=13GQ
-----END PGP SIGNATURE-----

--2JFBq9zoW8cOFH7v--
