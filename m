From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: beaglebone black: is mem=... broken?
Date: Sun, 18 Jan 2015 18:38:46 +0100
Message-ID: <CAMuHMdX07-5xUt8KpS_biZMhpeoZcQFHvZL9ZFQGvKm9-CEKng@mail.gmail.com>
References: <20150118143448.GA4023@luxor.wired.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:40807 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751593AbbARRir (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 18 Jan 2015 12:38:47 -0500
Received: by mail-lb0-f181.google.com with SMTP id u14so15414306lbd.12
        for <linux-omap@vger.kernel.org>; Sun, 18 Jan 2015 09:38:46 -0800 (PST)
In-Reply-To: <20150118143448.GA4023@luxor.wired.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paolo Pisati <p.pisati@gmail.com>
Cc: linux-arm <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>

On Sun, Jan 18, 2015 at 3:34 PM, Paolo Pisati <p.pisati@gmail.com> wrote:
> Boot hangs when passing mem=256M to a 3.16 kernel (but i was able to reproduce
> it with multi_v7_defconfig on a 3.19rcX kernel too):
>
> 80e6d694: 00240000 00000000 65746e49 6c616e72    ..$.....Internal
> 80e6d6a4: 72726520 203a726f 73706f4f 2035203a     error: Oops: 5
> 80e6d6b4: 5d31235b 504d5320 4d524120 00000000    [#1] SMP ARM....
> 80e6d6c4: 00000000 00120000 00000000 75646f4d    ............Modu
> 80e6d6d4: 2073656c 6b6e696c 69206465 00003a6e    les linked in:..
> 80e6d6e4: 00000000 00000000 00000000 00000000    ................
> 80e6d6f4: 00000000 00000000 00000000 6f432030    ............0 Co
> 80e6d704: 203a6d6d 70617773 20726570 20746f4e    mm: swapper Not
> 80e6d714: 6e696174 20646574 36312e33 322d302e    tainted 3.16.0-2
> 80e6d724: 65672d38 6972656e 33232063 62552d38    8-generic #38-Ub
> 80e6d734: 75746e75 00000000 00000000 002d0000    untu..........-.
> 80e6d744: 00000000 6b736174 3063203a 61313964    ....task: c0d91a
> 80e6d754: 74203832 63203a69 34386430 20303030    28 ti: c0d84000
> 80e6d764: 6b736174 3a69742e 64306320 30303438    task.ti: c0d8400
> 80e6d774: 00000030 00000000 00000000 00220000    0.............".
> 80e6d784: 00000000 69204350 74612073 74646620    ....PC is at fdt
> 80e6d794: 6568635f 685f6b63 65646165 78302b72    _check_header+0x
> 80e6d7a4: 78302f30 00003437 00000000 00000000    0/0x74..........
> 80e6d7b4: 00000000 00000000 00000000 74612073    ............s at

The boot loader copied the DT to the end of real RAM, not to the end of
the 256 MiB block? Hence the kernel accesses unmapped memory
when checking the FDT header?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
