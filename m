From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: LDP broken in 2.6.30-rc 2
Date: Tue, 21 Apr 2009 09:31:08 +0200
Message-ID: <3CE4B6F2-371C-443E-B010-1A05694037C1@student.utwente.nl>
References: <E49DAF743FB3E9469ED423C0D3DB5F1C9E8D7960@dnce01.ent.ti.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-35--1136778"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx3.utsp.utwente.nl ([130.89.2.14]:43981 "EHLO mx.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751377AbZDUHbS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Apr 2009 03:31:18 -0400
In-Reply-To: <E49DAF743FB3E9469ED423C0D3DB5F1C9E8D7960@dnce01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Christensen, Mikkel" <mlc@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-35--1136778
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 20 apr 2009, om 22:28 heeft Christensen, Mikkel het volgende  
geschreven:


> I cloned master a few days ago and when I boot up the OMAP3 LDP, the  
> board seem to hang in the "i2c /dev entries driver" dialog and after  
> a minute the kernel dumps. Have anybody else seen this problem?

LDP was broken in .29 as well, at least for mmc: http://patchwork.kernel.org/patch/15340/

regards,

Koen

--Apple-Mail-35--1136778
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: Dit deel van het bericht is digitaal ondertekend
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFJ7XY+MkyGM64RGpERApNDAJ94KLmljI9CFbuVflUpwjW1S+p6yQCeLawN
DV1EClzloyL4gTadStjQbKk=
=Hlpv
-----END PGP SIGNATURE-----

--Apple-Mail-35--1136778--
