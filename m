From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: omap3evm LCD red-tint workaround
Date: Sun, 2 Nov 2008 18:37:30 +0100
Message-ID: <57322719-1A5A-45DC-9846-5C0A3B6EF346@student.utwente.nl>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-10-379631340"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx2.utsp.utwente.nl ([130.89.2.13]:47033 "EHLO mx.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753824AbYKBRiS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 2 Nov 2008 12:38:18 -0500
Received: from [172.20.0.255] (vpn006018.vpn.utwente.nl [130.89.6.18])
          by mx.utwente.nl (8.12.10/SuSE Linux 0.7) with ESMTP id mA2HbXEK032480
          for <linux-omap@vger.kernel.org>; Sun, 2 Nov 2008 18:37:33 +0100
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-10-379631340
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit

Hi,

While trying various kernels on the EVM to see what's causing the red  
tint (or rather, lack of blue) on the lcd I found a workaround to get  
correct colours with 2.6.27-omap1:

* boot 2.6.22.18 (from the BSP)
* do a warm reset (e.g pressing WARM_RST)
* boot 2.6.27-omap1

This makes me suspect that 2.6.27-omap1 isn't initializing something,  
does anyone have a clue what that bit might be?

regards,

Koen

PS: TS is still unusable with the 16x16 pixel resolution

--Apple-Mail-10-379631340
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFJDeVdMkyGM64RGpERAjJlAJ9AjF+LSGjGYFi6PDNaB+IMrxpyUgCdF5Pf
yOVRYHdjzwQvsOfjvZp1vXY=
=Emu/
-----END PGP SIGNATURE-----

--Apple-Mail-10-379631340--
