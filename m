From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: am335x: system doesn't reboot after flashing NAND
Date: Wed, 4 Jun 2014 12:10:20 +0530
Message-ID: <538EBF54.7080709@ti.com>
References: <CAGm1_kstgCEQRuaz836v7xg=DHVxpQ6VQPBzkORz1D=18fxp8w@mail.gmail.com> <CAGm1_kv7EmQ1MaXL0nhQcPZp53DjBLfdnTqFit9e0FT1J8zzug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57845 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754049AbaFDGkX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 4 Jun 2014 02:40:23 -0400
In-Reply-To: <CAGm1_kv7EmQ1MaXL0nhQcPZp53DjBLfdnTqFit9e0FT1J8zzug@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Yegor Yefremov <yegorslists@googlemail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: rogerq@ti.com, "Gupta, Pekon" <pekon@ti.com>

On Tuesday 03 June 2014 04:18 PM, Yegor Yefremov wrote:
> On Tue, Jun 3, 2014 at 9:57 AM, Yegor Yefremov
> <yegorslists@googlemail.com> wrote:
>> Kernel: 3.14, 3.15 (I haven't tried another kernels)
>>
>> As soon as I write something to my NAND flash (via cat image >
>> /dev/mtdblockx or ubiupdatevol) and make reboot or press a reset
>> button, I see only CCCCC and nothing happens before I make a power
>> cycle. Any idea?
> 
> Just forgot to mention, that I was actually booting from MMC (mmc1).
> The boot sequence is UART0...XIP...MMC0...NAND.
> 
> If I just mount ubifs partition as rootfs and change some files, I
> still can perform reboot and boot from MMC again. The issue seems to
> occur only, if I write to /dev/mtdblock directly. What can affect ROM
> boot so that it doesn't follow the boot sequence?

Writing to sysboot bits in control_status register will make ROM change
boot sequence. Not sure why NAND driver should be changing these values.
Can you please verify that this register is indeed modified after the
NAND write?

Thanks,
Sekhar
