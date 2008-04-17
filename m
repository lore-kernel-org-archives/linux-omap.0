From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: [PATCH 2/2] Add usb support to omap3beagle
Date: Thu, 17 Apr 2008 20:57:56 +0200
Message-ID: <7F9BB0C5-23DD-4F44-904C-EF3F70324421@student.utwente.nl>
References: <CE83D2E2-7DC8-471C-AD14-14A6FED413A9@student.utwente.nl> <200804171126.54874.david-b@pacbell.net>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.utsp.utwente.nl ([130.89.2.8]:55133 "EHLO smtp.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750891AbYDQTFE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Apr 2008 15:05:04 -0400
Received: from [172.20.1.5] (vpn006106.vpn.utwente.nl [130.89.6.106])
          by smtp.utwente.nl (8.12.10/SuSE Linux 0.7) with ESMTP id m3HIvwZk020841
          for <linux-omap@vger.kernel.org>; Thu, 17 Apr 2008 20:57:58 +0200
In-Reply-To: <200804171126.54874.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Op 17 apr 2008, om 20:26 heeft David Brownell het volgende geschreven:
> On Thursday 17 April 2008, Koen Kooi wrote:
>>
>> @@ -69,6 +70,7 @@
>> 	omap_board_config_size = ARRAY_SIZE(omap3_beagle_config);
>> 	omap_serial_init();
>> 	sdp_mmc_init();
>> +	sdp3430_usb_init();
>> }
>>
>> arch_initcall(omap3_beagle_i2c_init);
>
> I hope someone makes those sdp_*() routines generic ... or does
> "SDP" not stand for "Software Development Platform" (different board)?

Those routines are indeed name after the sdp board, but they seem  
generic enough to get reused in other boards (e.g. omap3evm or omap3  
beagle) without change :)

regards,

Koen
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFIB522MkyGM64RGpERAqmvAKC8ASHDj63mcwe5bsa2X8OiOUpgAQCfdcZl
6RL3JX4fBhN4NK3rh3XOhTg=
=/Erq
-----END PGP SIGNATURE-----
