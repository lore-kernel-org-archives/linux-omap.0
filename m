From: jean-philippe francois <jp.francois@cynove.com>
Subject: Re: Early oops on 3.4.3
Date: Fri, 22 Jun 2012 13:37:14 +0200
Message-ID: <CAGGh5h3Cz-NaE15SNbZR=YJzzq2EdZthme6Or7e0sszLv50xcw@mail.gmail.com>
References: <CAGGh5h1pu=YWfLWOdf1M4p5Ncki1Ug9Whtwqb8eZABMgxy84Rw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f51.google.com ([209.85.213.51]:64551 "EHLO
	mail-yw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760036Ab2FVLhO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Jun 2012 07:37:14 -0400
Received: by yhnn12 with SMTP id n12so1693213yhn.10
        for <linux-omap@vger.kernel.org>; Fri, 22 Jun 2012 04:37:14 -0700 (PDT)
In-Reply-To: <CAGGh5h1pu=YWfLWOdf1M4p5Ncki1Ug9Whtwqb8eZABMgxy84Rw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

2012/6/21 jean-philippe francois <jp.francois@cynove.com>:
> Hi,
>
> I have a custom dm3730 board, which is booting fines with 3.2.x kerne=
l.
> However it oopses very early in the boot process with 3.4.x kernel.
>
> I have some trouble interpreting the oops so some help is welcome.
> I think what makes this board quite different from other setup is the=
 absence
> of Power Management IC.
>
> Here is a patch that tries to hide the problem, and was needed for 3.=
2 not
> to oopse :
>
> Index: b/arch/arm/mach-omap2/io.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/arch/arm/mach-omap2/io.c
> +++ b/arch/arm/mach-omap2/io.c
> @@ -394,7 +394,7 @@
> =A0{
> =A0 =A0 =A0 =A0omap2_set_globals_3xxx();
> =A0 =A0 =A0 =A0omap_common_init_early();
> - =A0 =A0 =A0 omap3xxx_voltagedomains_init();
> + =A0 =A0 =A0 // =A0 =A0 =A0omap3xxx_voltagedomains_init();
> =A0 =A0 =A0 =A0omap3xxx_powerdomains_init();
> =A0 =A0 =A0 =A0omap3xxx_clockdomains_init();
> =A0 =A0 =A0 =A0omap3xxx_hwmod_init();
>
> I guess this is a possible culprit, but any help on booting without
> PMIC is welcome.
> Below is the boot log.
>

I had to adjust my board file, and initialise the
=2Ehandle_irq and .restart fields.

However, I still have oopse later in the boot when entering idle,
but I will start a new thread for this.

> Thank you for your help
>
> Starting kernel ...
>
> <6>Booting Linux on physical CPU 0
> <5>Linux version 3.4.3 (cynove@jp) (gcc version 4.3.2 (Sourcery G++
> Lite 2008q3-41) ) #1 PREEMPT Thu Jun 21 16:39:44 CEST 2012
> CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), cr=3D10c53c7d
> CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction ca=
che
> Machine: Cynove CYDM3730
> <6>Reserving 4194304 bytes SDRAM for VRAM
> Memory policy: ECC disabled, Data cache writeback
> <7>On node 0 totalpages: 45568
> <7>free_area_init_node: node 0, pgdat c0429404, node_mem_map c043f000
> <7> =A0Normal zone: 512 pages used for memmap
> <7> =A0Normal zone: 0 pages reserved
> <7> =A0Normal zone: 45056 pages, LIFO batch:15
> <6>OMAP3630 ES1.2 (l2cache iva sgx neon isp 192mhz_clk )
> <3>powerdomain: wkup_pwrdm: voltagedomain wakeup does not exist
> <3>powerdomain: iva2_pwrdm: voltagedomain mpu_iva does not exist
> <3>powerdomain: mpu_pwrdm: voltagedomain mpu_iva does not exist
> <3>powerdomain: neon_pwrdm: voltagedomain mpu_iva does not exist
> <3>powerdomain: cam_pwrdm: voltagedomain core does not exist
> <3>powerdomain: dss_pwrdm: voltagedomain core does not exist
> <3>powerdomain: per_pwrdm: voltagedomain core does not exist
> <3>powerdomain: emu_pwrdm: voltagedomain core does not exist
> <3>powerdomain: dpll1_pwrdm: voltagedomain mpu_iva does not exist
> <3>powerdomain: dpll2_pwrdm: voltagedomain mpu_iva does not exist
> <3>powerdomain: dpll3_pwrdm: voltagedomain core does not exist
> <3>powerdomain: dpll4_pwrdm: voltagedomain core does not exist
> <3>powerdomain: core_pwrdm: voltagedomain core does not exist
> <3>powerdomain: sgx_pwrdm: voltagedomain core does not exist
> <3>powerdomain: usbhost_pwrdm: voltagedomain core does not exist
> <3>powerdomain: dpll5_pwrdm: voltagedomain core does not exist
> <3>clockdomain: wkup_clkdm: powerdomain wkup_pwrdm does not exist
> <3>clockdomain: cm_clkdm: powerdomain core_pwrdm does not exist
> <3>clockdomain: prm_clkdm: powerdomain wkup_pwrdm does not exist
> <3>clockdomain: mpu_clkdm: powerdomain mpu_pwrdm does not exist
> <3>clockdomain: neon_clkdm: powerdomain neon_pwrdm does not exist
> <3>clockdomain: iva2_clkdm: powerdomain iva2_pwrdm does not exist
> <3>clockdomain: d2d_clkdm: powerdomain core_pwrdm does not exist
> <3>clockdomain: core_l3_clkdm: powerdomain core_pwrdm does not exist
> <3>clockdomain: core_l4_clkdm: powerdomain core_pwrdm does not exist
> <3>clockdomain: dss_clkdm: powerdomain dss_pwrdm does not exist
> <3>clockdomain: cam_clkdm: powerdomain cam_pwrdm does not exist
> <3>clockdomain: per_clkdm: powerdomain per_pwrdm does not exist
> <3>clockdomain: emu_clkdm: powerdomain emu_pwrdm does not exist
> <3>clockdomain: dpll1_clkdm: powerdomain dpll1_pwrdm does not exist
> <3>clockdomain: dpll2_clkdm: powerdomain dpll2_pwrdm does not exist
> <3>clockdomain: dpll3_clkdm: powerdomain dpll3_pwrdm does not exist
> <3>clockdomain: dpll4_clkdm: powerdomain dpll4_pwrdm does not exist
> <3>clockdomain: sgx_clkdm: powerdomain sgx_pwrdm does not exist
> <3>clockdomain: dpll5_clkdm: powerdomain dpll5_pwrdm does not exist
> <3>clockdomain: usbhost_clkdm: powerdomain usbhost_pwrdm does not exi=
st
> <6>Clocking rate (Crystal/Core/MPU): 19.2/400/832 MHz
> <7>pcpu-alloc: s0 r0 d32768 u32768 alloc=3D1*32768<c>
> <7>pcpu-alloc: <c>[0] <c>0 <c>
> Built 1 zonelists in Zone order, mobility grouping on. =A0Total pages=
: 45056
> <5>Kernel command line: console=3DttyO2,115200n8 rdinit=3D/sbin/init
> initrd=3D0x83000000,1536k
> mtdparts=3Domap2-nand.0:1024k(bootloaders),3072k(linux),1536k(ramfs),=
-(usr)
> ubi.mtd=3D3,2048 mem=3D55M@0x80000000 mem=3D128M@0x88000000
> <6>PID hash table entries: 1024 (order: 0, 4096 bytes)
> <6>Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
> <6>Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
> <6>Memory: 55MB 123MB =3D 178MB total
> <5>Memory: 174676k/174676k available, 12716k reserved, 0K highmem
> <5>Virtual kernel memory layout:
> =A0 =A0vector =A0: 0xffff0000 - 0xffff1000 =A0 ( =A0 4 kB)
> =A0 =A0fixmap =A0: 0xfff00000 - 0xfffe0000 =A0 ( 896 kB)
> =A0 =A0vmalloc : 0xd0800000 - 0xff000000 =A0 ( 744 MB)
> =A0 =A0lowmem =A0: 0xc0000000 - 0xd0000000 =A0 ( 256 MB)
> =A0 =A0modules : 0xbf000000 - 0xc0000000 =A0 ( =A016 MB)
> =A0 =A0 =A0.text : 0xc0008000 - 0xc03c84b8 =A0 (3842 kB)
> =A0 =A0 =A0.init : 0xc03c9000 - 0xc03f2000 =A0 ( 164 kB)
> =A0 =A0 =A0.data : 0xc03f2000 - 0xc042def0 =A0 ( 240 kB)
> =A0 =A0 =A0 .bss : 0xc042df14 - 0xc043e688 =A0 ( =A066 kB)
> <6>NR_IRQS:440
> <6>IRQ: Found an INTC at 0xfa200000 (revision 4.0) with 96 interrupts
> <6>Total of 96 interrupts on 1 active controller
> <4>omap_hwmod: arm_fck: missing clockdomain for arm_fck.
> <4>omap_hwmod: gpt1_fck: missing clockdomain for gpt1_fck.
> <6>OMAP clockevent source: GPTIMER1 at 32768 Hz
> <6>sched_clock: 32 bits at 32kHz, resolution 30517ns, wraps every 131=
071999ms
> <1>Unable to handle kernel NULL pointer dereference at virtual addres=
s 00000000
> <1>pgd =3D c0004000
> <1>[00000000] *pgd=3D00000000
> <0>Internal error: Oops: 80000005 [#1] PREEMPT ARM
> <d>Modules linked in:
> CPU: 0 =A0 =A0Not tainted =A0(3.4.3 #1)
> PC is at 0x0
> LR is at __irq_svc+0x40/0x70
> pc : [<00000000>] =A0 =A0lr : [<c000e380>] =A0 =A0psr: 000001d3
> sp : c03f3f88 =A0ip : 0000000f =A0fp : 00000000
> r10: 00000000 =A0r9 : 413fc082 =A0r8 : 80004059
> r7 : c03f3fbc =A0r6 : ffffffff =A0r5 : 00000153 =A0r4 : c03da4bc
> r3 : c03c97f0 =A0r2 : c03f3fd0 =A0r1 : c03fd00c =A0r0 : c03f3f88
> Flags: nzcv =A0IRQs off =A0FIQs off =A0Mode SVC_32 =A0ISA ARM =A0Segm=
ent kernel
> Control: 10c5387d =A0Table: 80004019 =A0DAC: 00000015
> <0>Process swapper (pid: 0, stack limit =3D 0xc03f22e8)
> <0>Stack: (0xc03f3f88 to 0xc03f4000)
> <0>3f80: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 00000000 400001d3 000000=
00 c03fa040 ffffffff c03fa08c
> <0>3fa0: c03e9100 c03fd004 80004059 413fc082 00000000 00000000 000000=
0f c03f3fd0
> <0>3fc0: c03c97f0 c03da4bc 00000153 ffffffff ffffffff ffffffff c03c95=
74 00000000
> <0>3fe0: 00000000 c03e9104 00000000 10c53c7d c03fa08c 8000803c 000000=
00 00000000
> [<c000e380>] (__irq_svc+0x40/0x70) from [<c03da4bc>]
> (kmem_cache_init_late+0x0/0x74)
> <0>Code: bad PC value
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
