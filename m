From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH 0/6] DSPBRIDGE: fix mem+cache API issues
Date: Sun, 16 May 2010 19:08:42 +0300
Message-ID: <AANLkTimPni797t7uSLXsmboHKeVIWt2u5gjCGh0t9kBx@mail.gmail.com>
References: <1272746671-13423-1-git-send-email-ohad@wizery.com>
	 <g2w94a0d4531005020617oa856c549k1af5d0100bf013aa@mail.gmail.com>
	 <r2ida15981b1005021047o67886d9u912eb1313d863d45@mail.gmail.com>
	 <AANLkTini4eWhImqK7BBkXDzvYdIxEGAF_yrUalgQ_7YJ@mail.gmail.com>
	 <4BEDA964.9070704@ti.com>
	 <AANLkTilNtSBBIMATnZdmiCQrhLXoD8hcOk43kxFbAqrp@mail.gmail.com>
	 <AANLkTildTe4-Qoj8e-sBjzPPGiVo5bHDo_LpsHt581sv@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:49254 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753138Ab0EPQIp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 16 May 2010 12:08:45 -0400
Received: by fxm6 with SMTP id 6so2990349fxm.19
        for <linux-omap@vger.kernel.org>; Sun, 16 May 2010 09:08:44 -0700 (PDT)
In-Reply-To: <AANLkTildTe4-Qoj8e-sBjzPPGiVo5bHDo_LpsHt581sv@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "Guzman Lugo, Fernando" <fernando.lugo@ti.com>, "Menon, Nishanth" <nm@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>

On Sat, May 15, 2010 at 12:08 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Sat, May 15, 2010 at 11:26 AM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> On Fri, May 14, 2010 at 10:49 PM, Omar Ramirez Luna <omar.ramirez@ti=
=2Ecom> wrote:
>>> On 5/14/2010 2:27 PM, Felipe Contreras wrote:
>>> [...]
>>>>
>>>> So, I tried your patches, and a simple test app worked fine withou=
t
>>>> modification, but a real video decoding hanged the device
>>>> completely... some spinlock was stuck. I don't know if it's becaus=
e of
>>>> your patches, or because of the state of the bridge at that point.
>>>> I'll try first to rebase to the latest to have a better idea of wh=
at's
>>>> happening.
>>>
>>> You may want to check if you have this patch "DSPBRIDGE: Fix declar=
ation and
>>> initialization of sync objects"[1]
>>
>> I used what Ohad suggested: 13e2573. So no, that patch is not there.
>>
>>> This is the one I know fixes a spinlock issue and which description=
 is not
>>> clear enough to state that.
>>>
>>> File fixed was: drivers/dsp/bridge/wmd/msg_sm.c
>>>
>>> [1]http://git.kernel.org/?p=3Dlinux/kernel/git/tmlind/linux-omap-2.=
6.git;a=3Dcommit;h=3Db3900e6df1f4e16b59d506a299cd5084c67a6ede
>>
>> I tried to cherry-pick that commit... didn't help:
>>
>> BUG: spinlock lockup on CPU#0, gst-launch-0.10/534, c6404304
>> Backtrace:
>> [<c0040984>] (dump_backtrace+0x0/0xf8) from [<c036d204>] (dump_stack=
+0x18/0x1c)
>> =C2=A0r6:00000000 r5:c644a000 r4:c6404304 r3:00000000
>> [<c036d1ec>] (dump_stack+0x0/0x1c) from [<c0213a08>]
>> (__spin_lock_debug+0xbc/0xd0)
>> [<c021394c>] (__spin_lock_debug+0x0/0xd0) from [<c0213aa0>]
>> (do_raw_spin_lock+0x84/0xb4)
>> =C2=A0r8:c644be54 r7:00000064 r6:c005f178 r5:80000013 r4:c6404304
>> [<c0213a1c>] (do_raw_spin_lock+0x0/0xb4) from [<c036ff6c>]
>> (_raw_spin_lock_irqsave+0x5c/0x68)
>> =C2=A0r4:c6404304 r3:c7865a00
>> [<c036ff10>] (_raw_spin_lock_irqsave+0x0/0x68) from [<c005f178>]
>> (completion_done+0x1c/0x38)
>> =C2=A0r6:00000001 r5:c6404304 r4:c6404300
>> [<c005f15c>] (completion_done+0x0/0x38) from [<bf00eb10>]
>> (sync_wait_on_multiple_events+0x58/0x14c [bridgedriver])
>> =C2=A0r5:00000002 r4:c644be4c
>> [<bf00eab8>] (sync_wait_on_multiple_events+0x0/0x14c [bridgedriver])
>> from [<bf01158c>] (bridge_msg_get+0x154/0x240 [bridgedriver])
>> [<bf011438>] (bridge_msg_get+0x0/0x240 [bridgedriver]) from
>> [<bf02220c>] (node_get_message+0x94/0x128 [bridgedriver])
>> [<bf022178>] (node_get_message+0x0/0x128 [bridgedriver]) from
>> [<bf019968>] (nodewrap_get_message+0x28/0x8c [bridgedriver])
>> =C2=A0r7:c004db48 r6:bf02e7d6 r5:c644bebc r4:c644bf04
>> [<bf019940>] (nodewrap_get_message+0x0/0x8c [bridgedriver]) from
>> [<bf018d94>] (wcd_call_dev_io_ctl+0xf8/0x120 [bridgedriver])
>> =C2=A0r5:00000040 r4:c644bf1c
>> [<bf018c9c>] (wcd_call_dev_io_ctl+0x0/0x120 [bridgedriver]) from
>> [<bf02a058>] (bridge_ioctl+0xac/0xcc [bridgedriver])
>> =C2=A0r6:421e7d64 r5:c004db48 r4:c6419f00 r3:c65bb500
>> [<bf029fac>] (bridge_ioctl+0x0/0xcc [bridgedriver]) from [<c0113eb4>=
]
>> (vfs_ioctl+0x34/0xb4)
>> =C2=A0r6:421e7d64 r5:bf029fac r4:c6419f00
>> [<c0113e80>] (vfs_ioctl+0x0/0xb4) from [<c01142b8>] (do_vfs_ioctl+0x=
1c4/0x1e0)
>> =C2=A0r7:00000005 r6:c004db48 r5:421e7d64 r4:421e7d64
>> [<c01140f4>] (do_vfs_ioctl+0x0/0x1e0) from [<c0114314>] (sys_ioctl+0=
x40/0x64)
>> =C2=A0r4:c6419f00
>> [<c01142d4>] (sys_ioctl+0x0/0x64) from [<c003cfc0>] (ret_fast_syscal=
l+0x0/0x38)
>> =C2=A0r7:00000036 r6:0006ef10 r5:4055d860 r4:0006a000
>>
>> I'll try to rebase the patches to the latest head.
>
> Nope, didn't help. I've put the updated patches here:
> http://people.freedesktop.org/~felipec/dspbridge/

Oops! Disregard that. I wasn't updating the uImage =3D/

The patches seem to work fine.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
