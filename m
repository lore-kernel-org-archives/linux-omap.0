From: =?UTF-8?Q?Andreas_M=C3=BCller?= <schnitzeltony@googlemail.com>
Subject: Re: omapdss wakeup issues
Date: Mon, 11 Mar 2013 17:55:10 +0100
Message-ID: <CALbNGRSVc+Z6RKJQt5rXeV15iM+s0xxqcV6m1j58Hnq_D3B+qA@mail.gmail.com>
References: <CALbNGRThXXuSE9Q9h7rcSHYm_s4nUcdGjC-xRFD23f0-Ncy3-w@mail.gmail.com>
	<CALbNGRT_brQi11s+FxDHm_pfeM2HnMAUcxrtGDrG9MQ-KyL-+A@mail.gmail.com>
	<CALbNGRSDEYuSKrPvo3pXa85YOTmq3+qJNnzhwPAuE1A5cj4xvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vb0-f52.google.com ([209.85.212.52]:41822 "EHLO
	mail-vb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752646Ab3CKQzL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Mar 2013 12:55:11 -0400
Received: by mail-vb0-f52.google.com with SMTP id fa15so1736144vbb.39
        for <linux-omap@vger.kernel.org>; Mon, 11 Mar 2013 09:55:10 -0700 (PDT)
In-Reply-To: <CALbNGRSDEYuSKrPvo3pXa85YOTmq3+qJNnzhwPAuE1A5cj4xvg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

On Tue, Mar 5, 2013 at 7:44 PM, Andreas M=C3=BCller
<schnitzeltony@googlemail.com> wrote:
> On Fri, Mar 1, 2013 at 10:07 PM, Andreas M=C3=BCller
> <schnitzeltony@googlemail.com> wrote:
>> On Thu, Feb 28, 2013 at 5:27 PM, Andreas M=C3=BCller
>> <schnitzeltony@googlemail.com> wrote:
>>> Hi,
>>>
>>> I am preparing 3.8 mainline for gumstix overo and have the followin=
g
>>> issue: waking Monitor connected by HDMI from power save makes Monit=
or
>>> complain for unsupported frequency and console says:
>>>
>>> | omapdss APPLY error: FIFO UNDERFLOW on gfx, disabling the overlay
>>>
>>> Is this a known issue?
>>>
>> Sorry for the noise but this is the only issue I have with 3.8.1
>> stable (currently). Some further notes:
>>
>> * with old OMAP 3530 (only 600MHz capable) the HDMI does not work fo=
r
>> warm restart and not for pressing reset. The only way out is power-o=
ff
>> / power on. This I saw with 3.6 the first time but I did not follow =
it
>> at that time.
>> * My kernel command line is
>>     console=3DttyO2,115200n8 mpurate=3D800 vram=3D12M
>> omapfb.mode=3Ddvi:1280x1024MR-24@60 omapdss.def_disp=3Ddvi
>> root=3D/dev/mmcblk0p2 rw rootfstype=3Dext4 rootwait
>>  I added omapdss.debug=3Dy and omapdss.debug=3D1 but that did give m=
e
>> further information. Are there other settings available helping to
>> debug this?
>> * I attached kernel config and bootlog for proper start - maybe this
>> gives some hint.
>> * Monitor power down is caused by XFCE power management
>>
>> Is there any other information I can give to solve this?
>>
> FWIW DM3730 (Overo fire storm) the wakeup causes some additional warn=
ing
>
> omapdss APPLY error: FIFO UNDERFLOW on gfx, disabling the overlay
> ------------[ cut here ]------------
> WARNING: at drivers/video/omap2/dss/dispc.c:543 dispc_mgr_go+0x20/0x5=
4()
> Modules linked in: libertas_sdio libertas lib80211 cfg80211 rfkill
> ads7846 gpio_keys
> [<c001254c>] (unwind_backtrace+0x0/0xe0) from [<c002e7fc>]
> (warn_slowpath_common+0x4c/0x64)
> [<c002e7fc>] (warn_slowpath_common+0x4c/0x64) from [<c002e82c>]
> (warn_slowpath_null+0x18/0x1c)
> [<c002e82c>] (warn_slowpath_null+0x18/0x1c) from [<c0370cc0>]
> (dispc_mgr_go+0x20/0x54)
> [<c0370cc0>] (dispc_mgr_go+0x20/0x54) from [<c037a900>]
> (dispc_error_worker+0x6c/0x18c)
> [<c037a900>] (dispc_error_worker+0x6c/0x18c) from [<c004667c>]
> (process_one_work+0x1fc/0x3dc)
> [<c004667c>] (process_one_work+0x1fc/0x3dc) from [<c0046c08>]
> (worker_thread+0x238/0x34c)
> [<c0046c08>] (worker_thread+0x238/0x34c) from [<c004ad08>] (kthread+0=
xa0/0xb0)
> [<c004ad08>] (kthread+0xa0/0xb0) from [<c000d938>] (ret_from_fork+0x1=
4/0x3c)
> ---[ end trace 40fcd9df3dd2aaf5 ]---
>
> Andreas

=46WIW taken on  DM3730 @ 800MHz

1. All OK
root@overo:~# cat /sys/kernel/debug/omapdss/dispc_irq
period 34640 ms
irqs 0
=46RAMEDONE                     0
VSYNC                         0
EVSYNC_EVEN                   0
EVSYNC_ODD                    0
ACBIAS_COUNT_STAT             0
PROG_LINE_NUM                 0
GFX_FIFO_UNDERFLOW            0
GFX_END_WIN                   0
PAL_GAMMA_MASK                0
OCP_ERR                       0
VID1_FIFO_UNDERFLOW           0
VID1_END_WIN                  0
VID2_FIFO_UNDERFLOW           0
VID2_END_WIN                  0
SYNC_LOST                     0
SYNC_LOST_DIGIT               0
WAKEUP                        0

2. Monitor off
cat /sys/kernel/debug/omapdss/dispc_irq
period 652843 ms
irqs 1
=46RAMEDONE                     1
VSYNC                         1
EVSYNC_EVEN                   0
EVSYNC_ODD                    0
ACBIAS_COUNT_STAT             0
PROG_LINE_NUM                 1
GFX_FIFO_UNDERFLOW            0
GFX_END_WIN                   1
PAL_GAMMA_MASK                0
OCP_ERR                       0
VID1_FIFO_UNDERFLOW           0
VID1_END_WIN                  0
VID2_FIFO_UNDERFLOW           0
VID2_END_WIN                  0
SYNC_LOST                     0
SYNC_LOST_DIGIT               0
WAKEUP                        1

3. Wakeup

root@overo:~# omapdss APPLY error: FIFO UNDERFLOW on gfx, disabling the=
 overlay
cat /sys/kernel/debug/omapdss/dispc_irq
period 42140 ms
irqs 1
=46RAMEDONE                     0
VSYNC                         0
EVSYNC_EVEN                   0
EVSYNC_ODD                    0
ACBIAS_COUNT_STAT             0
PROG_LINE_NUM                 1
GFX_FIFO_UNDERFLOW            1
GFX_END_WIN                   0
PAL_GAMMA_MASK                0
OCP_ERR                       0
VID1_FIFO_UNDERFLOW           0
VID1_END_WIN                  0
VID2_FIFO_UNDERFLOW           0
VID2_END_WIN                  0
SYNC_LOST                     0
SYNC_LOST_DIGIT               0
WAKEUP                        0

Is there some other information which might be helpful to solve this?

Andreas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
