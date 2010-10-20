From: Robert Nelson <robertcnelson@gmail.com>
Subject: Re: DSS2 crash with shutdown -h now
Date: Wed, 20 Oct 2010 08:02:44 -0500
Message-ID: <AANLkTimG_5W8Y58f7hvxM2iH2FGxJ3DNgv3JNi5WMye8@mail.gmail.com>
References: <AANLkTinjRuVx+vi4Pq6pnVLfizB6AKdmGDtRzwbq+d1g@mail.gmail.com>
	<FCCFB4CDC6E5564B9182F639FC356087034BB014BE@dbde02.ent.ti.com>
	<AANLkTimBhCoWNQ4BmC6ytbS99YBGQsgJH8X6NN+B489u@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:49920 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751177Ab0JTNCr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Oct 2010 09:02:47 -0400
Received: by eyx24 with SMTP id 24so827603eyx.19
        for <linux-omap@vger.kernel.org>; Wed, 20 Oct 2010 06:02:45 -0700 (PDT)
In-Reply-To: <AANLkTimBhCoWNQ4BmC6ytbS99YBGQsgJH8X6NN+B489u@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, Oct 20, 2010 at 7:44 AM, Steve Sakoman <sakoman@gmail.com> wrot=
e:
> On Tue, Oct 19, 2010 at 9:42 PM, Taneja, Archit <archit@ti.com> wrote=
:
>> Hi,
>>
>> linux-omap-owner@vger.kernel.org wrote:
>>> I'm using a 2.6.35 kernel, and the generic panel driver.
>>>
>>> I see this crash about 25% of the time, so I suspect a race conditi=
on.
>>>
>>> Is anyone else encountering this?
>>>
>>> Steve
>>>
>>>
>>> Unmounting local filesystems...
>>> Unhandled fault: external abort on non-linefetch (0x1028) at
>>> 0xfa050040 Internal error: : 1028 [#1] last sysfs file:
>>> /sys/devices/virtual/vc/vcs12/uevent
>>> Modules linked in: ipv6 uvcvideo videodev v4l1_compat ads7846
>>> CPU: 0 =A0 =A0Not tainted =A0(2.6.35 #1)
>>> PC is at dss_select_dispc_clk_source+0x20/0x40
>>> LR is at omapdss_dpi_display_disable+0x20/0x50
>>> pc : [<c01f74d4>] =A0 =A0lr : [<c01ffc80>] =A0 =A0psr: 60000013
>>> sp : ded59e38 =A0ip : 00000090 =A0fp : 00000001
>>> r10: 00000001 =A0r9 : ded58000 =A0r8 : c0032084
>>> r7 : ded59e50 =A0r6 : 00000000 =A0r5 : c01fcc28 =A0r4 : c057da00
>>> r3 : 00000000 =A0r2 : fa050000 =A0r1 : c05d062c =A0r0 : 00000002
>>> Flags: nZCv =A0IRQs on =A0FIQs on =A0Mode SVC_32 =A0ISA ARM =A0Segm=
ent user
>>> Control: 10c5387d =A0Table: 9ed84019 =A0DAC: 00000015 Process
>>> halt (pid: 503, stack limit =3D 0xded582f0)
>>> Stack: (0xded59e38 to 0xded5a000)
>>> 9e20:
>>> c057da00 c020a430
>>> 9e40: 00000000 c01fcc48 ded59e50 c022f424 dfc3fc78 dfccc170
>>> dfe02400 c057d4cc
>>> 9e60: c057d4c0 c05d4fac 00000000 c0230ba4 c0575de0 c022c6f8 2812196=
9 cdef0123
>>> 9e80: fee1dead c0065d58 28121969 c0065ed4 00000014 dfc17dd8 0000000=
1 dfc299c0
>>> 9ea0: 00000000 ded59eb0 c0062ee4 c00546f0 000a4800 a0000013 0000000=
0 ded59f08
>>> 9ec0: 00000001 00000014 ded58000 00000001 00000001 c0063068 0000000=
0 ded59f08
>>> 9ee0: dfc299c0 dfc18500 ded59f08 00000014 ded58000 c0063cb8 0000000=
1 00000000
>>> 9f00: 00000006 c0063d2c 00000014 00000164 00000000 000001f7 0000000=
0 dfc299f8
>>> 9f20: 00000164 dfc299f0 c057f598 00000000 00000000 fffffffd 0000000=
0 c006e810
>>> 9f40: ded59f6c 00000000 dfc299c0 c0052fbc dfc299c0 dff16e00
>>> dec41080 dec92540
>>> 9f60: ded59fac ded59f70 c03e841c c0052f90 ffffff9c c0031f58
>>> dec927a8 ded58000
>>> 9f80: 00000000 00000000 00000000 00000006 00000025 00000000 0000000=
0 00000006
>>> 9fa0: 00000058 c0031f00 00000000 00000000 fee1dead 28121969 4321fed=
c 00000000
>>> 9fc0: 00000000 00000000 00000006 00000058 00000001 00000001 0000000=
1 00000001
>>> 9fe0: 00011e50 bef36cb0 0000925c 400e23f8 20000010 fee1dead
>>> 00000000 00000000 [<c01f74d4>]
>>> (dss_select_dispc_clk_source+0x20/0x40) from [<c01ffc80>]
>>> (omapdss_dpi_display_disable+0x20/0x50)
>>> [<c01ffc80>] (omapdss_dpi_display_disable+0x20/0x50) from [<c020a43=
0>]
>>> (generic_panel_disable+0xc/0x18)
>>> [<c020a430>] (generic_panel_disable+0xc/0x18) from [<c01fcc48>]
>>> (dss_disable_device+0x20/0x2c)
>>> [<c01fcc48>] (dss_disable_device+0x20/0x2c) from [<c022f424>]
>>> (bus_for_each_dev+0x4c/0x8c) [<c022f424>] (bus_for_each_dev+0x4c/0x=
8c) from
>>> [<c0230ba4>] (platform_drv_shutdown+0x1c/0x24)
>>> [<c0230ba4>] (platform_drv_shutdown+0x1c/0x24) from [<c022c6f8>]
>>> (device_shutdown+0x70/0x94) [<c022c6f8>] (device_shutdown+0x70/0x94=
) from
>>> [<c0065d58>] (kernel_halt+0x10/0x2c) [<c0065d58>] (kernel_halt+0x10=
/0x2c)
>>> from [<c0065ed4>] (sys_reboot+0x118/0x1dc) [<c0065ed4>]
>>> (sys_reboot+0x118/0x1dc) from [<c0031f00>]
>>> (ret_fast_syscall+0x0/0x30)
>>> Code: e5833000 eafffffd e59f101c e5912000 (e5923040)
>>> OMAPFB: pan_display(0)
>>> OMAPFB: setcmap
>>> OMAPFB: setcmap
>>> OMAPFB: setcmap
>>
>> Are you running a fb app while shutting down?
>
> My test method is to use a relatively minimal rootfs. =A0It does laun=
ch
> a console session on the fb using a USB KB on musb, which sits at the
> login prompt throughout the test. =A0I do not login via this console
> session.
>
> I login via serial port, wait till uptime reports 10 minutes, then
> issue 'shutdown -h now'

Hi Steve
10 minutes?

Sounds very much like: http://www.spinics.net/lists/linux-omap/msg34582=
=2Ehtml

*there might be a newer patch, that's just the one i had marked on my l=
ist..

Regards,

--=20
Robert Nelson
http://www.rcn-ee.com/
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
