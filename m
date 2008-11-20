From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: [ANNOUNCE] new PM branch: pm-20081119
Date: Thu, 20 Nov 2008 15:48:59 +0100
Message-ID: <8966B984-6139-467A-BF52-EDD0D9BF91B5@student.utwente.nl>
References: <87d4grdxqh.fsf@deeprootsystems.com> <345163910811200045n3af8b3b5mbd30601aeeee31e@mail.gmail.com> <B85A65D85D7EB246BE421B3FB0FBB59301B6C8C79B@dbde02.ent.ti.com>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-15--222763662"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx1.utsp.utwente.nl ([130.89.2.12]:33704 "EHLO mx.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756052AbYKTOtL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 20 Nov 2008 09:49:11 -0500
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301B6C8C79B@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: Peter Reid <ppeter.reid@gmail.com>, Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-15--222763662
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 20 nov 2008, om 15:13 heeft Premi, Sanjeev het volgende geschreven:
>>
> These are my observations on OMAP3EVM:
>
> 1) Very frequently I see these messages:
>
> <4>__ratelimit: 6736 callbacks suppressed
> __ratelimit: 6736 callbacks suppressed
> <3>omapfb omapfb: irq error status 00c2
> omapfb omapfb: irq error status 00c2

There should be a workaround for those in 2.6.28rc3.  Rick Bronson  
posted a message about it on 7 november titled "Fix for dispc's error  
"omapfb omapfb: irq error status 4020"

regards,

Koen

regards,

Koen

--Apple-Mail-15--222763662
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFJJXjdMkyGM64RGpERAvGHAJ9xOrLobuUJpAMLicFj2YGHI2d0AACfRvDJ
Zga85TAdioDGFIgo0rI8Pqo=
=rSiF
-----END PGP SIGNATURE-----

--Apple-Mail-15--222763662--
