From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: [PATCH 1/1] ARM: OMAP: omap3beagle: register SD interface
Date: Tue, 22 Apr 2008 19:00:04 +0200
Message-ID: <E7D86ACF-575E-4A2B-8193-82A3A0B6FFCF@student.utwente.nl>
References: <3A21C48B-9730-4BB7-9095-B08510070F7D@student.utwente.nl> <7EAD1AEEA7621C45899FE99123E124A001922608@dbde01.ent.ti.com> <03879EA5-591C-4ED6-A3F5-8600F90CC8E7@student.utwente.nl> <200804220957.43599.david-b@pacbell.net>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx1.utsp.utwente.nl ([130.89.2.12]:51273 "EHLO mx.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755231AbYDVRAY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Apr 2008 13:00:24 -0400
In-Reply-To: <200804220957.43599.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: "Syed Mohammed, Khasim" <khasim@ti.com>, linux-omap@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Op 22 apr 2008, om 18:57 heeft David Brownell het volgende geschreven:
> On Tuesday 22 April 2008, Koen Kooi wrote:
>> --- a/include/asm-arm/arch-omap/board-omap3beagle.h
>> +++ b/include/asm-arm/arch-omap/board-omap3beagle.h
>> @@ -29,6 +29,8 @@
>>   #ifndef __ASM_ARCH_OMAP3_BEAGLE_H
>>   #define __ASM_ARCH_OMAP3_BEAGLE_H
>>
>> +extern void __init sdp_mmc_init(void);
>> +
>>   #ifdef CONFIG_TWL4030_CORE
>>
>>   #define TWL4030_IRQNUM                INT_34XX_SYS_NIRQ
>
> That's really not the right place to declare shared
> routines.  Plus of course, since that routine isn't
> specific to SDP boards it shouldn't use that name...

I picked a random spot, do you have a hint for a better one :)

regards,

Koen
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFIDhmWMkyGM64RGpERAqVeAJ9vtoCQZbYgloXdP7935zK8J+WwfgCfbUxN
rUvrS6dhBNKNLWLzzlUyeSk=
=Sahl
-----END PGP SIGNATURE-----
