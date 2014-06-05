From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re: am335x: system doesn't reboot after flashing NAND
Date: Thu, 5 Jun 2014 12:07:53 +0200
Message-ID: <CAGm1_ktfN+whCNAStC=sx_6PrH9EJNVe67xK1xdTkGMNjcTwJg@mail.gmail.com>
References: <CAGm1_kstgCEQRuaz836v7xg=DHVxpQ6VQPBzkORz1D=18fxp8w@mail.gmail.com>
 <CAGm1_kv7EmQ1MaXL0nhQcPZp53DjBLfdnTqFit9e0FT1J8zzug@mail.gmail.com>
 <538EBF54.7080709@ti.com> <CAGm1_ktWxQFQ0jWjn7A2NO8nPayY9S2McPrKHWbGRtkw1751ig@mail.gmail.com>
 <538EDD77.8070807@ti.com> <CAGm1_kt7BZ7RcbPd51QXhXxQV4SRzeXLzKW43wqK5UnPbYoHBw@mail.gmail.com>
 <538EF2EF.4050709@ti.com> <CAGm1_ksofkCNB1R9kg6L9FBFFPoE=62AZ1Vid4_n7DEu1oi4GQ@mail.gmail.com>
 <538EFA70.4040102@ti.com> <CAGm1_ktjgSnQmBPDVUf_6kWjZDJ3WKQv=5QMWmqWqP-XRp7k2Q@mail.gmail.com>
 <53904038.8010200@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:53630 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750925AbaFEKIO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Jun 2014 06:08:14 -0400
Received: by mail-pd0-f173.google.com with SMTP id v10so883684pde.4
        for <linux-omap@vger.kernel.org>; Thu, 05 Jun 2014 03:08:13 -0700 (PDT)
In-Reply-To: <53904038.8010200@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: Sekhar Nori <nsekhar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gupta, Pekon" <pekon@ti.com>

On Thu, Jun 5, 2014 at 12:02 PM, Roger Quadros <rogerq@ti.com> wrote:
> On 06/04/2014 10:45 PM, Yegor Yefremov wrote:
>> On Wed, Jun 4, 2014 at 12:52 PM, Sekhar Nori <nsekhar@ti.com> wrote:
>>> On Wednesday 04 June 2014 04:00 PM, Yegor Yefremov wrote:
>>>> On Wed, Jun 4, 2014 at 12:20 PM, Sekhar Nori <nsekhar@ti.com> wrote:
>>>>> On Wednesday 04 June 2014 03:11 PM, Yegor Yefremov wrote:
>>>>>> On Wed, Jun 4, 2014 at 10:48 AM, Roger Quadros <rogerq@ti.com> wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> On 06/04/2014 11:25 AM, Yegor Yefremov wrote:
>>>>>>>> On Wed, Jun 4, 2014 at 8:40 AM, Sekhar Nori <nsekhar@ti.com> wrote:
>>>>>>>>> On Tuesday 03 June 2014 04:18 PM, Yegor Yefremov wrote:
>>>>>>>>>> On Tue, Jun 3, 2014 at 9:57 AM, Yegor Yefremov
>>>>>>>>>> <yegorslists@googlemail.com> wrote:
>>>>>>>>>>> Kernel: 3.14, 3.15 (I haven't tried another kernels)
>>>>>>>>>>>
>>>>>>>>>>> As soon as I write something to my NAND flash (via cat image >
>>>>>>>>>>> /dev/mtdblockx or ubiupdatevol) and make reboot or press a reset
>>>>>>>>>>> button, I see only CCCCC and nothing happens before I make a power
>>>>>>>>>>> cycle. Any idea?
>>>>>>>>>>
>>>>>>>>>> Just forgot to mention, that I was actually booting from MMC (mmc1).
>>>>>>>>>> The boot sequence is UART0...XIP...MMC0...NAND.
>>>>>>>
>>>>>>> Can you try to get XIP out of the boot sequence and see if it works?
>>>>>>> Maybe try to boot from mmc directly?
>>>>>>>
>>>>>>> This would prove that NAND/GPMC driver is leaving some state that doesn't
>>>>>>> go well with the bootROM XIP.
>>>>>>
>>>>>> This configuration is soldered. It won't be easy to change.
>>>>>
>>>>> Most likely XIP is the issue if sysboot has not changed.
>>>>>
>>>>> The way ROM works for XIP boot is:
>>>>>
>>>>> 1) Set chip select 0 base address to 0x0800'0000
>>>>> 2) Read memory at 0x0800'0000
>>>>> 3) If something else other than 0x0 or ~0x0 is found, jump to
>>>>> 0x0800'0000 and start executing.
>>>>>
>>>>> Can you check to see the contents of 0x0800'0000 before and after nand
>>>>> write using mtdblock?
>>>>
>>>> Before writing:
>>>>
>>>> # devmem 0x08000000 32
>>>> 0xFFFFFFFF
>>>>
>>>> After writing:
>>>>
>>>> # devmem 0x08000000 32
>>>> 0xE0E0E0E0
>>>
>>> Okay, so this is the cause of failure to boot. I am not sure what
>>> operation by NAND driver causes this value to change. Perhaps you could
>>> bisect a bit by dumping this address at various points during the write
>>> operation?
>>>
>>> If you have a debugger it will become easy to do this.
>>
>> The 0x80000000 address seems to be the beginning of NAND region:
>>
>> ranges = <0 0 0x08000000 0x10000000>;   /* CS0: NAND */
>>
>> I've taken this example from am335x_evm.dts. I have tried to change
>> the mapping to 0x90000000, but kernel still uses 0x80000000, Where in
>> the kernel will "ranges" be evaluated? I'm digging thorugh
>> arch/arm/mach-omap2/gpmc.c and gpmc-nand.c, but didn't really found
>> the place.
>
> Well it doesn't. It just uses whatever was setup by the bootloader or
> randomly allocated by gpmc_cs_request().
>
> I'm working on fixing this up. I should be posting v2 of the GPMC refactor
> series by this week and you should be able to map the CS region as specified
> in the DT.
>
> Till then, maybe you can pre-configure CS0 in the bootloader to wherever you want
> or alternatively call gpmc_cs_remap() after the gpmc_cs_request() in gpmc_nand_init();

I've found the stuff in bootloader and mapped NAND to 0x09000000, but
it didn't help.

Yegor
