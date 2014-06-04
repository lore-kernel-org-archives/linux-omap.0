From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: am335x: system doesn't reboot after flashing NAND
Date: Wed, 4 Jun 2014 15:50:31 +0530
Message-ID: <538EF2EF.4050709@ti.com>
References: <CAGm1_kstgCEQRuaz836v7xg=DHVxpQ6VQPBzkORz1D=18fxp8w@mail.gmail.com> <CAGm1_kv7EmQ1MaXL0nhQcPZp53DjBLfdnTqFit9e0FT1J8zzug@mail.gmail.com> <538EBF54.7080709@ti.com> <CAGm1_ktWxQFQ0jWjn7A2NO8nPayY9S2McPrKHWbGRtkw1751ig@mail.gmail.com> <538EDD77.8070807@ti.com> <CAGm1_kt7BZ7RcbPd51QXhXxQV4SRzeXLzKW43wqK5UnPbYoHBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38132 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751728AbaFDKUe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 4 Jun 2014 06:20:34 -0400
In-Reply-To: <CAGm1_kt7BZ7RcbPd51QXhXxQV4SRzeXLzKW43wqK5UnPbYoHBw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Yegor Yefremov <yegorslists@googlemail.com>, Roger Quadros <rogerq@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gupta, Pekon" <pekon@ti.com>

On Wednesday 04 June 2014 03:11 PM, Yegor Yefremov wrote:
> On Wed, Jun 4, 2014 at 10:48 AM, Roger Quadros <rogerq@ti.com> wrote:
>> Hi,
>>
>> On 06/04/2014 11:25 AM, Yegor Yefremov wrote:
>>> On Wed, Jun 4, 2014 at 8:40 AM, Sekhar Nori <nsekhar@ti.com> wrote:
>>>> On Tuesday 03 June 2014 04:18 PM, Yegor Yefremov wrote:
>>>>> On Tue, Jun 3, 2014 at 9:57 AM, Yegor Yefremov
>>>>> <yegorslists@googlemail.com> wrote:
>>>>>> Kernel: 3.14, 3.15 (I haven't tried another kernels)
>>>>>>
>>>>>> As soon as I write something to my NAND flash (via cat image >
>>>>>> /dev/mtdblockx or ubiupdatevol) and make reboot or press a reset
>>>>>> button, I see only CCCCC and nothing happens before I make a power
>>>>>> cycle. Any idea?
>>>>>
>>>>> Just forgot to mention, that I was actually booting from MMC (mmc1).
>>>>> The boot sequence is UART0...XIP...MMC0...NAND.
>>
>> Can you try to get XIP out of the boot sequence and see if it works?
>> Maybe try to boot from mmc directly?
>>
>> This would prove that NAND/GPMC driver is leaving some state that doesn't
>> go well with the bootROM XIP.
> 
> This configuration is soldered. It won't be easy to change.

Most likely XIP is the issue if sysboot has not changed.

The way ROM works for XIP boot is:

1) Set chip select 0 base address to 0x0800'0000
2) Read memory at 0x0800'0000
3) If something else other than 0x0 or ~0x0 is found, jump to
0x0800'0000 and start executing.

Can you check to see the contents of 0x0800'0000 before and after nand
write using mtdblock?

Thanks,
Sekhar


