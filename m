From: =?UTF-8?Q?Ezequiel_Garc=C3=ADa?= <ezequiel@vanguardiasur.com.ar>
Subject: Re: [RFC/PATCH] usb: musb: Prevent musb_am335x from being removed
Date: Mon, 30 Jun 2014 15:50:23 -0300
Message-ID: <CAAEAJfDRUMCWJuWqaDprfBQS8j_e+L6nT02ieJ6JcehOO=5_Eg@mail.gmail.com>
References: <1399570060-28939-1-git-send-email-ezequiel@vanguardiasur.com.ar>
	<20140630184426.GU31442@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yh0-f51.google.com ([209.85.213.51]:53698 "EHLO
	mail-yh0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751264AbaF3SuY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Jun 2014 14:50:24 -0400
Received: by mail-yh0-f51.google.com with SMTP id f10so5195657yha.10
        for <linux-omap@vger.kernel.org>; Mon, 30 Jun 2014 11:50:23 -0700 (PDT)
In-Reply-To: <20140630184426.GU31442@saruman.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: linux-usb@vger.kernel.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, =?UTF-8?Q?Guido_Mart=C3=ADnez?= <guido@vanguardiasur.com.ar>, Tony Lindgren <tony@atomide.com>, George Cherian <george.cherian@ti.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Yegor Yefremov <yegorslists@googlemail.com>

On 30 June 2014 15:44, Felipe Balbi <balbi@ti.com> wrote:
> Hi,
>
> On Thu, May 08, 2014 at 02:27:40PM -0300, Ezequiel Garcia wrote:
>> At probe time, the musb_am335x driver registers its childs by
>> calling of_platform_populate(), which registers all childs in
>> the devicetree hierarchy recursively.
>>
>> On the other side, the driver's remove() function uses of_device_unr=
egister()
>> to remove each child in the musb_am335x driver device struct.
>>
>> However, when musb_dsps is loaded, its devices are attached to the m=
usb_am335x
>> driver device struct as musb_am335x childs. Hence, musb_am335x remov=
e()
>> will attempt to unregister the devices registered by musb_dsps, whic=
h produces
>> a kernel panic.
>>
>> In other words, the childs in the "struct device" hierarchy are not =
the same
>> as the childs in the "devicetree" hierarchy.
>>
>> Ideally, we should be enforcing the removal of the devices registere=
d by
>> musb_am335x *only*, instead of all the child devices. However, becau=
se of the
>> recursive nature of of_platform_populate, this doesn't seem possible=
=2E
>>
>> Therefore, as the only solution at hand, this commit disables musb_a=
m335x driver
>> removal capability, preventing it from being ever removed.
>>
>> Just for reference, here's the panic upon module removal:
>>
>> musb-hdrc musb-hdrc.0.auto: remove, state 4
>> usb usb1: USB disconnect, device number 1
>> musb-hdrc musb-hdrc.0.auto: USB bus 1 deregistered
>> Unable to handle kernel NULL pointer dereference at virtual address =
0000008c
>> pgd =3D de11c000
>> [0000008c] *pgd=3D9e174831, *pte=3D00000000, *ppte=3D00000000
>> Internal error: Oops: 17 [#1] ARM
>> Modules linked in: musb_am335x(-) musb_dsps musb_hdrc usbcore usb_co=
mmon
>> CPU: 0 PID: 623 Comm: modprobe Not tainted 3.15.0-rc4-00001-g24efd13=
 #69
>> task: de1b7500 ti: de122000 task.ti: de122000
>> PC is at am335x_shutdown+0x10/0x28
>> LR is at am335x_shutdown+0xc/0x28
>> pc : [<c0327798>]    lr : [<c0327794>]    psr: a0000013
>> sp : de123df8  ip : 00000004  fp : 00028f00
>> r10: 00000000  r9 : de122000  r8 : c000e6c4
>> r7 : de0e3c10  r6 : de0e3800  r5 : de624010  r4 : de1ec750
>> r3 : de0e3810  r2 : 00000000  r1 : 00000001  r0 : 00000000
>> Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
>> Control: 10c5387d  Table: 9e11c019  DAC: 00000015
>> Process modprobe (pid: 623, stack limit =3D 0xde122240)
>> Stack: (0xde123df8 to 0xde124000)
>> 3de0:                                                       de0e3810=
 bf054488
>> 3e00: bf05444c de624010 60000013 bf043650 000012fc de624010 de0e3810=
 bf043a20
>> 3e20: de0e3810 bf04b240 c0635b88 c02ca37c c02ca364 c02c8db0 de1b7500=
 de0e3844
>> 3e40: de0e3810 c02c8e28 c0635b88 de02824c de0e3810 c02c884c de0e3800=
 de0e3810
>> 3e60: de0e3818 c02c5b20 bf05417c de0e3800 de0e3800 c0635b88 de0f2410=
 c02ca838
>> 3e80: bf05417c de0e3800 bf055438 c02ca8cc de0e3c10 bf054194 de0e3c10=
 c02ca37c
>> 3ea0: c02ca364 c02c8db0 de1b7500 de0e3c44 de0e3c10 c02c8e28 c0635b88=
 de02824c
>> 3ec0: de0e3c10 c02c884c de0e3c10 de0e3c10 de0e3c18 c02c5b20 de0e3c10=
 de0e3c10
>> 3ee0: 00000000 bf059000 a0000013 c02c5bc0 00000000 bf05900c de0e3c10=
 c02c5c48
>> 3f00: de0dd0c0 de1ec970 de0f2410 bf05929c de0f2444 bf05902c de0f2410=
 c02ca37c
>> 3f20: c02ca364 c02c8db0 bf05929c de0f2410 bf05929c c02c94c8 bf05929c=
 00000000
>> 3f40: 00000800 c02c8ab4 bf0592e0 c007fc40 c00dd820 6273756d 336d615f=
 00783533
>> 3f60: c064a0ac de1b7500 de122000 de1b7500 c000e590 00000001 c000e6c4=
 c0060160
>> 3f80: 00028e70 00028e70 00028ea4 00000081 60000010 00028e70 00028e70=
 00028ea4
>> 3fa0: 00000081 c000e500 00028e70 00028e70 00028ea4 00000800 becb59f8=
 00027608
>> 3fc0: 00028e70 00028e70 00028ea4 00000081 00000001 00000001 00000000=
 00028f00
>> 3fe0: b6e6b6f0 becb59d4 000160e8 b6e6b6fc 60000010 00028ea4 00000000=
 00000000
>> [<c0327798>] (am335x_shutdown) from [<bf054488>] (dsps_musb_exit+0x3=
c/0x4c [musb_dsps])
>> [<bf054488>] (dsps_musb_exit [musb_dsps]) from [<bf043650>] (musb_sh=
utdown+0x80/0x90 [musb_hdrc])
>> [<bf043650>] (musb_shutdown [musb_hdrc]) from [<bf043a20>] (musb_rem=
ove+0x24/0x68 [musb_hdrc])
>> [<bf043a20>] (musb_remove [musb_hdrc]) from [<c02ca37c>] (platform_d=
rv_remove+0x18/0x1c)
>> [<c02ca37c>] (platform_drv_remove) from [<c02c8db0>] (__device_relea=
se_driver+0x70/0xc8)
>> [<c02c8db0>] (__device_release_driver) from [<c02c8e28>] (device_rel=
ease_driver+0x20/0x2c)
>> [<c02c8e28>] (device_release_driver) from [<c02c884c>] (bus_remove_d=
evice+0xdc/0x10c)
>> [<c02c884c>] (bus_remove_device) from [<c02c5b20>] (device_del+0x104=
/0x198)
>> [<c02c5b20>] (device_del) from [<c02ca838>] (platform_device_del+0x1=
4/0x9c)
>> [<c02ca838>] (platform_device_del) from [<c02ca8cc>] (platform_devic=
e_unregister+0xc/0x20)
>> [<c02ca8cc>] (platform_device_unregister) from [<bf054194>] (dsps_re=
move+0x18/0x38 [musb_dsps])
>> [<bf054194>] (dsps_remove [musb_dsps]) from [<c02ca37c>] (platform_d=
rv_remove+0x18/0x1c)
>> [<c02ca37c>] (platform_drv_remove) from [<c02c8db0>] (__device_relea=
se_driver+0x70/0xc8)
>> [<c02c8db0>] (__device_release_driver) from [<c02c8e28>] (device_rel=
ease_driver+0x20/0x2c)
>> [<c02c8e28>] (device_release_driver) from [<c02c884c>] (bus_remove_d=
evice+0xdc/0x10c)
>> [<c02c884c>] (bus_remove_device) from [<c02c5b20>] (device_del+0x104=
/0x198)
>> [<c02c5b20>] (device_del) from [<c02c5bc0>] (device_unregister+0xc/0=
x20)
>> [<c02c5bc0>] (device_unregister) from [<bf05900c>] (of_remove_popula=
ted_child+0xc/0x14 [musb_am335x])
>> [<bf05900c>] (of_remove_populated_child [musb_am335x]) from [<c02c5c=
48>] (device_for_each_child+0x44/0x70)
>> [<c02c5c48>] (device_for_each_child) from [<bf05902c>] (am335x_child=
_remove+0x18/0x30 [musb_am335x])
>> [<bf05902c>] (am335x_child_remove [musb_am335x]) from [<c02ca37c>] (=
platform_drv_remove+0x18/0x1c)
>> [<c02ca37c>] (platform_drv_remove) from [<c02c8db0>] (__device_relea=
se_driver+0x70/0xc8)
>> [<c02c8db0>] (__device_release_driver) from [<c02c94c8>] (driver_det=
ach+0xb4/0xb8)
>> [<c02c94c8>] (driver_detach) from [<c02c8ab4>] (bus_remove_driver+0x=
4c/0xa0)
>> [<c02c8ab4>] (bus_remove_driver) from [<c007fc40>] (SyS_delete_modul=
e+0x128/0x1cc)
>> [<c007fc40>] (SyS_delete_module) from [<c000e500>] (ret_fast_syscall=
+0x0/0x48)
>>
>> Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
>
> can you send without RFC so it can be applied ?
>

=46elipe,

I already did on May 17th:

https://www.mail-archive.com/linux-omap@vger.kernel.org/msg105516.html

Then we agreed to send a new one to linux-usb; which I did on June 23rd=
:

https://www.mail-archive.com/linux-usb@vger.kernel.org/msg44347.html

I guess it's my bad for not putting proper patch v1, v2 information som=
ewhere.

Sorry about that,
--=20
Ezequiel Garc=C3=ADa, VanguardiaSur
www.vanguardiasur.com.ar
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
