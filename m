From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: Watchdog dump
Date: Wed, 30 Sep 2009 07:23:47 -0700
Message-ID: <87ws3gpl3g.fsf@deeprootsystems.com>
References: <bb2708720909251327w7107c192h145a68a3134e63c8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f194.google.com ([209.85.216.194]:34751 "EHLO
	mail-px0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751863AbZI3OXp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Sep 2009 10:23:45 -0400
Received: by pxi32 with SMTP id 32so5486534pxi.4
        for <linux-omap@vger.kernel.org>; Wed, 30 Sep 2009 07:23:49 -0700 (PDT)
In-Reply-To: <bb2708720909251327w7107c192h145a68a3134e63c8@mail.gmail.com> (John Sarman's message of "Fri\, 25 Sep 2009 16\:27\:07 -0400")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: John Sarman <johnsarman@gmail.com>
Cc: linux-davinci <linux-omap@vger.kernel.org>

John Sarman <johnsarman@gmail.com> writes:

> I got a watchdog dump and it said cut here so I did and I am pasting to get help

It would help to post the kernel version, SoC and board you're using.

Based on the dm9000 driver, I'm guessing this is a DaVinci DM355 and
you meant to post this to the DaVinci list:
davinci-linux-open-source@linux.davincidsp.com

This looks like the GPIO IRQ problem we had on dm355 awhile back and
has been fixed in davinci git for some time.

Kevin

> eth0: link down
> Sending DHCP requests ..
> eth0: link up, 100Mbps, full-duplex, lpa 0x4DE1
> ..
> ------------[ cut here ]------------
> WARNING: at net/sched/sch_generic.c:246 dev_watchdog+0x18c/0x29c()
> NETDEV WATCHDOG: eth0 (dm9000): transmit queue 0 timed out
> Modules linked in:
> Backtrace:
> [<c002d784>] (dump_backtrace+0x0/0x114) from [<c02d0058>] (dump_stack+0x18/0x1c)
>  r7:c03b3e10 r6:c0256344 r5:c038ad99 r4:000000f6
> [<c02d0040>] (dump_stack+0x0/0x1c) from [<c003e000>] (warn_slowpath_common+0x50)
> [<c003dfb0>] (warn_slowpath_common+0x0/0x68) from [<c003e064>] (warn_slowpath_f)
<>  r7:00000024 r6:c04043a0 r5:c48d7400 r4:00000000
> [<c003e034>] (warn_slowpath_fmt+0x0/0x38) from [<c0256344>] (dev_watchdog+0x18c)
>  r3:c48d7400 r2:c038adb1
> [<c02561b8>] (dev_watchdog+0x0/0x29c) from [<c0048304>] (run_timer_softirq+0x1b)
> [<c0048148>] (run_timer_softirq+0x0/0x280) from [<c00435ac>] (__do_softirq+0x98)
> [<c0043514>] (__do_softirq+0x0/0x12c) from [<c0043690>] (irq_exit+0x50/0xa4)
> [<c0043640>] (irq_exit+0x0/0xa4) from [<c0029074>] (_text+0x74/0x8c)
> [<c0029000>] (_text+0x0/0x8c) from [<c0029aac>] (__irq_svc+0x4c/0x90)
> Exception stack(0xc03b3f50 to 0xc03b3f98)
> 3f40:                                     00000000 0005317f 0005217f 60000013
> 3f60: c03b2000 c03de420 c0023e14 c03b6358 80022334 41069265 80022300 c03b3fa4
> 3f80: 600000d3 c03b3f98 c002a9b0 c002a9bc 60000013 ffffffff
>  r5:fec48000 r4:ffffffff
> [<c002a988>] (default_idle+0x0/0x38) from [<c002af08>] (cpu_idle+0x78/0xe4)
> [<c002ae90>] (cpu_idle+0x0/0xe4) from [<c02cecf4>] (rest_init+0x70/0x84)
>  r5:c03de420 r4:c03f2af8
> [<c02cec84>] (rest_init+0x0/0x84) from [<c0008998>] (start_kernel+0x268/0x2c0)
> [<c0008730>] (start_kernel+0x0/0x2c0) from [<80008034>] (0x80008034)
>  r5:c03de4c4 r4:00053175
> ---[ end trace 5b6c3710ca2a460a ]---
> ., OK
> IP-Config: Got DHCP answer from 192.168.2.1, my address is 192.168.2.155
> IP-Config: Complete:
>      device=eth0, addr=192.168.2.155, mask=255.255.255.0, gw=192.168.2.1,
>      host=192.168.2.155, domain=, nis-domain=(none),
>      bootserver=192.168.2.1, rootserver=192.168.2.1, rootpath=
> kjournald starting.  Commit interval 5 seconds
>
>
> The kernel continued to boot and all is well but just curious if there
> is something that I can do to "pet the dog" or whatever to prevent
> this from outputting.
>
> Thanks in Advance
> John Sarman
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
