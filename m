From: Sergey Lapin <slapinid@gmail.com>
Subject: Re: MUSB crash on OMAP3 board with second load of gadget
Date: Fri, 22 Jan 2010 17:07:42 +0300
Message-ID: <48239d391001220607j666e7759y7e8ac393792bdab3@mail.gmail.com>
References: <48239d391001210326y25986d59hd10d390ef9c8ddea@mail.gmail.com>
	 <20100121122839.GB26015@nokia.com>
	 <48239d391001210523l5762775dm8382ad82e7b10e4a@mail.gmail.com>
	 <48239d391001210816n7dd469acr920be41e98129cb4@mail.gmail.com>
	 <20100121162437.GC3628@gandalf>
	 <48239d391001210932w5523cc4ajc3b5459966ab395e@mail.gmail.com>
	 <48239d391001220238r151c4dfbjd8f6e7863718dad8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754277Ab0AVOHr@vger.kernel.org>
In-Reply-To: <48239d391001220238r151c4dfbjd8f6e7863718dad8@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: me@felipebalbi.com
Cc: felipe.balbi@nokia.com, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Brownell <dbrownell@users.sourceforge.net>
List-Id: linux-omap@vger.kernel.org

0 at 1:38 PM, Sergey Lapin <slapinid@gmail.com> wrote:
> Hi,
>
>> [ =A0580.082427] [<c0030ac4>] (__irq_svc+0x44/0xa8) from [<c00420dc>=
]
>> (omap3_enter_idle+0x124/0x158)
>> [ =A0580.091186] [<c00420dc>] (omap3_enter_idle+0x124/0x158) from
>> [<c022d708>] (cpuidle_idle_call+0xa4/0x180)
>> [ =A0580.100738] [<c022d708>] (cpuidle_idle_call+0xa4/0x180) from
>> [<c00324dc>] (cpu_idle+0x48/0x98)
>> [ =A0580.109436] [<c00324dc>] (cpu_idle+0x48/0x98) from [<c0008934>]
>> (start_kernel+0x268/0x2c8)
>> [ =A0580.117767] [<c0008934>] (start_kernel+0x268/0x2c8) from
>> [<80008034>] (0x80008034)
>> [ =A0580.125366] Code: c03a876b e92d4013 e5903004 e1a04000 (e593c000=
)
>> [ =A0580.131652] ---[ end trace 42b8f4f7e396999c ]---
>> [ =A0580.136291] Kernel panic - not syncing: Fatal exception in inte=
rrupt
>>
>
> I've managed to debug that in my case,
> drivers/usb/musb/musb_gadget_ep0.c:
> musb_read_setup():
> =A0 =A0 =A0 =A0/* clean up any leftover transfers */
> =A0 =A0 =A0 =A0r =3D next_ep0_request(musb);
> in this place we have somewhat corrupted usb_request. Any ideas why?
>
> By the way, crash is not reproduced if cable is removed before module=
 unloading
> (and all USB activity processed).
>
> S.
>

Is this panic looks like list corruption bug which was mentioned earlie=
r?
with my new test script I get these panic messages with the same freque=
ncy
as 6b6b6b6b ones.

If I understand right, 6b6b6b6b =3D slab corruption, and 00200200 =3D
LIST_POISON2, which means list corruption.

[  275.079284] Unable to handle kernel paging request at virtual
address 00200200
[  275.086578] pgd =3D c0004000
[  275.089294] [00200200] *pgd=3D00000000
[  275.092895] Internal error: Oops: 5 [#1] PREEMPT
[  275.097534] last sysfs file: /sys/module/musb_hdrc/parameters/debug
[  275.103851] Modules linked in: g_mass_storage [last unloaded: g_mass=
_storage]
[  275.111053] CPU: 0    Not tainted  (2.6.33-rc5-07242-gb226820-dirty =
#14)
[  275.117828] PC is at list_del+0xc/0x90
[  275.121582] LR is at musb_g_giveback+0x20/0x118
[  275.126159] pc : [<c01b71cc>]    lr : [<c021daa4>]    psr: 200001d3
[  275.126159] sp : c03f7db0  ip : 00074df4  fp : c7832048
[  275.137725] r10: fa0ab000  r9 : fa0ab100  r8 : fa0ab100
[  275.142974] r7 : 00000001  r6 : c7832064  r5 : 00000000  r4 : c718c6=
18
[  275.149536] r3 : 00200200  r2 : 00000000  r1 : c718c600  r0 : c718c6=
18
[  275.156097] Flags: nzCv  IRQs off  FIQs off  Mode SVC_32  ISA ARM
Segment kernel
[  275.163635] Control: 10c5387d  Table: 8725c019  DAC: 00000017
[  275.169403] Process swapper (pid: 0, stack limit =3D 0xc03f62e8)
[  275.175292] Stack: (0xc03f7db0 to 0xc03f8000)
[  275.179687] 7da0:                                     c718c618
c718c600 c718c600 c021daa4
[  275.187896] 7dc0: c7832048 c02f10dc c03affcf c03f7ddc c718c618
c718c600 00000000 c7832000
[  275.196136] 7de0: 00000001 c021c3c4 00000006 00000100 00000000
00000040 c03f6000 06800099
[  275.204376] 7e00: 00000100 00000040 00000000 00000000 000000f0
c7832000 00000008 00000099
[  275.212615] 7e20: 00000000 00000000 00000000 c021b4f0 00000008
00000001 00000000 00000000
[  275.220855] 7e40: c7832000 60000153 0000005c c03f6000 0000005c
c021b628 c78bdc80 c78bdc80
[  275.229095] 7e60: 0000005c c0090d58 c78bdc80 c04099cc 0000005c
00000104 00000103 c03f6000
[  275.237304] 7e80: 00000002 c0092e1c 0000005c c03f7f40 00000000
c0030070 ffffffff fa200000
[  275.245544] 7ea0: 00000000 c0030ac4 00000000 00000003 00000000
c0436700 0000005c c03f6000
[  275.253784] 7ec0: 00000000 00000002 00000001 0000000a 00000002
00000000 00074c9f c03f7ef0
[  275.262023] 7ee0: c0063e28 c0063e40 20000153 ffffffff c78bdc80
c78bdc80 0000005c 00000000
[  275.270263] 7f00: c78bdc80 0000005c 00000000 00000003 00000002
00000001 c03f6000 0000001f
[  275.278472] 7f20: 00000000 c006401c 0000005c c0030074 ffffffff
fa200000 00000003 c0030ac4
[  275.286743] 7f40: 002e19b8 00000000 002e19b8 00000000 c04316b4
00000003 00000003 c04316b4
[  275.294982] 7f60: 800273e0 411fc082 0000001f 00000000 00000000
c03f7f88 c00420ec c00420f8
[  275.303222] 7f80: 60000053 ffffffff 00000000 002e19b8 386d712e
178b0dd5 386d712e 175cf41d
[  275.311462] 7fa0: c03fbd50 c03fbe20 c0430cdc c03fbd50 c0476b48
c022d93c c03f6000 c0430cdc
[  275.319702] 7fc0: c0029014 c03f9c10 800273e0 c00324dc c045c9c0
c0008934 c000848c 00000000
[  275.327911] 7fe0: 00000000 c0029018 00000000 10c53c7d c0430df0
80008034 00000000 00000000
[  275.336181] [<c01b71cc>] (list_del+0xc/0x90) from [<c021daa4>]
(musb_g_giveback+0x20/0x118)
[  275.344573] [<c021daa4>] (musb_g_giveback+0x20/0x118) from
[<c021c3c4>] (musb_g_ep0_irq+0x358/0x940)
[  275.353790] [<c021c3c4>] (musb_g_ep0_irq+0x358/0x940) from
[<c021b4f0>] (musb_interrupt+0x2fc/0x3d4)
[  275.362976] [<c021b4f0>] (musb_interrupt+0x2fc/0x3d4) from
[<c021b628>] (generic_interrupt+0x60/0x94)
[  275.372283] [<c021b628>] (generic_interrupt+0x60/0x94) from
[<c0090d58>] (handle_IRQ_event+0xa4/0x1e0)
[  275.381652] [<c0090d58>] (handle_IRQ_event+0xa4/0x1e0) from
[<c0092e1c>] (handle_level_irq+0xc0/0x150)
[  275.391052] [<c0092e1c>] (handle_level_irq+0xc0/0x150) from
[<c0030070>] (asm_do_IRQ+0x70/0x90)
[  275.399810] [<c0030070>] (asm_do_IRQ+0x70/0x90) from [<c0030ac4>]
(__irq_svc+0x44/0xa8)
[  275.407867] Exception stack(0xc03f7ea8 to 0xc03f7ef0)
[  275.412933] 7ea0:                   00000000 00000003 00000000
c0436700 0000005c c03f6000
[  275.421173] 7ec0: 00000000 00000002 00000001 0000000a 00000002
00000000 00074c9f c03f7ef0
[  275.429412] 7ee0: c0063e28 c0063e40 20000153 ffffffff
[  275.434509] [<c0030ac4>] (__irq_svc+0x44/0xa8) from [<c0063e40>]
(__do_softirq+0x54/0x1e8)
[  275.442840] [<c0063e40>] (__do_softirq+0x54/0x1e8) from
[<c006401c>] (irq_exit+0x48/0x9c)
[  275.451080] [<c006401c>] (irq_exit+0x48/0x9c) from [<c0030074>]
(asm_do_IRQ+0x74/0x90)
[  275.459045] [<c0030074>] (asm_do_IRQ+0x74/0x90) from [<c0030ac4>]
(__irq_svc+0x44/0xa8)
[  275.467102] Exception stack(0xc03f7f40 to 0xc03f7f88)
[  275.472198] 7f40: 002e19b8 00000000 002e19b8 00000000 c04316b4
00000003 00000003 c04316b4
[  275.480438] 7f60: 800273e0 411fc082 0000001f 00000000 00000000
c03f7f88 c00420ec c00420f8
[  275.488647] 7f80: 60000053 ffffffff
[  275.492187] [<c0030ac4>] (__irq_svc+0x44/0xa8) from [<c00420f8>]
(omap3_enter_idle+0x124/0x15c)
[  275.500976] [<c00420f8>] (omap3_enter_idle+0x124/0x15c) from
[<c022d93c>] (cpuidle_idle_call+0xa4/0x180)
[  275.510528] [<c022d93c>] (cpuidle_idle_call+0xa4/0x180) from
[<c00324dc>] (cpu_idle+0x48/0x98)
[  275.519195] [<c00324dc>] (cpu_idle+0x48/0x98) from [<c0008934>]
(start_kernel+0x268/0x2c8)
[  275.527526] [<c0008934>] (start_kernel+0x268/0x2c8) from
[<80008034>] (0x80008034)
[  275.535156] Code: c03a8a50 e92d4013 e5903004 e1a04000 (e593c000)
[  275.541381] ---[ end trace f41fd6e0efe3feba ]---
[  275.546020] Kernel panic - not syncing: Fatal exception in interrupt
