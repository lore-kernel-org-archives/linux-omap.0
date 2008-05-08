From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: TWL4030 intermittent freakout on boot
Date: Thu, 8 May 2008 20:20:43 +0200
Message-ID: <EF9B9E21-ACCB-46A7-94C7-1FB6DD58B093@student.utwente.nl>
References: <alpine.DEB.1.00.0805081201450.27986@utopia.booyaka.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp2.utsp.utwente.nl ([130.89.2.9]:38687 "EHLO smtp.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751213AbYEHSVv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 May 2008 14:21:51 -0400
In-Reply-To: <alpine.DEB.1.00.0805081201450.27986@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, felipe.balbi@nokia.com, peter.de-schrijver@nokia.com, Beagle Board <beagleboard@googlegroups.com>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Op 8 mei 2008, om 20:13 heeft Paul Walmsley het volgende geschreven:
>
> Hello everyone,
>
> occasionally the TWL4030 driver on the 3430SDP freaks out on boot.   
> (This
> is either an ES2.0 or ES2.1, not sure.)  Here's a partial console  
> log with
> initcall debugging enabled.  This probably happens every thirty or  
> forty
> boots, I would guess.  The board does boot to userspace when this  
> happens.
>
> Perhaps the TWL4030 experts out there might know what's going on?
>
> <3>i2c_omap i2c_omap.1: controller timed out
> <3>i2c_omap i2c_omap.1: controller timed out
> <3>twl4030_usb: i2c write failed, line 422

Looks suspiciously like the symptons in

http://code.google.com/p/beagleboard/issues/detail?id=14

regards,

Koen
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFII0R9MkyGM64RGpERAkZFAKC1LiEAK3DcBwzasa3yE2cLr/MLxgCgprDi
ABlwZjvXIM0UTP8dMCd1s44=
=BbS2
-----END PGP SIGNATURE-----
