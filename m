From: Arno Steffen <arno.steffen@googlemail.com>
Subject: Re: [Q] No message from Kernel (Howto start debug?)
Date: Mon, 1 Aug 2011 10:15:47 +0200
Message-ID: <CAACX+R39afQOJ4xy_54qBWphyVKghfoK0WzvEZxnb6iAyrpbJg@mail.gmail.com>
References: <CAACX+R297j07GXRtLBCFuSyHTmk4sMXQiUt8YwN7KH6A8251jA@mail.gmail.com>
	<20110728132629.GH9069@legolas.emea.dhcp.ti.com>
	<CAACX+R0-vUP1z9DoS69iv2gX=YCKanousEHATzot0sSi-S9cEQ@mail.gmail.com>
	<20110729094439.74156e05@myhost>
	<CAACX+R29sogiU3PkNf+doFEWewAqcsT6Hj4HTa10rk4+WR+5Dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:55374 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752698Ab1HAIPs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Aug 2011 04:15:48 -0400
Received: by iyb12 with SMTP id 12so6639507iyb.19
        for <linux-omap@vger.kernel.org>; Mon, 01 Aug 2011 01:15:47 -0700 (PDT)
In-Reply-To: <CAACX+R29sogiU3PkNf+doFEWewAqcsT6Hj4HTa10rk4+WR+5Dg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tapani Utriainen <tapani@technexion.com>, Sricharan R <r.sricharan@ti.com>
Cc: linux-omap@vger.kernel.org

2011/7/29 Arno Steffen <arno.steffen@googlemail.com>:
> 2011/7/29 Tapani Utriainen <tapani@technexion.com>:
>> On Thu, 28 Jul 2011 16:18:51 +0200
>> Arno Steffen <arno.steffen@googlemail.com> wrote:
>>
>>> That has been good points. I've tried both, but with no result so far.
>>>
>>
>> Try appending earlyprintk=${console} to your bootargs (where ${console}
>> is your console string, e.g. ttyO0,115200n8 )
>>
>> ---
>> Tapani Utriainen, PhD
>> Senior Software Engineer
>> TechNexion Ltd, www.technexion.com
>>
>>
>
> Tried this without a change. I really think this is a machine-id problem.
> So although I have done same changes for my board as in my previous 33
> kernel, it might be not enough to cover the machine-id. Maybe I can
> overule this for test to find out the source of this misbehaviour.
> The problem is already before the first debug messages are coming.
> Sricharan is right, first the message uncompress has to be printed.
> Thanks
> - Arno
>

Did some test. So with old I can always see the message "Uncompressing
Linux... done, booting the kernel."
Even if machine-id is not match or if bootargs are wrong regarding ttyS/ttyO.
With new kernel I can't see this message. So the question: Is
something changes there in uncompressing?
I am also a bit confused that I get this:

## Booting kernel from Legacy Image at 80000000 ...
   Image Name:   Linux-2.6.33
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    1505256 Bytes = 1.4 MiB
   Load Address: 80008000
   Entry Point:  80008000
   Verifying Checksum ... OK
   Loading Kernel Image ... OK
OK

and the kernel still has to be uncompressed?
- Arno
