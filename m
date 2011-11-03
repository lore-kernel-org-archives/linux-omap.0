From: Koen Kooi <koen@dominion.thruhere.net>
Subject: Re: Linux 3.0 DSS support
Date: Thu, 3 Nov 2011 10:35:22 +0100
Message-ID: <49A85CFF-CB0B-435C-BB54-12D247ABB6BE@dominion.thruhere.net>
References: <CANLagX8WaHGkqOZ2UnLR1ihOABbdDy1ZAyW19yO=f-JNUaLKfw@mail.gmail.com> <4E9BD71A.90703@ti.com>  <4EA5A677.3050704@logicpd.com> <1319528229.1684.20.camel@lappyti>
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: multipart/signed; boundary="Apple-Mail=_9AD4F89F-381F-4FB0-AC33-5B5B9D665D44"; protocol="application/pgp-signature"; micalg=pgp-sha1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:47612 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750974Ab1KCJfc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Nov 2011 05:35:32 -0400
Received: by wwi36 with SMTP id 36so1556025wwi.1
        for <linux-omap@vger.kernel.org>; Thu, 03 Nov 2011 02:35:30 -0700 (PDT)
In-Reply-To: <1319528229.1684.20.camel@lappyti>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Peter Barada <peter.barada@logicpd.com>, Ashwin Bihari <abihari@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


--Apple-Mail=_9AD4F89F-381F-4FB0-AC33-5B5B9D665D44
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


Op 25 okt. 2011, om 09:37 heeft Tomi Valkeinen het volgende geschreven:

> Hi,
>=20
> On Mon, 2011-10-24 at 13:55 -0400, Peter Barada wrote:
>>=20
>> In the above case (and my case where I'm looking for a 9Mhz pixel=20
>> clock), fck_div is calculated at higher than 16 - and the video
>> output=20
>> is wrong (i.e. no pixel clock and hsync runs at 32x the requested
>> rate).=20
>=20
> DM37x TRM says:
>=20
> "DSS1_ALWON_FCLK: Issued from DPLL4. Its frequency can be a division =
by
> 1 to 16 of the frequency of the DPLL4 synthesized clock."
>=20
> I take it that DM37x is detected as cpu_is_3630()?
>=20
> The DSS driver currently handles only OMAPs, so for other SoCs the
> driver may contain lots of bugs like this.

dm3730 is just a different marketing name for omap3630, it should not =
have any functional changes.

regards,

Koen=

--Apple-Mail=_9AD4F89F-381F-4FB0-AC33-5B5B9D665D44
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----

iEYEARECAAYFAk6yYFoACgkQMkyGM64RGpGQJACguToKfZSwqilHX+/VDAiqnfwe
yKwAn0jhg2goJFlmuwjcHjZ7xqNgo8hT
=GwsC
-----END PGP SIGNATURE-----

--Apple-Mail=_9AD4F89F-381F-4FB0-AC33-5B5B9D665D44--
