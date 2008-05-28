From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: [PATCH] Driver for omap34xx temperature sensor. second version.
Date: Thu, 29 May 2008 01:08:14 +0200
Message-ID: <B5748808-2B1B-4849-8324-844B4BF56F33@student.utwente.nl>
References: <20080519135629.GB5040@codecarver.research.nokia.com> <20080523104942.GB4976@codecarver.research.nokia.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx2.utsp.utwente.nl ([130.89.2.13]:42521 "EHLO mx.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754158AbYE1XIq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 May 2008 19:08:46 -0400
Received: from [172.20.1.5] (vpn006023.vpn.utwente.nl [130.89.6.23])
          by mx.utwente.nl (8.12.10/SuSE Linux 0.7) with ESMTP id m4SN8Ilg005614
          for <linux-omap@vger.kernel.org>; Thu, 29 May 2008 01:08:18 +0200
In-Reply-To: <20080523104942.GB4976@codecarver.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Op 23 mei 2008, om 12:49 heeft Peter 'p2' De Schrijver het volgende  
geschreven:

> Hi,
>
> This patch adds a hwmon driver for the OMAP34xx internal temperature
> sensor. I get unusually high values (80 degrees and more) from this
> sensor though.

Same high values here as well:

root@beagleboard:/sys/class/hwmon/hwmon0/device# cat temp1_input
96

does anyone from TI have a hint if the chip is really that hot, or  
that we need to scale the value?

regards,

Koen
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFIPeXiMkyGM64RGpERAu+fAJ46X1J6jgnW5IAEs/o8CwhqtxIfGgCeNWpC
RszRjwBZV1f/C1c+w6jmhDE=
=PhBJ
-----END PGP SIGNATURE-----
