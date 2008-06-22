From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH] OMAP3 clock: fix omap2_clk_wait_ready for OMAP3430ES2
 DSS
Date: Sun, 22 Jun 2008 07:51:17 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE8967162035BA2A659@dlee02.ent.ti.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB022BE46296@dbde02.ent.ti.com>,<485CA347.909@googlemail.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB022BB66209@dbde02.ent.ti.com>
 <alpine.DEB.1.00.0806211054100.19765@utopia.booyaka.com>
 <ACAEC52B-E9B4-4789-8D63-114C53846760@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57942 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751680AbYFVMvc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 22 Jun 2008 08:51:32 -0400
In-Reply-To: <ACAEC52B-E9B4-4789-8D63-114C53846760@student.utwente.nl>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <k.kooi@student.utwente.nl>, Paul Walmsley <paul@pwsan.com>
Cc: "Gadiyar, Anand" <gadiyar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Dirk Behme <dirk.behme@googlemail.com>, "jouni.hogander@nokia.com" <jouni.hogander@nokia.com>


> PowerTOP version 1.10      (C) 2007 Intel Corporation
>
> Cn                Avg residency       P-states (frequencies)
> C0 (cpu running)        ( 0.0%)
> C0                0.0ms ( 0.0%)
> C1              188.9ms (0.7%)*
> C2              2036.1ms (8.0%)*
> C3              23285.1ms (91.3%)*
>
> Wakeups-from-idle per second : 61.7     interval: 3.0s
>
> Top causes for wakeups:
>    44.9% ( 57.7)       <interrupt> : musb_hdrc.0
>    17.9% ( 23.0)       <interrupt> : gp timer
>    14.3% ( 18.3)   USB device 2-1.2 : LCD2USB Interface (Till Harbaum)
>     9.9% ( 12.7)         lcd4linux : do_nanosleep (hrtimer_wakeup)
>     7.5% (  9.7)   USB device 2-1.4 : Linksys USB2.0 Network Adapter
> (USB)
>     3.9% (  5.0)            Xfbdev : fbcon_add_cursor_timer
> (cursor_timer_handler)
>     0.5% (  0.7)              hald : schedule_timeout (process_timeout)
>     0.3% (  0.3)          dropbear : sk_reset_timer (tcp_write_timer)
>     0.3% (  0.3)     <kernel core> : neigh_table_init_no_netlink
> (neigh_periodic_timer)
>     0.3% (  0.3)        pulseaudio : schedule_timeout (process_timeout)
>     0.3% (  0.3)              init : schedule_timeout (process_timeout)
>
> The dispc crashes are gone and I get fewer wakeups per second :)
>
> regards,
>
> Koen
>
>
> * There's a bug in powertop 1.10 that reports percentages wrong, so
> the percentages  where approximated by hand.
>
> C0 (cpu running)        ( 0.0%)
> C0                0.0ms ( 0.0%)
> C1              176.5ms ( 4.7%)
> C2              3601.7ms (4090.7%)
> C3              17956.3ms (92938.0%)

Those C-State residency times are clearly wrong also.

If you try hard with a minimal kernel the maximum sleep you can get is like 1.5 seconds.  The kernel has some hard coded timers with 1 to 2 second periods (like slab cache reaper threads).

For our non-edge kernel code these things report about right.  As long as you have a 99.9% duty cycle of OFF to ON you get pretty good savings.

The wake up information should be about right.  Your USB Networking with MUSB will probably assure you of never getting ultra low power numbers but probably good for development.

What is that USB2LCD device?



Regards,
Richard W.


