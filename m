From: Kevin Hilman <khilman@ti.com>
Subject: Re: PM/RTC 3.5-rc5: System suspends fails when not built with RTC?
Date: Wed, 11 Jul 2012 14:29:27 -0700
Message-ID: <87wr2ahtqg.fsf@ti.com>
References: <WC20120705150314.450045@terrafix.co.uk> <87zk77p3s5.fsf@ti.com>
	<WC20120711105003.8400AC@terrafix.co.uk> <87pq82kz0l.fsf@ti.com>
	<CALLhW=6p4AAUrpQmAFCTC2SYbAU_2F0roZ4Ha-NfE+oGn6zPbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:44592 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754347Ab2GKV32 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Jul 2012 17:29:28 -0400
Received: by yenq11 with SMTP id q11so1775518yen.2
        for <linux-omap@vger.kernel.org>; Wed, 11 Jul 2012 14:29:26 -0700 (PDT)
In-Reply-To: <CALLhW=6p4AAUrpQmAFCTC2SYbAU_2F0roZ4Ha-NfE+oGn6zPbw@mail.gmail.com>
	(Omar Ramirez Luna's message of "Wed, 11 Jul 2012 15:52:00 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Omar Ramirez Luna <omar.luna@linaro.org>
Cc: Joe Woodward <jw@terrafix.co.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Omar Ramirez Luna <omar.luna@linaro.org> writes:

> On 11 July 2012 12:07, Kevin Hilman <khilman@ti.com> wrote:
> ...
>>> [    2.311004] omap_hsmmc omap_hsmmc.0: Failed to get debounce clk
>>> [    2.317382] omap_hsmmc omap_hsmmc.0: unable to obtain RX DMA engine channel 62
>>> [    2.325256] omap_hsmmc omap_hsmmc.1: Failed to get debounce clk
>>> [    2.331512] omap_hsmmc omap_hsmmc.1: unable to obtain RX DMA engine channel 48
>>
>> These are normal because DMA engine is not compiled in with
>> omap2plus_defconfig.  MMC wont' work unless you build in DMA engine, but
>> that doesn't matter for trying to figure out your problem.
>
> Hijacking this thread a little bit...
>
> It looks like a dependency is missing in Kconfig then, as this also
> fails to boot if the file system is in MMC. As you pointed out
> CONFIG_DMADEVICES and CONFIG_DMA_OMAP is needed to boot in this case.
> I'm using a Panda 4460.

Yes, the drivers that have been converted to DMA engine should probably
'select DMADEVICES' and 'select DMA_OMAP' since they will now depend on
DMA engine.

Kevin
