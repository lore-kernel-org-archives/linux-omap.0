From: Gary Thomas <gary@mlbassoc.com>
Subject: Re: ARM tollchain support
Date: Tue, 15 Dec 2009 06:09:30 -0700
Message-ID: <4B278A8A.705@mlbassoc.com>
References: <4ad3b6300912150451k34f8367eg4141f80c79f66413@mail.gmail.com> <EAF47CD23C76F840A9E7FCE10091EFAB02BC2406DF@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hermes.mlbassoc.com ([76.76.67.137]:52610 "EHLO
	mail.chez-thomas.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759361AbZLONJb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Dec 2009 08:09:31 -0500
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02BC2406DF@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Niamathullah sharief <omapsha@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 12/15/2009 05:57 AM, Shilimkar, Santosh wrote:
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of
>> Niamathullah sharief
>> Sent: Tuesday, December 15, 2009 6:22 PM
>> To: linux-omap@vger.kernel.org
>> Subject: ARM tollchain support
>>
>> Hello,
>>      I am trying to install ARM tollchain in my GCC. But i am not
>> getting to install correctly. When i try to compile an u boot image i
>> am getting the following errors in last few lines ..
>>
>>
>> make[1]: Leaving directory `/home/ariem/Desktop/u-boot-200901-lange51/tools'
>> make -C examples all
>> make[1]: execvp: /home/ariem/CodeSourcery/Sourcery_G++_Lite/lib/gcc:
>> Permission denied
>> make[1]: Entering directory `/home/ariem/Desktop/u-boot-200901-lange51/examples'
>> /bin/sh: /home/ariem/CodeSourcery/Sourcery_G++_Lite/lib/gcc: is a directory
>> dirname: missing operand
>> Try `dirname --help' for more information.
>> /bin/sh: /home/ariem/CodeSourcery/Sourcery_G++_Lite/lib/gcc: is a directory
>> dirname: missing operand
>> Try `dirname --help' for more information.
>> /home/ariem/CodeSourcery/Sourcery_G++_Lite/lib/gcc  -Os
>> -fno-strict-aliasing -fno-common -ffixed-r8 -msoft-float
>> -D__KERNEL__ -DTEXT_BASE=0x97800000
>> -I/home/ariem/Desktop/u-boot-200901-lange51/include -fno-builtin
>> -ffreestanding -nostdinc -isystem  -pipe  -DCONFIG_ARM -D__ARM__
>> -Wall -Wstrict-prototypes  -c -o hello_world.o hello_world.c
>> make[1]: execvp: /home/ariem/CodeSourcery/Sourcery_G++_Lite/lib/gcc:
>> Permission denied
>> make[1]: *** [hello_world.o] Error 127
>> make[1]: Leaving directory `/home/ariem/Desktop/u-boot-200901-lange51/examples'
>> make: *** [examples] Error 2
>> ariem@ariem-desktop:~/Desktop/u-boot-200901-lange51$
>>
>>
>> what will be the error. can anyone tell me. i think the path exported
>> is wrong. please help me
> How are you exporting the path ? Can you copy paste that here

That's not the problem - the tools have not been installed properly.

It looks to me like Niamathullah sharief (I never know which name
is prominent) is trying to use tools installed by another user
(ariem).  I assume that 'sharief' does not have access to 'ariem's
home directory, thus this fails.

Get the tools installed into a common directory and this should start
working.


-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
