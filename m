From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: defconfig for omap3-evm
Date: Fri, 21 Nov 2008 13:20:28 +0100
Message-ID: <4315F7A2-D487-4BC2-A7BD-C3EFB639C30F@student.utwente.nl>
References: <52c7556c0811210359n73256679pd50f391c48af5530@mail.gmail.com> <19F8576C6E063C45BE387C64729E739403E8E67DEC@dbde02.ent.ti.com> <52c7556c0811210408k62cd7d4cxfa8b677f978ef68a@mail.gmail.com> <52c7556c0811210413jb6616ddj51950b59897ffc47@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-7--145274529"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx1.utsp.utwente.nl ([130.89.2.12]:33196 "EHLO mx.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753568AbYKUMUl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 21 Nov 2008 07:20:41 -0500
In-Reply-To: <52c7556c0811210413jb6616ddj51950b59897ffc47@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Amit Pundir <pundiramit@gmail.com>
Cc: "Hiremath, Vaibhav" <hvaibhav@ti.com>, "Premi, Sanjeev" <premi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-7--145274529
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 21 nov 2008, om 13:13 heeft Amit Pundir het volgende geschreven:

> The reason I moved to linux-omap kernel from the provided with EVM is
> that I was not able to run my Xorg server on omap-3.
>
> So I raised my concern in Xorg mailing list regarding my problem i.e.
> running X on
> omap3-evm. In reply they told me that "the problem is the TI's omapfb
> which won't let you set arbitrary modes. The mainstream one (i.e. the
> one in linux-omap) works fine with fbdev."
>
> Can anyone please confirm that it is a known issue with TI provided  
> kernel.

I can confirm that X works fine on my evm with 2.6.28rc4, but X also  
works with the ti .22 kernel on my evm and beagle. Dunno why that is.  
Anyway, 2.6.28rc4 with DSS2 patches works soooooooo much better than . 
22.

regards,

KOen

> Regards
> Amit Pundir
> --
> To unsubscribe from this list: send the line "unsubscribe linux- 
> omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


--Apple-Mail-7--145274529
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFJJqeOMkyGM64RGpERAp0lAKCz7NTlW0Fv/CjUts6mcmRJzL8cIQCfSWaZ
psB2BVaZKaQBlwZdEHB+Sto=
=AzoG
-----END PGP SIGNATURE-----

--Apple-Mail-7--145274529--
