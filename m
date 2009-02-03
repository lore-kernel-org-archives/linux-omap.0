From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: Anyone get the TI/PowerVR stuff working?
Date: Tue, 3 Feb 2009 21:19:38 +0100
Message-ID: <6E8DB4E1-2500-401C-9DDB-D6AF694F87C2@student.utwente.nl>
References: <048498231b3317298ee233d78d65c194.squirrel@localhost>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-6--165375056"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.utsp.utwente.nl ([130.89.2.8]:60361 "EHLO smtp.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751341AbZBCUUF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 3 Feb 2009 15:20:05 -0500
Received: from [172.20.1.5] (vpn006011.vpn.utwente.nl [130.89.6.11])
          by smtp.utwente.nl (8.12.10/SuSE Linux 0.7) with ESMTP id n13KJfUQ002892
          for <linux-omap@vger.kernel.org>; Tue, 3 Feb 2009 21:19:41 +0100
In-Reply-To: <048498231b3317298ee233d78d65c194.squirrel@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-6--165375056
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 3 feb 2009, om 20:45 heeft david.hagood@gmail.com het volgende  
geschreven:

> Does anyone on the list have any experience getting the (unfortunately
> proprietary) PowerVR drivers for the OMAP3 working under Linux and X?

Yes: http://www.youtube.com/watch?v=3ToYOgP9f9U&feature=channel_page

The samurai and proxycon are FB demos, but clutter works with X11  
(Xorg, not Xsgx).

> I've registered with TI, and downloaded the SDKs for the ZOOM and SDP
> boards, and cannot work out how to integrate them into what I've  
> built on
> my prototype.

I have the 1.3.1397 GPLv2 kernel drivers working (http://www.bat.org/~tomba/git/omap3-sgx.git/ 
) working with the yet-to-be-released 1.3.1397 userspace and Tomi's  
DSS2 patches. The release is scheduled to be 'soon', but I've heard  
rumours that WTBU customers can download it already.

regards,

Koen

--Apple-Mail-6--165375056
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: Dit deel van het bericht is digitaal ondertekend
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFJiKbcMkyGM64RGpERAqcUAKC3xnv+wtW2ZnWoX4Y+61E/CoIuaQCeND13
KeJsvp6ydYWfVv/RbhvVyMY=
=bOFj
-----END PGP SIGNATURE-----

--Apple-Mail-6--165375056--
