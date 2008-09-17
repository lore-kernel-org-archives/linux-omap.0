From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: getting 2.6.25 from git to run on omap35x evm
Date: Wed, 17 Sep 2008 20:59:16 +0200
Message-ID: <ADBD1DC1-66B1-4EE2-92D8-051C5B91FC1C@student.utwente.nl>
References: <dbdb2ea60809171136v5a380989mf57aca6ff1df5aba@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-15-705104582"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.utsp.utwente.nl ([130.89.2.8]:33460 "EHLO smtp.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751634AbYIQTAU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Sep 2008 15:00:20 -0400
Received: from [172.20.1.5] (vpn006014.vpn.utwente.nl [130.89.6.14])
          by smtp.utwente.nl (8.12.10/SuSE Linux 0.7) with ESMTP id m8HIxIIp016292
          for <linux-omap@vger.kernel.org>; Wed, 17 Sep 2008 20:59:18 +0200
In-Reply-To: <dbdb2ea60809171136v5a380989mf57aca6ff1df5aba@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-15-705104582
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 17 sep 2008, om 20:36 heeft twebb het volgende geschreven:

> The OMAP35x EVM (from TI/Mistral) runs their SDK 1.0.0 which is based
> on linux-2.6.22.18.  I'm trying to get linux-2.6.25 (tag =
> v2.6.25-omap1 from linux-omap-2.6.git) running on the 35x EVM but
> having difficulties.  The linux-2.6.22.18 including support for OMAP
> 35x EVM appears quite different from linux-omap-2.6.25 from git in the
> OMAP specific areas.  Should linux-omap-2.6.25-v2.6.25-omap1 build and
> run without modifications on OMAP 35x EVM?  If so, I should be able to
> port SDK 1.0.0 functionality (that perhaps hasn't made it into the
> linux-omap git yet) over to newer 2.6.25 kernel as necessary -
> correct?  If not, is there another or newer kernel in linux-omap get
> that could/should run on 35x EVM, or is another approach suggested?

Why 2.6.25? Git has 2.6.26 already and currenly is at 2.6.27rc6, so  
why go from one obsolete version to another obsolete one? .27rc is  
pretty broken on the EVM atm, ut .26 should work fine.

regards,

Koen

--Apple-Mail-15-705104582
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFI0VOGMkyGM64RGpERAiMQAJ9MsVSbpC+RfMg/IJbNsK50sikJ/QCfVGFU
m+EgPcoiidvnQGeXBdJq4Co=
=oROw
-----END PGP SIGNATURE-----

--Apple-Mail-15-705104582--
