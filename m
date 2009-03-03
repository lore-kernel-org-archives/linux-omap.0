From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: Anyone built the kernel drivers for the PowerVR under  linux-omap-2.6?
Date: Tue, 3 Mar 2009 08:32:12 +0100
Message-ID: <1D24AF54-A1B5-4BFD-BBB3-09E1BB1F0A7F@student.utwente.nl>
References: <c6ef7709f9373651496b2a32ca42f571.squirrel@localhost>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-3-60295212"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx1.utsp.utwente.nl ([130.89.2.12]:58356 "EHLO mx.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751794AbZCCHcV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 3 Mar 2009 02:32:21 -0500
Received: from [172.20.1.5] (vpn006010.vpn.utwente.nl [130.89.6.10])
          by mx.utwente.nl (8.12.10/SuSE Linux 0.7) with ESMTP id n237WEV8001801
          for <linux-omap@vger.kernel.org>; Tue, 3 Mar 2009 08:32:15 +0100
In-Reply-To: <c6ef7709f9373651496b2a32ca42f571.squirrel@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-3-60295212
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 2 mrt 2009, om 21:56 heeft david.hagood@gmail.com het volgende  
geschreven:

> I'm trying to build the TI supplied Linux kernel driver modules for  
> the
> PowerVR accelerator chip in the OMAP3. I have a GIT tree pulled from  
> the
> linux-omap-2.6 tree, and a set of cross-compiler tools built and
> installed.

In OpenEmbedded we have patches to a) get it to compile b) pick up  
symbols so they actually insert and c) build against Tomi's DSS2

regards,

Koen

--Apple-Mail-3-60295212
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: Dit deel van het bericht is digitaal ondertekend
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFJrNz+MkyGM64RGpERAsWIAKC12pfGePnfyLWweR4ha+mq5tfD/wCaA3BH
dQqgVdA5tYnpxOwePpbgY3Q=
=Mr7s
-----END PGP SIGNATURE-----

--Apple-Mail-3-60295212--
