From: Chris Hoffmann <chrmhoffmann@gmail.com>
Subject: Re: DSS: kernel p-android-3.0 hangs when omapdss.debug is enabled.
Date: Sun, 02 Sep 2012 19:33:28 +0200
Message-ID: <50439868.9000700@gmail.com>
References: <CAAk9F9_S7obNUo5Y3yuJZ4gejzUVEUVGyt1xhWQ1u1RckOeBLg@mail.gmail.com> <201209021935.11897.dinuxbg@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:59464 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754304Ab2IBRde (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 2 Sep 2012 13:33:34 -0400
Received: by eaac11 with SMTP id c11so1376256eaa.19
        for <linux-omap@vger.kernel.org>; Sun, 02 Sep 2012 10:33:33 -0700 (PDT)
In-Reply-To: <201209021935.11897.dinuxbg@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dimitar Dimitrov <dinuxbg@gmail.com>
Cc: Christian Hoffmann <chrmhoffmann@gmail.com>, linux-omap@vger.kernel.org

On 09/02/2012 06:35 PM, Dimitar Dimitrov wrote:
> On Sunday 02 September 2012 15:25:09 Christian Hoffmann wrote:
>> Hi,
>>
>> we're currently porting a 2.6.35 android kernel for a custom omap4430
>> board (aka nook tablet) to version 3.0.x. We're experiencing random
>> hangs with no trace in the dmesg/last_kmsg or on serial console. Being
>> desperate to find the cause, I tried to put omapdss.debug=y but
>> unfortunately now the kernel hangs on boot. Putting on lock debugging,
>> I can see the following in last_kmsg:
>> ...
>> [   17.161529] omapdss MANAGER: configure_manager(2)
>> [   17.166625] omapdss MANAGER: configure manager wbc->shadow_dirty = 0
>> [   17.173370] omapdss DISPC: GO LCD2
>> [   17.177368] omapdss MANAGER: configure manager wbc->shadow_dirty = 0
>> [   17.184143] omapdss MANAGER: configure manager wbc->shadow_dirty = 0
>> [   17.191192] omapdss MANAGER: configure manager wbc->shadow_dirty = 0
>> [   37.691680] BUG: spinlock lockup on CPU#0, BootAnimation/276, e5fbfd74
>> [   37.699035] Backtrace:
>> [   37.701965] [<c006c204>] (dump_backtrace+0x0/0x114) from
>> [<c06613e8>] (dump_stack+0x20/0x24)
>> [   37.710998]  r6:00000000 r5:e5438000 r4:e5fbfd74 r3:00000002
>> [   37.717651] [<c06613c8>] (dump_stack+0x0/0x24) from [<c032a604>]
>> (do_raw_spin_lock+0x11c/0x180)
>> [   37.727081] [<c032a4e8>] (do_raw_spin_lock+0x0/0x180) from
>> [<c066b74c>] (_raw_spin_lock_irqsave+0x74/0x80)
>> [   37.737426]  r9:e5438000 r8:00040000 r7:00000002 r6:c009f18c r5:280b0193
>> [   37.744995] r4:e5fbfd74
>> [   37.748107] [<c066b6d8>] (_raw_spin_lock_irqsave+0x0/0x80) from
>> [<c009f18c>] (complete+0x28/0x68)
>> [   37.757690]  r6:e5fbfd70 r5:00040080 r4:e5fbfd74
>> [   37.763031] [<c009f164>] (complete+0x0/0x68) from [<c0348388>]
>> (dispc_irq_wait_handler.27590+0x18/0x1c)
>> [   37.773162]  r6:c0e5850c r5:00040080 r4:e5439d98
>> [   37.778594] [<c0348370>] (dispc_irq_wait_handler.27590+0x0/0x1c)
>> from [<c0348200>] (omap_dispc_irq_handler+0xb0/0x220)
>> [   37.790130] [<c0348150>] (omap_dispc_irq_handler+0x0/0x220) from
>> [<c0108acc>] (handle_irq_event_percpu+0x84/0x2dc)
>> [   37.801300] [<c0108a48>] (handle_irq_event_percpu+0x0/0x2dc) from
>> [<c0108d70>] (handle_irq_event+0x4c/0x6c)
>> [   37.811737] [<c0108d24>] (handle_irq_event+0x0/0x6c) from
>> [<c010b530>] (handle_fasteoi_irq+0xcc/0x174)
>> [   37.821777]  r6:e5438000 r5:c08a2cac r4:c08a2c60 r3:00000000
>> [   37.828338] [<c010b464>] (handle_fasteoi_irq+0x0/0x174) from
>> [<c01082fc>] (generic_handle_irq+0x40/0x54)
>> [   37.838562]  r5:c0061158 r4:c08b4260
>> [   37.842681] [<c01082bc>] (generic_handle_irq+0x0/0x54) from
>> [<c0062354>] (asm_do_IRQ+0x5c/0xbc)
>> [   37.852111] [<c00622f8>] (asm_do_IRQ+0x0/0xbc) from [<c066c58c>]
>> (__irq_svc+0x4c/0xec)
>> ...
>>
>> Full dmesg is here: https://dl.dropbox.com/u/21820416/crash-dss-debug.dmesg
>>
>> Kernel source is very close to p-android-3.0. It can be found here:
>> https://github.com/Kuzma30/kernel3NookTablet/tree/jellybean
>> Used config: cyanogenmod_acclaim_defconfig.
>>
>> We have made some slight modifications to dss (for DSI2/lcd2/vsync2).
>> For quick comparison, I put diff off drivers/video/omap2 here:
>> https://dl.dropbox.com/u/21820416/dss.diff
>>
>> Please also note that we have a "boxer" as display
>> (https://github.com/Kuzma30/kernel3NookTablet/blob/jellybean/drivers/video/
>> omap2/displays/panel-boxer.c).
>>
>> Kind regards,
>> Chris
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> Could you try the following v3.0 patch: http://review.omapzoom.org/#/c/26235/
>
> Regards,
> Dimitar
>

Hi,

Thank you, very much. This indeed makes the omapdss.debug=y work. I had 
to "rebase" the change a bit as we also have this one:
"OMAPFB: Select correct VSYNC IRQ based on DSS channel" in place.

Thanks again!

Rgds,
Chris
