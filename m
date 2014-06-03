From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re: am335x: system doesn't reboot after flashing NAND
Date: Tue, 3 Jun 2014 12:48:35 +0200
Message-ID: <CAGm1_kv7EmQ1MaXL0nhQcPZp53DjBLfdnTqFit9e0FT1J8zzug@mail.gmail.com>
References: <CAGm1_kstgCEQRuaz836v7xg=DHVxpQ6VQPBzkORz1D=18fxp8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f48.google.com ([209.85.160.48]:64106 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752891AbaFCKs4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Jun 2014 06:48:56 -0400
Received: by mail-pb0-f48.google.com with SMTP id rr13so5369045pbb.21
        for <linux-omap@vger.kernel.org>; Tue, 03 Jun 2014 03:48:55 -0700 (PDT)
In-Reply-To: <CAGm1_kstgCEQRuaz836v7xg=DHVxpQ6VQPBzkORz1D=18fxp8w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: rogerq@ti.com

On Tue, Jun 3, 2014 at 9:57 AM, Yegor Yefremov
<yegorslists@googlemail.com> wrote:
> Kernel: 3.14, 3.15 (I haven't tried another kernels)
>
> As soon as I write something to my NAND flash (via cat image >
> /dev/mtdblockx or ubiupdatevol) and make reboot or press a reset
> button, I see only CCCCC and nothing happens before I make a power
> cycle. Any idea?

Just forgot to mention, that I was actually booting from MMC (mmc1).
The boot sequence is UART0...XIP...MMC0...NAND.

If I just mount ubifs partition as rootfs and change some files, I
still can perform reboot and boot from MMC again. The issue seems to
occur only, if I write to /dev/mtdblock directly. What can affect ROM
boot so that it doesn't follow the boot sequence?

Yegor
