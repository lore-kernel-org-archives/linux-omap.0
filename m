From: Andrushka <stanv@altlinux.ru>
Subject: Change ARM core rate.
Date: Mon, 31 Jan 2011 11:11:25 +0300
Message-ID: <AANLkTimXNnxyG7V-bckTWHniY1w8646DYcj_SjOgXqUP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:60580 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751616Ab1AaIL0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 31 Jan 2011 03:11:26 -0500
Received: by yxt3 with SMTP id 3so1861745yxt.19
        for <linux-omap@vger.kernel.org>; Mon, 31 Jan 2011 00:11:26 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello.

I have Davinci DM365 board, but I can't find more suitable
mail-listing to ask my qustion.

I have written Linux kernel module.
Main purpose: change ARM core rate.
Davinci DM365 has two PLL: PLL1 and PLL2.

ARM core can be feed by:
* PLLC1SYSCLK1 - fixed all time, equal to 243000 kHz.
* PLLC2SYSCLK2 - that one I can change.

Lower borde ARM core freq =3D=3D 121500 kHz (must be > pll1_sysclk4 CFG=
/DMA bus).
Higher borde ARM core freq =3D=3D 300000 kHz.

To change ARM core freq I do next steps:
1. switch ARM core to PLLC2SYSCLK2
2. reset & configure PLL2.
3. switch back to PLLC2SYSCLK2.
4. call adjust_jiffies() ( snatch from cpufreq.c)

Now I come to standstill.

I got several working configurations, and several not working.
I can't undestand why some of them works, and some not.

Stable work. Switch between next rates work all times:
272000 (kHz), mul=3D17, div=3D2
204000 (kHz), mul=3D17, div=3D3
252000 (kHz), mul=3D21, div=3D3
201600 (kHz), mul=3D21, div=3D4
200000 (kHz), mul=3D25, div=3D5
249600 (kHz), mul=3D26, div=3D4
259200 (kHz), mul=3D27, div=3D4
268800 (kHz), mul=3D28, div=3D4
278400 (kHz), mul=3D29, div=3D4
232000 (kHz), mul=3D29, div=3D5
205714 (kHz), mul=3D30, div=3D6
297600 (kHz), mul=3D31, div=3D4
248000 (kHz), mul=3D31, div=3D5
212571 (kHz), mul=3D31, div=3D6
186000 (kHz), mul=3D31, div=3D7

Don't work - (completely instantaneously hang system):

144000 (kHz), mul=3D3, div=3D0
180000 (kHz), mul=3D15, div=3D3
136000 (kHz), mul=3D17, div=3D5
126000 (kHz), mul=3D21, div=3D7
157714 (kHz), mul=3D23, div=3D6
171428 (kHz), mul=3D25, div=3D6
133333 (kHz), mul=3D25, div=3D8
178285 (kHz), mul=3D26, div=3D6
162000 (kHz), mul=3D27, div=3D7
174000 (kHz), mul=3D29, div=3D7
165333 (kHz), mul=3D31, div=3D8
158400 (kHz), mul=3D33, div=3D9
296000 (kHz), mul=3D37, div=3D5
203076 (kHz), mul=3D55, div=3D12
299076 (kHz), mul=3D81, div=3D12

Can anybody comment this behaviour?


If frequency =3D=3D 222 000 kHz than system behave quite unstable.
And give next messages:


Backtrace:
=D0=93=E2=80=9E<c0074c9c>=D0=93=D1=9A (add_to_page_cache_lru+0x0/0xac) =
from =D0=93=E2=80=9E<c0074dbc>=D0=93=D1=9A
(grab_cache_page_write_begin+0x74/0x9c)
 r5:c46d4268 r4:c03dc480
=D0=93=E2=80=9E<c0074d48>=D0=93=D1=9A (grab_cache_page_write_begin+0x0/=
0x9c) from
=D0=93=E2=80=9E<c00f35b8>=D0=93=D1=9A (ext3_write_begin+0x80/0x240)
=D0=93=E2=80=9E<c00f3538>=D0=93=D1=9A (ext3_write_begin+0x0/0x240) from=
 =D0=93=E2=80=9E<c0073d10>=D0=93=D1=9A
(generic_file_buffered_write+0xf0/0x258)
=D0=93=E2=80=9E<c0073c20>=D0=93=D1=9A (generic_file_buffered_write+0x0/=
0x258) from
=D0=93=E2=80=9E<c0075e64>=D0=93=D1=9A (__generic_file_aio_write+0x4a8/0=
x4f8)
=D0=93=E2=80=9E<c00759bc>=D0=93=D1=9A (__generic_file_aio_write+0x0/0x4=
f8) from
=D0=93=E2=80=9E<c0075f28>=D0=93=D1=9A (generic_file_aio_write+0x74/0xdc=
)
=D0=93=E2=80=9E<c0075eb4>=D0=93=D1=9A (generic_file_aio_write+0x0/0xdc)=
 from =D0=93=E2=80=9E<c009dc1c>=D0=93=D1=9A
(do_sync_readv_writev+0x98/0xe4)
=D0=93=E2=80=9E<c009db84>=D0=93=D1=9A (do_sync_readv_writev+0x0/0xe4) f=
rom =D0=93=E2=80=9E<c009e2e4>=D0=93=D1=9A
(do_readv_writev+0xb4/0x190)
=D0=93=E2=80=9E<c009e230>=D0=93=D1=9A (do_readv_writev+0x0/0x190) from =
=D0=93=E2=80=9E<c009e42c>=D0=93=D1=9A
(vfs_writev+0x6c/0x7c)
=D0=93=E2=80=9E<c009e3c0>=D0=93=D1=9A (vfs_writev+0x0/0x7c) from =D0=93=
=E2=80=9E<c009e510>=D0=93=D1=9A (sys_writev+0x44/0x70)
 r5:00000000 r4:0030063f
=D0=93=E2=80=9E<c009e4cc>=D0=93=D1=9A (sys_writev+0x0/0x70) from =D0=93=
=E2=80=9E<c0028f60>=D0=93=D1=9A
(ret_fast_syscall+0x0/0x2c)


Backtrace:
=D0=93=E2=80=9E<c002c2a4>=D0=93=D1=9A (dump_backtrace+0x0/0x10c) from =D0=
=93=E2=80=9E<c029d478>=D0=93=D1=9A
(dump_stack+0x18/0x1c)
 r7:00000000 r6:c3446738 r5:00017000 r4:00000000
=D0=93=E2=80=9E<c029d460>=D0=93=D1=9A (dump_stack+0x0/0x1c) from =D0=93=
=E2=80=9E<c0036c74>=D0=93=D1=9A
(__schedule_bug+0x54/0x60)
=D0=93=E2=80=9E<c0036c20>=D0=93=D1=9A (__schedule_bug+0x0/0x60) from =D0=
=93=E2=80=9E<c029d6ec>=D0=93=D1=9A
(schedule+0x68/0x3c4)
 r4:c34bed4c
=D0=93=E2=80=9E<c029d684>=D0=93=D1=9A (schedule+0x0/0x3c4) from =D0=93=E2=
=80=9E<c00370b8>=D0=93=D1=9A
(__cond_resched+0x18/0x24)
=D0=93=E2=80=9E<c00370a0>=D0=93=D1=9A (__cond_resched+0x0/0x24) from =D0=
=93=E2=80=9E<c029db58>=D0=93=D1=9A
(_cond_resched+0x30/0x40)
=D0=93=E2=80=9E<c029db28>=D0=93=D1=9A (_cond_resched+0x0/0x40) from =D0=
=93=E2=80=9E<c008b0ec>=D0=93=D1=9A
(unmap_vmas+0x5d8/0x6a0)
=D0=93=E2=80=9E<c008ab14>=D0=93=D1=9A (unmap_vmas+0x0/0x6a0) from =D0=93=
=E2=80=9E<c008dd68>=D0=93=D1=9A (exit_mmap+0xd4/0x208)
=D0=93=E2=80=9E<c008dc94>=D0=93=D1=9A (exit_mmap+0x0/0x208) from =D0=93=
=E2=80=9E<c003be60>=D0=93=D1=9A (mmput+0x40/0xf0)
 r8:00000000 r7:c34bec34 r6:c3442320 r5:00000000 r4:c34bec00
=D0=93=E2=80=9E<c003be20>=D0=93=D1=9A (mmput+0x0/0xf0) from =D0=93=E2=80=
=9E<c0040144>=D0=93=D1=9A (exit_mm+0x124/0x130)
 r5:c34bec00 r4:00000000
=D0=93=E2=80=9E<c0040020>=D0=93=D1=9A (exit_mm+0x0/0x130) from =D0=93=E2=
=80=9E<c0041bec>=D0=93=D1=9A (do_exit+0x190/0x65c)
 r7:c49c3bd8 r6:c3442320 r5:c3442320 r4:0000000b
=D0=93=E2=80=9E<c0041a5c>=D0=93=D1=9A (do_exit+0x0/0x65c) from =D0=93=E2=
=80=9E<c002c7e0>=D0=93=D1=9A (die+0x1c4/0x1f4)
=D0=93=E2=80=9E<c002c61c>=D0=93=D1=9A (die+0x0/0x1f4) from =D0=93=E2=80=
=9E<c002c858>=D0=93=D1=9A (bad_mode+0x48/0x70)
=D0=93=E2=80=9E<c002c810>=D0=93=D1=9A (bad_mode+0x0/0x70) from =D0=93=E2=
=80=9E<c00744f8>=D0=93=D1=9A (find_get_page+0x30/0xb0)
 r4:c03dc480
BUG: scheduling while atomic: syslogd/1411/0x40000002


Main question is:
Why some frequencies are stable, and other does not?
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
