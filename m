From: Kevin Hilman <khilman@ti.com>
Subject: Re: PM related performance degradation on OMAP3
Date: Mon, 09 Apr 2012 12:03:18 -0700
Message-ID: <877gxobudk.fsf@ti.com>
References: <CANOLnOP5gq4Vtt00SgRNW-3GZDWk0sukBgJx4V6rkMLL+b6G-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog138.obsmtp.com ([74.125.149.19]:56846 "EHLO
	psmtp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754226Ab2DITDO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 9 Apr 2012 15:03:14 -0400
Received: by pbbjt11 with SMTP id jt11so6596573pbb.35
        for <linux-omap@vger.kernel.org>; Mon, 09 Apr 2012 12:03:13 -0700 (PDT)
In-Reply-To: <CANOLnOP5gq4Vtt00SgRNW-3GZDWk0sukBgJx4V6rkMLL+b6G-w@mail.gmail.com>
	(Grazvydas Ignotas's message of "Sat, 7 Apr 2012 01:50:19 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>

Grazvydas Ignotas <notasas@gmail.com> writes:

> Hello,
>
> I'm DMA seeing performance loss related to CONFIG_PM on OMAP3.
>
> # CONFIG_PM is set:
> echo 3 > /proc/sys/vm/drop_caches
> # file copy from NAND (using NAND driver in DMA mode)
> dd if=/mnt/tmp/a of=/dev/null bs=1M count=32
> 33554432 bytes (32.0MB) copied, 9.088714 seconds, 3.5MB/s
> # file read from SD (hsmmc uses DMA)
> dd if=/dev/mmcblk0 of=/dev/null bs=1M count=32
> 33554432 bytes (32.0MB) copied, 2.065460 seconds, 15.5MB/s
>
> # CONFIG_PM not set:
> # NAND
> dd if=/mnt/tmp/a of=/dev/null bs=1M count=32
> 33554432 bytes (32.0MB) copied, 5.653534 seconds, 5.7MB/s
> # SD
> dd if=/dev/mmcblk0 of=/dev/null bs=1M count=32
> 33554432 bytes (32.0MB) copied, 1.919007 seconds, 16.7MB/s
>
> While SD card performance loss is not that bad (~7%), NAND one is
> worrying (~39%). I've tried disabling/enabling CONFIG_CPU_IDLE, also
> cpuidle states over sysfs, it did not have any significant effect. Is
> there something else to try?

Looks like we might need a PM QoS constraint when there is DMA activity
in progress.  

You can try doing a pm_qos_add_request() for PM_QOS_CPU_DMA_LATENCY when
DMA transfers are active and I suspect that will help.

> I'm guessing this is caused by CPU wakeup latency to service DMA
> interrupts? I've noticed that if I keep CPU busy, the loss is reduced
> almost completely.

Yeah, that suggests a QoS constraint is what's needed here.

> Talking about cpuidle, what's the difference between C1 and C2 states?
> They look mostly the same.

Except for clockdomains are not allowed to idle in C1 which results in
much shorter wakeup latency.

> Then there is omap3_do_wfi, it seems to be unconditionally putting
> SDRC on self-refresh, would it make sense to just do wfi in higher
> power states, like OMAP4 seems to be doing?

Not sure what you're referring to in OMAP4.  There we do WFI in every
idle state.

Kevin
