From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: PM branch rebased to 2.6.29
Date: Mon, 30 Mar 2009 12:42:24 +0200
Message-ID: <B71C5453-5BD7-4A43-BCEC-F4BFACBF1DC1@student.utwente.nl>
References: <87bprz9zju.fsf@deeprootsystems.com> <1237914611.23022.124.camel@blackhole> <87zlfaztcd.fsf@deeprootsystems.com> <1237925484.23022.133.camel@blackhole> <49C940CA.9070805@deeprootsystems.com> <f9d2a5e10903271350x2d534c76nc55c492b8acd1d4e@mail.gmail.com> <B85A65D85D7EB246BE421B3FB0FBB59301CC5699A0@dbde02.ent.ti.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-3-257022993"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx1.utsp.utwente.nl ([130.89.2.12]:60796 "EHLO mx.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758116AbZC3Kmy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Mar 2009 06:42:54 -0400
Received: from [172.20.1.5] (vpn006011.vpn.utwente.nl [130.89.6.11])
          by mx.utwente.nl (8.12.10/SuSE Linux 0.7) with ESMTP id n2UAgQV8018997
          for <linux-omap@vger.kernel.org>; Mon, 30 Mar 2009 12:42:26 +0200
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301CC5699A0@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-3-257022993
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit

Op 30 mrt 2009, om 12:08 heeft Premi, Sanjeev het volgende geschreven:

> I had found that two drivers that could prevent clocks_off are
> USB and DSS because of the way they use clk_enable().

How does DSS2 behave in that regard, and is there any effort in fixing  
the MUSB and EHCI drivers?

regards,

Koen

--Apple-Mail-3-257022993
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: Dit deel van het bericht is digitaal ondertekend
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFJ0KISMkyGM64RGpERAlGnAJ9SEi6PeK0MV324KQRaCJ2XABvV8QCgtxv3
AehLNIZwtuU5gkio+HIVZD0=
=BJ/0
-----END PGP SIGNATURE-----

--Apple-Mail-3-257022993--
