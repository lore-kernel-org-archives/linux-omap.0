From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: Build error in torvalds kernel 3.11 for omap2plus
Date: Mon, 09 Sep 2013 04:30:06 -0700
Message-ID: <522DB13E.7070901@roeck-us.net>
References: <CABYxbz7m4GdHFNY3fP1Cpv3a_dNTSozdd7dX9yLG6vQ3zZxu9A@mail.gmail.com> <20130908090206.GK25647@n2100.arm.linux.org.uk> <522CB0DE.2010102@roeck-us.net> <CABYxbz4rY5LiVruX=YUAFeaRaODC575YYTctaQ=Oezox29GoEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:61951 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751518Ab3IILaK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Sep 2013 07:30:10 -0400
In-Reply-To: <CABYxbz4rY5LiVruX=YUAFeaRaODC575YYTctaQ=Oezox29GoEg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anil Kumar <anilk4.v@gmail.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Benoit Cousson <b-cousson@ti.com>

On 09/09/2013 03:55 AM, Anil Kumar wrote:
> Hi Guenter,
>
> On Sun, Sep 8, 2013 at 10:46 PM, Guenter Roeck <linux@roeck-us.net> wrote:
>> On 09/08/2013 02:02 AM, Russell King - ARM Linux wrote:
>>>
>>> On Sun, Sep 08, 2013 at 11:34:10AM +0530, Anil Kumar wrote:
>>>>
>>>> scripts/kconfig/conf --silentoldconfig Kconfig
>>>>     CHK     include/generated/uapi/linux/version.h
>>>>     CHK     include/generated/utsrelease.h
>>>> make[1]: `include/generated/mach-types.h' is up to date.
>>>>     CALL    scripts/checksyscalls.sh
>>>>     CHK     include/generated/compile.h
>>>>     AS      arch/arm/mm/cache-v7.o
>>>> arch/arm/mm/cache-v7.S: Assembler messages:
>>>> arch/arm/mm/cache-v7.S:285: Error: garbage following instruction -- `dsb
>>>> ishst'
>>>> arch/arm/mm/cache-v7.S:297: Error: garbage following instruction -- `dsb
>>>> ishst'
>>>> make[1]: *** [arch/arm/mm/cache-v7.o] Error 1
>>>> make: *** [arch/arm/mm] Error 2
>>>
>>>
>>> You need a later binutils for these instructions - 2.22 works just fine,
>>> even with gcc 4.5.x.
>>
>>
>> Since we are at it:
>>
>> Build reference: v3.11-7887-gb409624
>>
>> Building arm:defconfig ... passed
>> Building arm:allmodconfig ... failed
>> --------------
>> Error log:
>> arch/arm/mach-cns3xxx/pcie.c: In function 'cns3xxx_pcie_hw_init':
>> arch/arm/mach-cns3xxx/pcie.c:350:1: warning: the frame size of 1064 bytes is
>> larger than 1024 bytes [-Wframe-larger-than=]
>> arch/arm/kernel/return_address.c:63:2: warning: #warning "TODO:
>> return_address should use unwind tables" [-Wcpp]
>> arch/arm/kernel/return_address.c:63:2: warning: #warning "TODO:
>> return_address should use unwind tables" [-Wcpp]
>> /tmp/cce439dZ.s: Assembler messages:
>> /tmp/cce439dZ.s:506: Error: selected processor does not support ARM mode
>> `isb '
>> /tmp/cce439dZ.s:512: Error: selected processor does not support ARM mode
>> `isb '
>> /tmp/cce439dZ.s:513: Error: selected processor does not support ARM mode
>> `dsb '
>> /tmp/cce439dZ.s:583: Error: selected processor does not support ARM mode
>> `isb '
>> /tmp/cce439dZ.s:589: Error: selected processor does not support ARM mode
>> `isb '
>> /tmp/cce439dZ.s:590: Error: selected processor does not support ARM mode
>> `dsb '
>> make[1]: *** [arch/arm/mach-vexpress/dcscb.o] Error 1
>> make: *** [arch/arm/mach-vexpress] Error 2
>> make: *** Waiting for unfinished jobs....
>> --------------
>>
>> Any solution for this one ? omap2plus passes for me.
>
> I have updated my toolchain Assembler (used binutils 2.22 ) with
> latest one and issue has fixed.
>

Not for this build. As I said, the omap2plus build passes for me.
My binutils version is "2.23.1.20121113".

Did you try to build the file after "make allmodconfig" ?

Guenter

