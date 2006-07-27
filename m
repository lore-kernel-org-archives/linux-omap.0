From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: JTAG halt produces straneg message on terminal - OSK5912
Date: Thu, 27 Jul 2006 10:37:57 -0500
Message-ID: <EA12F909C0431D458B9D18A176BEE4A506D2A397@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Richard Copeman <richard.copeman@lauterbach.co.uk>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Which JTAG debugger.  I can guess but would rather you say.

If you were using CCS for example you might find that a halt could cause
some script file execution which may not be smart about the MMU being on
if your not careful.  I don't think this is your issue but it could be.

For OMAPs on emulation connection you can control if your time bases and
DMAs continue or stop.  If you allow your timers to run while halted, I
suppose the system could notices that a lot of time had passed and
complain.

You will find emulation behavior control sprinkled through out devices.
Perhaps search the TRM for 'Free run' or the like.

Regards,
Richard W.

>=20
> I have a 2.6.15 Kernel built for OMAP 5912 OSK using GCC 3.4.1 cross
> compiled form a standard SUSE 9.2 PC.
>=20
>=20
>=20
> I have the system running but when I halt the target using my JTAG
> debugger
> and then restart it I get a message dumped to the  serial console.
>=20
>=20
>=20
> BUG: soft lockup detected on CPU#0!
>=20
>=20
>=20
> Pid: 0, comm:              swapper
>=20
> CPU: 0
>=20
> PC is at omap_pm_idle+0xe8/0x130
>=20
> LR is at omap_pm_idle+0x80/0x130
>=20
> pc : [<c002dc64>]    lr : [<c002dbfc>]    Not tainted
>=20
> sp : c01f9f94  ip : c02445d0  fp : c01f9fa8
>=20
> r10: 1001d464  r9 : 41069263  r8 : 1001d494
>=20
> r7 : c025aba8  r6 : c024ca68  r5 : 00000001  r4 : 000013c3
>=20
> r3 : 00000013  r2 : 00000400  r1 : fefedc02  r0 : 00000000
>=20
> Flags: nzcv  IRQs on  FIQs on  Mode SVC_32  Segment kernel
>=20
> Control: 5317F  Table: 11FF4000  DAC: 00000017
>=20
> [<c00248e8>] (show_regs+0x0/0x4c) from [<c0059d28>]
> (softlockup_tick+0x64/0x7c)
>=20
>  r4 =3D C01F9F4C
>=20
> [<c0059cc4>] (softlockup_tick+0x0/0x7c) from [<c0046404>]
> (do_timer+0x3e8/0x468)
>=20
>=20
>=20
>  r4 =3D C024B49C
>=20
> [<c004601c>] (do_timer+0x0/0x468) from [<c002792c>]
(timer_tick+0xb4/0xe4)
>=20
> [<c0027878>] (timer_tick+0x0/0xe4) from [<c00381a8>]
> (omap_32k_timer_interrupt+0
>=20
> x5c/0xac)
>=20
>  r6 =3D 00000093  r5 =3D C024A450  r4 =3D 04424267
>=20
> [<c003814c>] (omap_32k_timer_interrupt+0x0/0xac) from [<c0023a08>]
> (__do_irq+0xa
>=20
> 4/0xe8)
>=20
>  r7 =3D 00000036  r6 =3D 00000000  r5 =3D 00000000  r4 =3D C01FF864
>=20
> [<c0023964>] (__do_irq+0x0/0xe8) from [<c0023c50>]
> (do_level_IRQ+0x68/0xbc)
>=20
>  r8 =3D C01F9F4C  r7 =3D C025ABA8  r6 =3D C01F9F4C  r5 =3D 00000036
>=20
>  r4 =3D C023FDBC
>=20
> [<c0023be8>] (do_level_IRQ+0x0/0xbc) from [<c0023cf8>]
> (asm_do_IRQ+0x54/0x140)
>=20
>  r6 =3D FFFFFFFF  r5 =3D FEFE0000  r4 =3D C01F8000
>=20
> [<c0023ca4>] (asm_do_IRQ+0x0/0x140) from [<c00229a4>]
> (__irq_svc+0x24/0x80)
>=20
> [<c002db7c>] (omap_pm_idle+0x0/0x130) from [<c002464c>]
> (cpu_idle+0x48/0x64)
>=20
>  r5 =3D C01F8000  r4 =3D C002DB7C
>=20
> [<c0024604>] (cpu_idle+0x0/0x64) from [<c0022024>]
(__init_end+0x24/0x2c)
>=20
>  r5 =3D C023EE7C  r4 =3D 00000000
>=20
> [<c0022000>] (__init_end+0x0/0x2c) from [<c00087ec>]
> (start_kernel+0x174/0x1bc)
>=20
> [<c0008678>] (start_kernel+0x0/0x1bc) from [<10008094>] (0x10008094)
>=20
>=20
>=20
> / #
>=20
> / #
>=20
> / #
>=20
> / #
>=20
> / #
>=20
>=20
>=20
> The system is trying to tell me something but what?
>=20
> How do I decode this message and understand what's been going on?
>=20
> The system continues to run stably and without any apparent problems
but
> I'd
> like to know what's going on and what I should be doing about it.
>=20
>=20
>=20
> TIA,
>=20
>=20
>=20
> Richard.
>=20
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
