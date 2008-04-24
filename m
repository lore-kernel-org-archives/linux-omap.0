From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: [PATCH 1/1] ARM: OMAP: omap3beagle: register SD interface
Date: Thu, 24 Apr 2008 23:01:25 +0200
Message-ID: <94B0FFAD-7AB5-4B17-9FA6-79AD73E3CEBF@student.utwente.nl>
References: <3A21C48B-9730-4BB7-9095-B08510070F7D@student.utwente.nl> <7EAD1AEEA7621C45899FE99123E124A001922608@dbde01.ent.ti.com> <03879EA5-591C-4ED6-A3F5-8600F90CC8E7@student.utwente.nl> <200804220957.43599.david-b@pacbell.net> <E7D86ACF-575E-4A2B-8193-82A3A0B6FFCF@student.utwente.nl> <20080422170758.GB10347@kedavra.cpe.vivax.com.br> <BF39A517-6A64-4B10-B595-CBBF2F6BF5D0@student.utwente.nl> <20080424002120.GE27546@atomide.com> <372691CB-3FF8-43FE-9E0D-F771DD8996FE@student.utwente.nl> <20080424200023.GH16834@atomide.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.utsp.utwente.nl ([130.89.2.8]:55386 "EHLO smtp.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751282AbYDXVCA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Apr 2008 17:02:00 -0400
Received: from [172.20.1.5] (vpn006030.vpn.utwente.nl [130.89.6.30])
          by smtp.utwente.nl (8.12.10/SuSE Linux 0.7) with ESMTP id m3OL1RZk018434
          for <linux-omap@vger.kernel.org>; Thu, 24 Apr 2008 23:01:27 +0200
In-Reply-To: <20080424200023.GH16834@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Op 24 apr 2008, om 22:00 heeft Tony Lindgren het volgende geschreven:
> * Koen Kooi <k.kooi@student.utwente.nl> [080424 12:54]:
>>
>> Op 24 apr 2008, om 02:21 heeft Tony Lindgren het volgende geschreven:
>>> Hi,
>>>
>>> * Koen Kooi <k.kooi@student.utwente.nl> [080423 00:42]:
>>>> From dac3cdc5952ab39fa7ae0545d43e2daa95329b07 Mon Sep 17 00:00:00
>>>> 2001
>>>> From: Koen Kooi <koen@openembedded.org>
>>>> Date: Wed, 23 Apr 2008 09:38:31 +0200
>>>> Subject: [PATCH] omap3beagle: register SD interface
>>>
>>> Thanks for updating it. I've pushed it now, but I had to apply some
>>> parts manually because of recent changes. Can you please check it
>>> got applied OK?
>>
>> I compiled an booted latest git and see this:
>>
>> 6>TWL4030: TRY attach Slave TWL4030-ID1 on Adapter OMAP I2C adapter  
>> [1]
>> <1>Unable to handle kernel NULL pointer dereference at virtual  
>> address
>> 00000000
>> <1>pgd = c0004000
>> <1>[00000000] *pgd=00000000
>> Internal error: Oops: 5 [#1]
>> Modules linked in:
>> CPU: 0    Not tainted  (2.6.25-omap1 #11)
>> PC is at __rcu_process_callbacks+0x1ac/0x244
>> LR is at free_task+0x38/0x40
>> pc : [<c0073924>]    lr : [<c0048b04>]    psr: 80000113
>> sp : c7c1dda8  ip : c7c085c0  fp : c7c1ddc4
>> r10: 00000000  r9 : c0405678  r8 : 00000001
>> r7 : c0400d80  r6 : 00000005  r5 : 00000000  r4 : c040563c
>> r3 : 00000000  r2 : 00000027  r1 : c7c78340  r0 : c7c085c0
>> Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
>> Control: 00c5387f  Table: 80004018  DAC: 00000017
>> Process swapper (pid: 1, stack limit = 0xc7c1c2e0)
>>
>> More bootlogs at http://amethyst.openembedded.net/~koen/beagleboard/beagle-i2c-crash.txt
>>
>> I suspect it's somewhere in i2c, but I have no proof for that. Any
>> quick guesses what might be causing this?
>
> Can you try if reverting following helps?
>
> http://source.mvista.com/git/gitweb.cgi?p=linux-omap-2.6.git;a=commitdiff;h=38c50a71591628c38206aa402500074a6137a4dc

That doesn't seem to make a difference.

regards,

Koen
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFIEPUnMkyGM64RGpERAgO8AJ4l8t+4daVTVsDUVKxQ6sU7tpG+JQCfeqpf
TUDPkP0LNE8sPOOqumMMnGI=
=fL1j
-----END PGP SIGNATURE-----
