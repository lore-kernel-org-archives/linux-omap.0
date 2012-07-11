From: Omar Ramirez Luna <omar.luna@linaro.org>
Subject: Re: PM/RTC 3.5-rc5: System suspends fails when not built with RTC?
Date: Wed, 11 Jul 2012 15:52:00 -0500
Message-ID: <CALLhW=6p4AAUrpQmAFCTC2SYbAU_2F0roZ4Ha-NfE+oGn6zPbw@mail.gmail.com>
References: <WC20120705150314.450045@terrafix.co.uk>
	<87zk77p3s5.fsf@ti.com>
	<WC20120711105003.8400AC@terrafix.co.uk>
	<87pq82kz0l.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:65245 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752418Ab2GKUwB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Jul 2012 16:52:01 -0400
Received: by vbbff1 with SMTP id ff1so1063082vbb.19
        for <linux-omap@vger.kernel.org>; Wed, 11 Jul 2012 13:52:00 -0700 (PDT)
In-Reply-To: <87pq82kz0l.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Joe Woodward <jw@terrafix.co.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 11 July 2012 12:07, Kevin Hilman <khilman@ti.com> wrote:
...
>> [    2.311004] omap_hsmmc omap_hsmmc.0: Failed to get debounce clk
>> [    2.317382] omap_hsmmc omap_hsmmc.0: unable to obtain RX DMA engine channel 62
>> [    2.325256] omap_hsmmc omap_hsmmc.1: Failed to get debounce clk
>> [    2.331512] omap_hsmmc omap_hsmmc.1: unable to obtain RX DMA engine channel 48
>
> These are normal because DMA engine is not compiled in with
> omap2plus_defconfig.  MMC wont' work unless you build in DMA engine, but
> that doesn't matter for trying to figure out your problem.

Hijacking this thread a little bit...

It looks like a dependency is missing in Kconfig then, as this also
fails to boot if the file system is in MMC. As you pointed out
CONFIG_DMADEVICES and CONFIG_DMA_OMAP is needed to boot in this case.
I'm using a Panda 4460.

Regards,

Omar
