From: James Adams <james.r.adams@gmail.com>
Subject: Re: DSP Bridge video decode of above VGA videos
Date: Wed, 24 Nov 2010 16:01:51 +0000
Message-ID: <AANLkTimRxPX0L-VE4xQE5-S5iHen5i3RphZd62y47d1B@mail.gmail.com>
References: <AANLkTim2PQ9kAvSi12987gAykMAuPg7f3XM3zQNo5Tip@mail.gmail.com>
	<AANLkTinCT-zQaGyLfS-NZU9Pue+2hmrLDckHYKqD_u8m@mail.gmail.com>
	<AANLkTimhKaS4y+k0t_x39aw8LvO-tNUH-=x3V9jk7BsC@mail.gmail.com>
	<AANLkTi=71zFhuBh3MArYjSEvJ+YXciF_9d2cn+5ojTb6@mail.gmail.com>
	<AANLkTinkMPb4Htv4GN8--PZP0UdkWuyXiLYvRC3QasWD@mail.gmail.com>
	<AANLkTim6++ATTJ=BCssvLYKRek0EXKVPMGgKH1WMNuRM@mail.gmail.com>
	<AANLkTinpR2S1vGaRr=DMALxWjb1X-4TPkhwXZbZhXbwj@mail.gmail.com>
	<AANLkTimV0iP0uL-SVnHhoPFN-x1X5cTsKPR_pbwjSPW0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:33318 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751867Ab0KXQBw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Nov 2010 11:01:52 -0500
Received: by iwn33 with SMTP id 33so1493437iwn.19
        for <linux-omap@vger.kernel.org>; Wed, 24 Nov 2010 08:01:51 -0800 (PST)
In-Reply-To: <AANLkTimV0iP0uL-SVnHhoPFN-x1X5cTsKPR_pbwjSPW0@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Sapiens, Rene" <rene.sapiens@ti.com>
Cc: "Kanigeri, Hari" <h-kanigeri2@ti.com>, linux-omap@vger.kernel.org

Many thanks for the help Rene, it makes a huge difference being told
whereabouts in the gigabytes of source to start looking!

You are quite correct in that the error comes from NODE_Create.
Node_Create calls DISP_NodeCreate
DISP_NodeCreate calls SendMessage
SendMessage succeeds, but after CHNL_IsIOComplete reads back a status
code from chnlIOC.pBuf which has the error code in it.

My understanding is that this means that the dsp bridge kernel has sent
a message across to the TI DSP, but the DSP is reporting out of memory.

Unfortunately, I don't know where to go from here, any tips?

I've looked at the DSP bridge documents but I still don't really have a
handle on the memory allocation.
My understanding is that:
1) The DSP and ARM share access to the same memory chips
2) The DSP bridge allocates shm_size memory for page tables and
communications
3) The DSP bridge assigns phys_mempool_size memory at a fixed address
for the DSP to store its own data inside
I don't understand where the streaming data gets allocated.

I've tried increasing phys_mempool_size but it behaves the same.

I've added printk to the allocation routines in mem.c, but none of thes=
e
are failing.  (Although I suspect they are irrelevant and it is some
memory manager running on the DSP that is failing)

Testing some other sizes I find that 800x480, 854x480, 864x480,
800x512 and 854x480 play, but
960x480, 800x528, 800x544, 880x480 do not.

Is it possible that the TI binaries will always return EMEMORY if too
high a resolution is requested?

Any advice much appreciated!




On Wed, Nov 24, 2010 at 12:38 AM, Sapiens, Rene <rene.sapiens@ti.com> w=
rote:
> Hi James,
>
>> The second error log is the stack trace when the watchdog timer call=
s
>> SYNC_EnterCS.
>
> Actually is not the WDT calling the function to get into the critical
> section, it is the WDT being disabled when the DSP is going to OFF
> state. This should fine.
>
>> The stack trace is shown below.
>>
>
> 1) Is this trace printed after the 'if (in_interrupt())' statement?
> 2) Can you check under drivers/dsp/bridge/ to see where is or under
> which context io_dispatchpm called?
>
> To get the assertions failing you should be in the context of an
> interrupt, the code base that i have is not that way for that reason =
i
> ask for your io_dispatchpm function.
>
>> [<c0412864>] (dump_stack+0x0/0x14) from [<c0278c18>]
>> (SYNC_EnterCS+0x48/0xe4)
>> [<c0278bd0>] (SYNC_EnterCS+0x0/0xe4) from [<c0279e24>]
>> (REG_GetValue+0x60/0xa0)
>> =A0r5:c05ba390 r4:c04f092c
>> [<c0279dc4>] (REG_GetValue+0x0/0xa0) from [<c027987c>]
>> (CFG_GetObject+0x60/0xe0)
>> =A0r7:cfa87a80 r6:00000002 r5:cf98fe94 r4:00000002
>> [<c027981c>] (CFG_GetObject+0x0/0xe0) from [<c02913c0>]
>> (DRV_GetFirstDevObject+0
>> x1c/0x4c)
>> =A0r5:c05ba3c0 r4:00000000
>> [<c02913a4>] (DRV_GetFirstDevObject+0x0/0x4c) from [<c02858e4>]
>> (DEV_GetFirst+0x
>> 10/0x44)
>> [<c02858d4>] (DEV_GetFirst+0x0/0x44) from [<c027d430>]
>> (dsp_wdt_enable+0x44/0xe0
>> )
>> =A0r5:c05ba3c0 r4:00000000
>> [<c027d3ec>] (dsp_wdt_enable+0x0/0xe0) from [<c02820fc>]
>> (handle_hibernation_fro
>> mDSP+0x148/0x1ec)
>> =A0r5:cfaa0000 r4:00008000
>> [<c0281fb4>] (handle_hibernation_fromDSP+0x0/0x1ec) from [<c02810c0>=
]
>> (WMD_DEV_C
>> trl+0xfc/0x130)
>> =A0r7:cf98e000 r6:cf98ff34 r5:cc5f6a88 r4:cfb89e00
>> [<c0280fc4>] (WMD_DEV_Ctrl+0x0/0x130) from [<c027dc24>]
>> (io_mbox_msg+0x70/0x1d8)
>> =A0r7:cf98e000 r6:c05496c4 r5:cc5f6a88 r4:cfb89e00
>> [<c027dbb4>] (io_mbox_msg+0x0/0x1d8) from [<c0059308>]
>> (mbox_rx_work+0xf4/0x100)
>> =A0r5:cc5f6a88 r4:0000200a
>> [<c0059214>] (mbox_rx_work+0x0/0x100) from [<c007ebb0>]
>> (run_workqueue+0xc8/0x18
>> 4)
>> [<c007eae8>] (run_workqueue+0x0/0x184) from [<c007f2dc>]
>> (worker_thread+0x104/0x
>> 118)
>> =A0r9:00000000 r8:00000000 r7:cf811040 r6:cf94e140 r5:cf94e148
>> r4:cf98e000
>> [<c007f1d8>] (worker_thread+0x0/0x118) from [<c0082cb4>]
>> (kthread+0x54/0x80)
>> =A0r7:00000000 r6:00000000 r5:c007f1d8 r4:cf94e140
>> [<c0082c60>] (kthread+0x0/0x80) from [<c0070b1c>] (do_exit+0x0/0x7bc=
)
>> =A0r5:00000000 r4:00000000
>> drivers/dsp/bridge/services/sync.c, line 358: Assertion (0) failed.
>
> Regards,
> Rene Sapiens
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
