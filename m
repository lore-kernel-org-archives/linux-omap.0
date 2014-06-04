From: Roger Quadros <rogerq@ti.com>
Subject: Re: am335x: system doesn't reboot after flashing NAND
Date: Wed, 4 Jun 2014 11:48:55 +0300
Message-ID: <538EDD77.8070807@ti.com>
References: <CAGm1_kstgCEQRuaz836v7xg=DHVxpQ6VQPBzkORz1D=18fxp8w@mail.gmail.com> <CAGm1_kv7EmQ1MaXL0nhQcPZp53DjBLfdnTqFit9e0FT1J8zzug@mail.gmail.com> <538EBF54.7080709@ti.com> <CAGm1_ktWxQFQ0jWjn7A2NO8nPayY9S2McPrKHWbGRtkw1751ig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60998 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750853AbaFDIs6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 4 Jun 2014 04:48:58 -0400
In-Reply-To: <CAGm1_ktWxQFQ0jWjn7A2NO8nPayY9S2McPrKHWbGRtkw1751ig@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Yegor Yefremov <yegorslists@googlemail.com>, Sekhar Nori <nsekhar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gupta, Pekon" <pekon@ti.com>

Hi,

On 06/04/2014 11:25 AM, Yegor Yefremov wrote:
> On Wed, Jun 4, 2014 at 8:40 AM, Sekhar Nori <nsekhar@ti.com> wrote:
>> On Tuesday 03 June 2014 04:18 PM, Yegor Yefremov wrote:
>>> On Tue, Jun 3, 2014 at 9:57 AM, Yegor Yefremov
>>> <yegorslists@googlemail.com> wrote:
>>>> Kernel: 3.14, 3.15 (I haven't tried another kernels)
>>>>
>>>> As soon as I write something to my NAND flash (via cat image >
>>>> /dev/mtdblockx or ubiupdatevol) and make reboot or press a reset
>>>> button, I see only CCCCC and nothing happens before I make a power
>>>> cycle. Any idea?
>>>
>>> Just forgot to mention, that I was actually booting from MMC (mmc1).
>>> The boot sequence is UART0...XIP...MMC0...NAND.

Can you try to get XIP out of the boot sequence and see if it works?
Maybe try to boot from mmc directly?

This would prove that NAND/GPMC driver is leaving some state that doesn't
go well with the bootROM XIP.

cheers,
-roger

>>>
>>> If I just mount ubifs partition as rootfs and change some files, I
>>> still can perform reboot and boot from MMC again. The issue seems to
>>> occur only, if I write to /dev/mtdblock directly. What can affect ROM
>>> boot so that it doesn't follow the boot sequence?
>>
>> Writing to sysboot bits in control_status register will make ROM change
>> boot sequence. Not sure why NAND driver should be changing these values.
>> Can you please verify that this register is indeed modified after the
>> NAND write?
> 
> Can I read this register from userspace via debugfs? I can't find such
> entry so far.
> 
> I made another test: write to NAND and then make kexec. In this case I
> can successfully execute "reboot" afterwards.
> 
> Yegor
> 

