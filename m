From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: omapdss wakeup issues
Date: Wed, 6 Mar 2013 10:16:31 +0100
Message-ID: <CABuKBeJY8gRUQAVsFf3PZ7SUf1DArOpo4XXAX-B=5c8WohyzjA@mail.gmail.com>
References: <CALbNGRThXXuSE9Q9h7rcSHYm_s4nUcdGjC-xRFD23f0-Ncy3-w@mail.gmail.com>
	<CALbNGRT_brQi11s+FxDHm_pfeM2HnMAUcxrtGDrG9MQ-KyL-+A@mail.gmail.com>
	<CALbNGRSDEYuSKrPvo3pXa85YOTmq3+qJNnzhwPAuE1A5cj4xvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:55431 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755186Ab3CFJQd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Mar 2013 04:16:33 -0500
Received: by mail-wg0-f44.google.com with SMTP id dr12so6968562wgb.11
        for <linux-omap@vger.kernel.org>; Wed, 06 Mar 2013 01:16:32 -0800 (PST)
In-Reply-To: <CALbNGRSDEYuSKrPvo3pXa85YOTmq3+qJNnzhwPAuE1A5cj4xvg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?ISO-8859-1?Q?Andreas_M=FCller?= <schnitzeltony@googlemail.com>
Cc: linux-omap@vger.kernel.org

2013/3/5 Andreas M=FCller <schnitzeltony@googlemail.com>:
> On Fri, Mar 1, 2013 at 10:07 PM, Andreas M=FCller
> <schnitzeltony@googlemail.com> wrote:
>> On Thu, Feb 28, 2013 at 5:27 PM, Andreas M=FCller
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

It happens on DM3730 right now as well.
That's bad news.
When I was working on the problem I read this discussion, maybe it can =
help you:
http://thread.gmane.org/gmane.linux.ports.arm.omap/76021/focus=3D76030

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
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
---
motzblog.wordpress.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
