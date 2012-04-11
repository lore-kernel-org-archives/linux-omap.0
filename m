From: Gary Thomas <gary@mlbassoc.com>
Subject: Re: PM related performance degradation on OMAP3
Date: Wed, 11 Apr 2012 08:59:41 -0600
Message-ID: <4F859C5D.3090400@mlbassoc.com>
References: <CANOLnOP5gq4Vtt00SgRNW-3GZDWk0sukBgJx4V6rkMLL+b6G-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hermes.mlbassoc.com ([64.234.241.98]:34664 "EHLO
	mail.chez-thomas.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755344Ab2DKO7n (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Apr 2012 10:59:43 -0400
In-Reply-To: <CANOLnOP5gq4Vtt00SgRNW-3GZDWk0sukBgJx4V6rkMLL+b6G-w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>

On 2012-04-06 16:50, Grazvydas Ignotas wrote:
> Hello,
>
> I'm DMA seeing performance loss related to CONFIG_PM on OMAP3.
>
> # CONFIG_PM is set:
> echo 3>  /proc/sys/vm/drop_caches
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
>
> I'm guessing this is caused by CPU wakeup latency to service DMA
> interrupts? I've noticed that if I keep CPU busy, the loss is reduced
> almost completely.
> Talking about cpuidle, what's the difference between C1 and C2 states?
> They look mostly the same.
> Then there is omap3_do_wfi, it seems to be unconditionally putting
> SDRC on self-refresh, would it make sense to just do wfi in higher
> power states, like OMAP4 seems to be doing?
>

I fear I'm seeing similar problems with 3.3.  I have my board (similar
to the BeagleBoard) ported to 3.0 and 3.3.  I'm seeing terrible network
performance on 3.3.  For example, if I use TFTP to download a large file
(~35MB), I get this:
   3.0:  42.5 sec
   3.3: 625.0 sec
That's a factor of 15 worse!

I'd like to try building without CONFIG_PM, but when I disabled this, my
kernel fails to come up.  Can someone point me to the magic to build without
CONFIG_PM, or possibly send me a working config file?

Thanks

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
