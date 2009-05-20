From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: Impact of SR reflex or pm patches on the ADS7846 touchscreen controller
Date: Wed, 20 May 2009 09:38:49 +0200
Message-ID: <63C6AFF7-93F4-4269-9676-71378AD0218E@student.utwente.nl>
References: <1E88D8D2-FACB-42F8-8D48-319834A1A118@mac.com>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-18-357440888"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx3.utsp.utwente.nl ([130.89.2.14]:64195 "EHLO mx.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752028AbZETHjX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 May 2009 03:39:23 -0400
Received: from [172.20.1.5] (vpn006011.vpn.utwente.nl [130.89.6.11])
          by mx.utwente.nl (8.12.10/SuSE Linux 0.7) with ESMTP id n4K7cpkk030524
          for <linux-omap@vger.kernel.org>; Wed, 20 May 2009 09:38:51 +0200
In-Reply-To: <1E88D8D2-FACB-42F8-8D48-319834A1A118@mac.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Users <linux-omap@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-18-357440888
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 20 mei 2009, om 05:37 heeft Elvis Dowson het volgende geschreven:

> Hi,
> 	I just noticed that after incorporating the SR reflex and the  
> recent patches from 187 onwards (using git format patch master on  
> the pm branch),
>
> my ADS7846 touchscreen controller's response has become modified.  
> Any possible links or is there some dependency between the SR reflex  
> patches and the pm patches for the ADS7846 touchscreen controller?

I've noticed that the TS behaves OK at ~500MHz and up, but becomes  
troublesome at lower frequencies. I've 'solved' this by using the  
performance cpufreq governor :)

regards,

Koen

--Apple-Mail-18-357440888
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: Dit deel van het bericht is digitaal ondertekend
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFKE7OLMkyGM64RGpERAtSeAJ0U8Wr3SR+9yeTFsTn06idjjgOGWgCgh/3L
Yf3dKUH2TQXufabv216WcSI=
=19od
-----END PGP SIGNATURE-----

--Apple-Mail-18-357440888--
