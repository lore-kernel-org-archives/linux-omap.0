From: James Adams <james.r.adams@gmail.com>
Subject: Re: DSP Bridge video decode of above VGA videos
Date: Thu, 25 Nov 2010 10:52:33 +0000
Message-ID: <AANLkTik7h5r0mSCSe1tupe6zNb6=VDufoA+GUWAiXr7u@mail.gmail.com>
References: <AANLkTi=XRy1gy5mhnpWPcmT5cwPzPVtvcrc6_gt6T8WK@mail.gmail.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E9402EF6AD46F@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:62076 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752387Ab0KYKwg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Nov 2010 05:52:36 -0500
Received: by qwb7 with SMTP id 7so818518qwb.19
        for <linux-omap@vger.kernel.org>; Thu, 25 Nov 2010 02:52:35 -0800 (PST)
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E9402EF6AD46F@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pawse, Guruprasad" <guruprasadvp@ti.com>
Cc: "Uribe de Leon, Armando" <x0095078@ti.com>, "Thomas, Rijo" <x0112903@ti.com>, "Sapiens, Rene" <rene.sapiens@ti.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Venkatasubbarao, Pradeep" <pradeepv@ti.com>

Thanks Guru, and everyone for all your help!

I am afraid that I am unable to find the h264vdec_sn.tcf file, perhaps
it is not part of the publicly released files?

However, Guru has very clearly explained the size limitations so that
answers my original question, many thanks.

Our application needs to decode higher resolution videos (960x544) -
but at reduced framerate. Presumably given the aforementioned
limitations there is no way to make this work?

Thanks again to all for all the help,

James

On Thu, Nov 25, 2010 at 5:11 AM, Pawse, Guruprasad <guruprasadvp@ti.com=
> wrote:
> Hi Armando,
>
> Yes it is possible to decode H.264 videos above VGA (640x480).
>
> Below are the details of the maximum resolution supported and their
> restrictions.
>
> -=A0=A0=A0=A0=A0=A0=A0 Maximum resolution supported is WVGA (864x480)=
 either portrait or
> landscape.
>
> -=A0=A0=A0=A0=A0=A0=A0 Width cannot be greater than 864
>
> -=A0=A0=A0=A0=A0=A0=A0 Number of MB=92s should not be greater than 16=
20.(i.e. Width x Height
> should be <=3D 414720)
>
>
>
>> Testing some other sizes I find that 800x480, 854x480, 864x480,
>
>> 800x512 and 854x480 play, but
>
>> 960x480, 800x528, 800x544, 880x480 do not.
>
> The nonworking resolutions from the above list have either width>864 =
or
> number of MB=92s >1620 and hence unsupported.
>
>
>
> Regards,
>
> Guru
>
>
>
> -----Original Message-----
> From: Uribe de Leon, Armando [mailto:x0095078@ti.com]
> Sent: Thursday, November 25, 2010 12:59 AM
> To: James Adams; Thomas, Rijo; Pawse, Guruprasad
> Cc: Sapiens, Rene; Kanigeri, Hari; linux-omap@vger.kernel.org
> Subject: Re: DSP Bridge video decode of above VGA videos
>
>
>
> Hi James,
>
>
>
> It seems that this question is more intended to the TI SN team, anywa=
y
>
> I have taken a look at the mail chain and from your conclusions below
>
> seems that you are facing memory allocation issues. I think it is
>
> probably you are getting a SYS_EALLOC coming in from the call to
>
> UTILS_allocatePrivateBuffer()=A0 where the buffer is being allocated.
>
>
>
> Some nodes may need to allocate very large buffers, possibly larger
>
> than any heap size configured in the base image. In order to support
>
> these nodes, external memory requirements can be configured for up to
>
> 16 profiles of a node. This will allow the ARM OS to allocate a
>
> private heap for a node.You can check your SN .tcf file to look at th=
e
>
> configured profiles, for example if you are using the h264 TI SN the
>
> file is h264vdec_sn.tcf. You will see the 16 profiles listed there.
>
> And you must use the profile that fits your needs.
>
>
>
> TI H264 has two decoding modes: FRAME and STREAMING. I recall that fo=
r
>
> FRAME mode the max resolution allowed is VGA: profile 3; although for
>
> STREAMING there are 7 profiles, but I am not familiar with those
>
> profiles and how STREAMING mode works.
>
>
>
> I am looping SN folks, they might help more accurately, also I am
>
> thinking that we can remove the=A0 linux-omap@vger.kernel.org list in
>
> the subsequent mails.
>
>
>
> Rijo, Guruprasad,
>
>
>
> Do you know if it is possible decode H264 videos with resolution abov=
e
> 640x480?
>
>
>
> I am copying the original James query:
>
>
>
> We are running Android on a custom Gumstix Overo Water platform. We
>
> have ported the 25.12 Zoom2 release to do this.
>
>
>
> It is almost working except that when trying to decode H264 videos
>
> with resolution above 640x480 (either horizontally or vertically, e.g=
=2E
>
> 640*544) the DSP module appears to crash. Decoding anything at VGA or
>
> below is working fine.
>
>
>
> DSP bridge is configured with 0x600000 memory (but larger doesn't see=
m
>
> to help).=A0 Is anyone aware of other configuration options that we
>
> should be checking (e.g. in DSP bridge, OMAP video drivers, or
>
> android?) that might cause large video decodes to fail?
>
>
>
>
>
> Thanks and regards,
>
> Armando.
>
>
>
>
>
>
>
> On Wed, Nov 24, 2010 at 10:01 AM, James Adams <james.r.adams@gmail.co=
m>
> wrote:
>
>> Many thanks for the help Rene, it makes a huge difference being told
>
>> whereabouts in the gigabytes of source to start looking!
>
>>
>
>> You are quite correct in that the error comes from NODE_Create.
>
>> Node_Create calls DISP_NodeCreate
>
>> DISP_NodeCreate calls SendMessage
>
>> SendMessage succeeds, but after CHNL_IsIOComplete reads back a statu=
s
>
>> code from chnlIOC.pBuf which has the error code in it.
>
>>
>
>> My understanding is that this means that the dsp bridge kernel has s=
ent
>
>> a message across to the TI DSP, but the DSP is reporting out of memo=
ry.
>
>>
>
>> Unfortunately, I don't know where to go from here, any tips?
>
>>
>
>> I've looked at the DSP bridge documents but I still don't really hav=
e a
>
>> handle on the memory allocation.
>
>> My understanding is that:
>
>> 1) The DSP and ARM share access to the same memory chips
>
>> 2) The DSP bridge allocates shm_size memory for page tables and
>
>> communications
>
>> 3) The DSP bridge assigns phys_mempool_size memory at a fixed addres=
s
>
>> for the DSP to store its own data inside
>
>> I don't understand where the streaming data gets allocated.
>
>>
>
>> I've tried increasing phys_mempool_size but it behaves the same.
>
>>
>
>> I've added printk to the allocation routines in mem.c, but none of t=
hese
>
>> are failing. =A0(Although I suspect they are irrelevant and it is so=
me
>
>> memory manager running on the DSP that is failing)
>
>>
>
>> Testing some other sizes I find that 800x480, 854x480, 864x480,
>
>> 800x512 and 854x480 play, but
>
>> 960x480, 800x528, 800x544, 880x480 do not.
>
>>
>
>> Is it possible that the TI binaries will always return EMEMORY if to=
o
>
>> high a resolution is requested?
>
>>
>
>> Any advice much appreciated!
>
>>
>
>>
>
>>
>
>>
>
>> On Wed, Nov 24, 2010 at 12:38 AM, Sapiens, Rene <rene.sapiens@ti.com=
>
>> wrote:
>
>>> Hi James,
>
>>>
>
>>>> The second error log is the stack trace when the watchdog timer ca=
lls
>
>>>> SYNC_EnterCS.
>
>>>
>
>>> Actually is not the WDT calling the function to get into the critic=
al
>
>>> section, it is the WDT being disabled when the DSP is going to OFF
>
>>> state. This should fine.
>
>>>
>
>>>> The stack trace is shown below.
>
>>>>
>
>>>
>
>>> 1) Is this trace printed after the 'if (in_interrupt())' statement?
>
>>> 2) Can you check under drivers/dsp/bridge/ to see where is or under
>
>>> which context io_dispatchpm called?
>
>>>
>
>>> To get the assertions failing you should be in the context of an
>
>>> interrupt, the code base that i have is not that way for that reaso=
n i
>
>>> ask for your io_dispatchpm function.
>
>>>
>
>>>> [<c0412864>] (dump_stack+0x0/0x14) from [<c0278c18>]
>
>>>> (SYNC_EnterCS+0x48/0xe4)
>
>>>> [<c0278bd0>] (SYNC_EnterCS+0x0/0xe4) from [<c0279e24>]
>
>>>> (REG_GetValue+0x60/0xa0)
>
>>>> =A0r5:c05ba390 r4:c04f092c
>
>>>> [<c0279dc4>] (REG_GetValue+0x0/0xa0) from [<c027987c>]
>
>>>> (CFG_GetObject+0x60/0xe0)
>
>>>> =A0r7:cfa87a80 r6:00000002 r5:cf98fe94 r4:00000002
>
>>>> [<c027981c>] (CFG_GetObject+0x0/0xe0) from [<c02913c0>]
>
>>>> (DRV_GetFirstDevObject+0
>
>>>> x1c/0x4c)
>
>>>> =A0r5:c05ba3c0 r4:00000000
>
>>>> [<c02913a4>] (DRV_GetFirstDevObject+0x0/0x4c) from [<c02858e4>]
>
>>>> (DEV_GetFirst+0x
>
>>>> 10/0x44)
>
>>>> [<c02858d4>] (DEV_GetFirst+0x0/0x44) from [<c027d430>]
>
>>>> (dsp_wdt_enable+0x44/0xe0
>
>>>> )
>
>>>> =A0r5:c05ba3c0 r4:00000000
>
>>>> [<c027d3ec>] (dsp_wdt_enable+0x0/0xe0) from [<c02820fc>]
>
>>>> (handle_hibernation_fro
>
>>>> mDSP+0x148/0x1ec)
>
>>>> =A0r5:cfaa0000 r4:00008000
>
>>>> [<c0281fb4>] (handle_hibernation_fromDSP+0x0/0x1ec) from [<c02810c=
0>]
>
>>>> (WMD_DEV_C
>
>>>> trl+0xfc/0x130)
>
>>>> =A0r7:cf98e000 r6:cf98ff34 r5:cc5f6a88 r4:cfb89e00
>
>>>> [<c0280fc4>] (WMD_DEV_Ctrl+0x0/0x130) from [<c027dc24>]
>
>>>> (io_mbox_msg+0x70/0x1d8)
>
>>>> =A0r7:cf98e000 r6:c05496c4 r5:cc5f6a88 r4:cfb89e00
>
>>>> [<c027dbb4>] (io_mbox_msg+0x0/0x1d8) from [<c0059308>]
>
>>>> (mbox_rx_work+0xf4/0x100)
>
>>>> =A0r5:cc5f6a88 r4:0000200a
>
>>>> [<c0059214>] (mbox_rx_work+0x0/0x100) from [<c007ebb0>]
>
>>>> (run_workqueue+0xc8/0x18
>
>>>> 4)
>
>>>> [<c007eae8>] (run_workqueue+0x0/0x184) from [<c007f2dc>]
>
>>>> (worker_thread+0x104/0x
>
>>>> 118)
>
>>>> =A0r9:00000000 r8:00000000 r7:cf811040 r6:cf94e140 r5:cf94e148
>
>>>> r4:cf98e000
>
>>>> [<c007f1d8>] (worker_thread+0x0/0x118) from [<c0082cb4>]
>
>>>> (kthread+0x54/0x80)
>
>>>> =A0r7:00000000 r6:00000000 r5:c007f1d8 r4:cf94e140
>
>>>> [<c0082c60>] (kthread+0x0/0x80) from [<c0070b1c>] (do_exit+0x0/0x7=
bc)
>
>>>> =A0r5:00000000 r4:00000000
>
>>>> drivers/dsp/bridge/services/sync.c, line 358: Assertion (0) failed=
=2E
>
>>>
>
>>> Regards,
>
>>> Rene Sapiens
>
>>>
>
>> --
>
>> To unsubscribe from this list: send the line "unsubscribe linux-omap=
" in
>
>> the body of a message to majordomo@vger.kernel.org
>
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
>>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
