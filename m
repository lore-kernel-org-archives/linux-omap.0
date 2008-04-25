From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 1/1] ARM: OMAP: omap3beagle: register SD interface
Date: Fri, 25 Apr 2008 05:52:07 -0500
Message-ID: <a36ff0fb4439c66a79f59a2dc4632e84@felipebalbi.com>
References: <3A21C48B-9730-4BB7-9095-B08510070F7D@student.utwente.nl> <7EAD1AEEA7621C45899FE99123E124A001922608@dbde01.ent.ti.com> <03879EA5-591C-4ED6-A3F5-8600F90CC8E7@student.utwente.nl> <200804220957.43599.david-b@pacbell.net> <E7D86ACF-575E-4A2B-8193-82A3A0B6FFCF@student.utwente.nl> <20080422170758.GB10347@kedavra.cpe.vivax.com.br> <BF39A517-6A64-4B10-B595-CBBF2F6BF5D0@student.utwente.nl> <20080424002120.GE27546@atomide.com> <372691CB-3FF8-43FE-9E0D-F771DD8996FE@student.utwente.nl> <20080424200023.GH16834@atomide.com> <94B0FFAD-7AB5-4B17-9FA6-79AD73E3CEBF@student.utwente.nl> <4811848F.70803@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:59896 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751333AbYDYKwJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Apr 2008 06:52:09 -0400
In-Reply-To: <4811848F.70803@googlemail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: Koen Kooi <k.kooi@student.utwente.nl>, linux-omap@vger.kernel.org



On Fri, 25 Apr 2008 09:13:19 +0200, Dirk Behme <dirk.behme@googlemail.com>
wrote:
> Koen Kooi wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>>
>> Op 24 apr 2008, om 22:00 heeft Tony Lindgren het volgende geschreven:
>>
>>> * Koen Kooi <k.kooi@student.utwente.nl> [080424 12:54]:
>>>
>>>>
>>>> Op 24 apr 2008, om 02:21 heeft Tony Lindgren het volgende geschreven:
>>>>
>>>>> Hi,
>>>>>
>>>>> * Koen Kooi <k.kooi@student.utwente.nl> [080423 00:42]:
>>>>>
>>>>>> From dac3cdc5952ab39fa7ae0545d43e2daa95329b07 Mon Sep 17 00:00:00
>>>>>> 2001
>>>>>> From: Koen Kooi <koen@openembedded.org>
>>>>>> Date: Wed, 23 Apr 2008 09:38:31 +0200
>>>>>> Subject: [PATCH] omap3beagle: register SD interface
>>>>>
>>>>>
>>>>> Thanks for updating it. I've pushed it now, but I had to apply some
>>>>> parts manually because of recent changes. Can you please check it
>>>>> got applied OK?
>>>>
>>>>
>>>> I compiled an booted latest git and see this:
>>>>
>>>> 6>TWL4030: TRY attach Slave TWL4030-ID1 on Adapter OMAP I2C adapter 
> [1]
>>>> <1>Unable to handle kernel NULL pointer dereference at virtual 
> address
>>>> 00000000
>>>> <1>pgd = c0004000
>>>> <1>[00000000] *pgd=00000000
>>>> Internal error: Oops: 5 [#1]
>>>> Modules linked in:
>>>> CPU: 0    Not tainted  (2.6.25-omap1 #11)
>>>> PC is at __rcu_process_callbacks+0x1ac/0x244
>>>> LR is at free_task+0x38/0x40
>>>> pc : [<c0073924>]    lr : [<c0048b04>]    psr: 80000113
>>>> sp : c7c1dda8  ip : c7c085c0  fp : c7c1ddc4
>>>> r10: 00000000  r9 : c0405678  r8 : 00000001
>>>> r7 : c0400d80  r6 : 00000005  r5 : 00000000  r4 : c040563c
>>>> r3 : 00000000  r2 : 00000027  r1 : c7c78340  r0 : c7c085c0
>>>> Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
>>>> Control: 00c5387f  Table: 80004018  DAC: 00000017
>>>> Process swapper (pid: 1, stack limit = 0xc7c1c2e0)
>>>>
>>>> More bootlogs at
>>>>
> http://amethyst.openembedded.net/~koen/beagleboard/beagle-i2c-crash.txt
>>>>
>>>> I suspect it's somewhere in i2c, but I have no proof for that. Any
>>>> quick guesses what might be causing this?
>>>
>>>
>>> Can you try if reverting following helps?
>>>
>>>
>
http://source.mvista.com/git/gitweb.cgi?p=linux-omap-2.6.git;a=commitdiff;h=38c50a71591628c38206aa402500074a6137a4dc
>>>
>>
>> That doesn't seem to make a difference.
> 
> Just tried recent OMAP git with "gcc version 4.2.3 (Sourcery G++ Lite
> 2008q1-126)" (download from today). With configuration in attachment
> it boots fine:
> 
> -- cut --
> ...
> USB: No board-specific platform config found
> i2c_omap i2c_omap.1: bus 1 rev3.12 at 2600 kHz
> i2c_omap i2c_omap.2: bus 2 rev3.12 at 400 kHz
> i2c_omap i2c_omap.3: bus 3 rev3.12 at 400 kHz
> TWL4030: TRY attach Slave TWL4030-ID0 on Adapter OMAP I2C adapter [1]
> TWL4030: TRY attach Slave TWL4030-ID1 on Adapter OMAP I2C adapter [1]
> TWL4030: TRY attach Slave TWL4030-ID2 on Adapter OMAP I2C adapter [1]
> TWL4030: TRY attach Slave TWL4030-ID3 on Adapter OMAP I2C adapter [1]

but still some problems in twl4030 driver, you see:

> i2c_omap i2c_omap.1: Transmit overflow
> Unable to register interrupt subsystem[-5][748]
> Trying to install chained interrupt handler for IRQ373
> Initialized TWL4030 USB module
> SCSI subsystem initialized
> NET: Registered protocol family 2
> ...
> -- cut --
> 
> No patches applied, only switched from arm-linux- to
> arm-none-linux-gnueabi- in main Makefile.
> 
> Dirk
-- 
Best Regards,

Felipe Balbi
http://felipebalbi.com
me@felipebalbi.com

