From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re: omap:am335x: unable to start kernel via kexec
Date: Wed, 21 May 2014 15:19:39 +0200
Message-ID: <CAGm1_ks2PCeoNRRcuOStEOMcLBDeVn1mq5QeYF7KfLUKW3KG_g@mail.gmail.com>
References: <CAGm1_ksYHbdWLxBUt3QetkmKLF-fegEGgYO=mt3t44ApwEJiMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:45938 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752384AbaEUNUB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 May 2014 09:20:01 -0400
Received: by mail-la0-f41.google.com with SMTP id e16so1583565lan.0
        for <linux-omap@vger.kernel.org>; Wed, 21 May 2014 06:19:59 -0700 (PDT)
In-Reply-To: <CAGm1_ksYHbdWLxBUt3QetkmKLF-fegEGgYO=mt3t44ApwEJiMA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: wangnan0@huawei.com
Cc: kexec <kexec@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, May 21, 2014 at 12:26 PM, Yegor Yefremov
<yegorslists@googlemail.com> wrote:
> Kernel: vanilla 3.15-rc5
> kexec: latest git (21.05.2014)
>
> I can load the zImage + dtb from u-boot, but invoking kexec prints
> following data and nothing happens after "Bye!":
>
> # kexec -d -f --dtb=/mnt/boot/am335x-evmsk.dtb /mnt/boot/zImage
> kernel: 0xb5eab008 kernel_size: 0x2036c
> kexec_load: entry = 0x80008000 flags = 0x280000
> nr_segments = 2
> segment[0].buf   = 0xb5eab008
> segment[0].bufsz = 0x43d328
> segment[0].mem   = 0x80008000
> segment[0].memsz = 0x43e000
> segment[1].buf   = 0x29008
> segment[1].bufsz = 0x7e89
> segment[1].mem   = 0x810f6000
> segment[1].memsz = 0x8000
> Starting new kernel
> Bye!
>
> u-boot output for the same kernel+dtb:
>
> SD/MMC found on device 0
> reading uEnv.txt
> 582 bytes read in 8 ms (70.3 KiB/s)
> Loaded environment from uEnv.txt
> Importing environment from mmc ...
> Running uenvcmd ...
> 4444968 bytes read in 466 ms (9.1 MiB/s)
> 32393 bytes read in 46 ms (687.5 KiB/s)
> Kernel image @ 0x82000000 [ 0x000000 - 0x43d328 ]
> ## Flattened Device Tree blob at 80000000
>    Booting using the fdt blob at 0x80000000
>    Loading Device Tree to 8f618000, end 8f622e88 ... OK
>
> Wang, what hardware do you use?

Everything is working now. I think it has something to do with wrong
kernel parameters. Sorry for the noise.

FIT support can be undertaken.

Regards,
Yegor
