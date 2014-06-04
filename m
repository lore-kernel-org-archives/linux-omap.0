From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re: am335x: system doesn't reboot after flashing NAND
Date: Wed, 4 Jun 2014 11:39:13 +0200
Message-ID: <CAGm1_kvxq+3-Fi6nCjkW01v0qaVj2wCJ=jjNe6yLJgAk0c_M5Q@mail.gmail.com>
References: <CAGm1_kstgCEQRuaz836v7xg=DHVxpQ6VQPBzkORz1D=18fxp8w@mail.gmail.com>
 <CAGm1_kv7EmQ1MaXL0nhQcPZp53DjBLfdnTqFit9e0FT1J8zzug@mail.gmail.com>
 <538EBF54.7080709@ti.com> <CAGm1_ktWxQFQ0jWjn7A2NO8nPayY9S2McPrKHWbGRtkw1751ig@mail.gmail.com>
 <538EDEAA.6040300@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:42432 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751332AbaFDJje (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Jun 2014 05:39:34 -0400
Received: by mail-pd0-f175.google.com with SMTP id z10so5876509pdj.34
        for <linux-omap@vger.kernel.org>; Wed, 04 Jun 2014 02:39:34 -0700 (PDT)
In-Reply-To: <538EDEAA.6040300@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, rogerq@ti.com, "Gupta, Pekon" <pekon@ti.com>

On Wed, Jun 4, 2014 at 10:54 AM, Sekhar Nori <nsekhar@ti.com> wrote:
> On Wednesday 04 June 2014 01:55 PM, Yegor Yefremov wrote:
>> On Wed, Jun 4, 2014 at 8:40 AM, Sekhar Nori <nsekhar@ti.com> wrote:
>>> On Tuesday 03 June 2014 04:18 PM, Yegor Yefremov wrote:
>>>> On Tue, Jun 3, 2014 at 9:57 AM, Yegor Yefremov
>>>> <yegorslists@googlemail.com> wrote:
>>>>> Kernel: 3.14, 3.15 (I haven't tried another kernels)
>>>>>
>>>>> As soon as I write something to my NAND flash (via cat image >
>>>>> /dev/mtdblockx or ubiupdatevol) and make reboot or press a reset
>>>>> button, I see only CCCCC and nothing happens before I make a power
>>>>> cycle. Any idea?
>>>>
>>>> Just forgot to mention, that I was actually booting from MMC (mmc1).
>>>> The boot sequence is UART0...XIP...MMC0...NAND.
>>>>
>>>> If I just mount ubifs partition as rootfs and change some files, I
>>>> still can perform reboot and boot from MMC again. The issue seems to
>>>> occur only, if I write to /dev/mtdblock directly. What can affect ROM
>>>> boot so that it doesn't follow the boot sequence?
>>>
>>> Writing to sysboot bits in control_status register will make ROM change
>>> boot sequence. Not sure why NAND driver should be changing these values.
>>> Can you please verify that this register is indeed modified after the
>>> NAND write?
>>
>> Can I read this register from userspace via debugfs? I can't find such
>> entry so far.
>
> If not debugfs you can use devmem2[1] to read from userspace. You need
> to provide physical address of the register.
>
>> I made another test: write to NAND and then make kexec. In this case I
>> can successfully execute "reboot" afterwards.
>
> Okay. We need to monitor how sysboot values are changing between these
> steps.

devmem from busybox seems to work better. At least it delivers real
values and not 0x0 as devmem2 does. Anyway the value doesn't change
and looks as configured via resistors:

# devmem 0x44E10040 32
0x00400304

I wonder, where can I issue NAND reset from userspace? This is one of
the commands the kernel does during the initialization.

Yegor
