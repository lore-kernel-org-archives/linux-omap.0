From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: [PATCH] ARM: OMAP: armv7a Makefile: change -march flag to "armv7-a" so gcc 4.3.x works
Date: Mon, 16 Jun 2008 15:50:37 +0200
Message-ID: <47BEA242-E477-4E1C-B14A-BD2D76712CFF@student.utwente.nl>
References: <1213368351-10664-1-git-send-email-koen@openembedded.org> <20080616132531.GE8848@atomide.com>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp2.utsp.utwente.nl ([130.89.2.9]:44749 "EHLO smtp.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752614AbYFPPX1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Jun 2008 11:23:27 -0400
Received: from [10.0.11.46] (vestingbar.student.utwente.nl [130.89.119.192])
          by smtp.utwente.nl (8.12.10/SuSE Linux 0.7) with ESMTP id m5GFHMWC000512
          for <linux-omap@vger.kernel.org>; Mon, 16 Jun 2008 17:17:22 +0200
In-Reply-To: <20080616132531.GE8848@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Op 16 jun 2008, om 15:25 heeft Tony Lindgren het volgende geschreven:

> * Koen Kooi <koen@openembedded.org> [080613 17:48]:
>> armv7a Makefile: change -march flag to "armv7-a" so gcc 4.3.x  
>> works, "armv7a" is a CSL-ism. CSL compilers accept both variants.
>>
>> Tested with: gcc 4.2.4, 4.3.0, 4.3.1 and csl 2007q3, 2008q1
>
> Can you please post this to linux-arm-kernel@lists.arm.linux.org.uk
> mailing list?

Done

>
>
> Thanks,
>
> Tony
>
>>
>> Signed-off-by: Koen Kooi <koen@openembedded.org>
>> ---
>> arch/arm/Makefile |    2 +-
>> 1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
>> index 40a0b44..a3befbd 100644
>> --- a/arch/arm/Makefile
>> +++ b/arch/arm/Makefile
>> @@ -47,7 +47,7 @@ comma = ,
>> # Note that GCC does not numerically define an architecture version
>> # macro, but instead defines a whole series of macros which makes
>> # testing for a specific architecture or later rather impossible.
>> -arch-$(CONFIG_CPU_32v7)		:=-D__LINUX_ARM_ARCH__=7 $(call cc- 
>> option,-march=armv7a,-march=armv5t -Wa$(comma)-march=armv7a)
>> +arch-$(CONFIG_CPU_32v7)		:=-D__LINUX_ARM_ARCH__=7 $(call cc- 
>> option,-march=armv7-a,-march=armv5t -Wa$(comma)-march=armv7-a)
>> arch-$(CONFIG_CPU_32v6)		:=-D__LINUX_ARM_ARCH__=6 $(call cc-option,- 
>> march=armv6,-march=armv5t -Wa$(comma)-march=armv6)
>> # Only override the compiler option if ARMv6. The ARMv6K extensions  
>> are
>> # always available in ARMv7
>> -- 
>> 1.5.4.3
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux- 
>> omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFIVm+vMkyGM64RGpERAt1mAJ400FDTLIzjWaWiZv2dWT168gdL9QCdGoBB
u8JiNBxzKHzeOZ6NgkKFRMw=
=iy5d
-----END PGP SIGNATURE-----
