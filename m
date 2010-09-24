From: Laine Walker-Avina <lwalkera@pasco.com>
Subject: Re: SYS_OFF_MODE signaling and CORE domain Transition to OFF Mode
Date: Fri, 24 Sep 2010 09:48:14 -0700
Message-ID: <AANLkTik3vJZegvTZ3+LBsxtb-p4mhQ8ik5WR9Cm9Azv4@mail.gmail.com>
References: <AANLkTinmYY-tVqD77SMeE-YVZWuY-=yscaBNDSOYM=Ub@mail.gmail.com>
	<87sk10z66k.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:49048 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752903Ab0IXQxW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Sep 2010 12:53:22 -0400
Received: by wwd20 with SMTP id 20so93561wwd.1
        for <linux-omap@vger.kernel.org>; Fri, 24 Sep 2010 09:53:20 -0700 (PDT)
In-Reply-To: <87sk10z66k.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, "Nimmagadda, Padmaja" <pnimma@ti.com>

On Thu, Sep 23, 2010 at 11:05 AM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> Laine Walker-Avina <lwalkera@pasco.com> writes:
>
>> I'm having some troubles putting my OMAP3503(the one without the DSP
>> or SGX modules) board to sleep. I'm using the current master on the
>> l-o git repository.
>
> Looks like you're wanting to use off-mode. =C2=A0There are many drive=
rs that
> do not yet support off mode, as they need to do context save/restore =
in
> their suspend/resume paths in order to support off mode.
>
> In particular, MMC in l-o master does not yet have this support, so y=
ou
> should not expect MMC to work after an off mode transition.
>
> This is why off-mode is disabled by default, it has to be manually
> enabled by: echo 1 > /debug/pm_debug/enable_off_mode.
>
> Do things work as expected if you leave off-mode disabled?
>
>> This is the output from dmesg and the count file after suspending
>> twice. The first time it wakes immediately after going down, and the
>> second time stays asleep but says that the core domain didn't enter
>> OFF mode.
>
> This is not easy to debug with the current kernel dump.
>
> The way I suggest debugging this is by first getting to a minimal ker=
nel
> that can suspend/resume as you expect. =C2=A0Then you add in the driv=
ers to
> see which one is causing the problem, or keeping the system away.
>
> Clearly the MMC driver has some problems in it's suspend/resume hooks
> with unbalanced regulator enable/disables, so for starters, I'd sugge=
st
> disabling MMC. =C2=A0I'd also suggest disabling musb, but basically t=
he best
> way is to disable everything except a minimal kernel, and then work b=
ack
> up to the config you want.
>
> You might try using my PM branch (link below) which comes with a mini=
mal
> kernel config for this purpose: omap3_pm_defconfig.
>
>> In either case, the SYS_OFF_MODE signal never asserts. I added some
>> debug code into map_sram_idle() to capture CM_CORE_IDLEST1 and 3 rig=
ht
>> before it jumps to the final sleep code in SRAM.
>
> For looking at the idlest regs, you might want to try the patch from =
my
> pm-debug branch (included in my pm branch) which takes a snapshot of =
all
> the PM registers just before SRAM idle and right after resume. =C2=A0=
You can
> then see the registers using debugfs. =C2=A0This is documented on the=
 OMAP PM
> wiki:
>
> =C2=A0 =C2=A0 =C2=A0http://elinux.org/OMAP_Power_Management
>
> Hope that helps a little,
>
> Kevin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
Hi Kevin,

Thanks for the help. :)

I recompiled the kernel without anything but UART support like you
said. I applied the debug patch and the results follow. The processor
seems to go into OFF mode according the dmesg output, but the
SYS_OFF_MODE pin doesn't change state. Any thoughts?
Also, is the MMC driver being worked on to make it suspend/resume
compliant? I recall that I was able to at least go into retention with
the MMC as the root FS earlier.

root@spark:/debug/pm_debug$ echo mem > /sys/power/state
[  209.520324] PM: Syncing filesystems ... done.
[  209.525787] PM: Preparing system for mem sleep
[  209.530944] Freezing user space processes ... (elapsed 0.02 seconds)=
 done.
[  209.559204] Freezing remaining freezable tasks ... (elapsed 0.02
seconds) done.
[  209.590545] PM: Entering mem sleep
[  209.594177] Suspending console(s) (use no_console_suspend to debug)
[  209.600982] platform reg-dummy: preparing suspend
[  209.601318] platform omapdss: preparing suspend
[  209.601409] reg-fixed-voltage reg-fixed-voltage.1: preparing suspend
[  209.601501] platform nop_usb_xceiv: preparing suspend
[  209.601623] serial8250 serial8250.0: preparing suspend
[  209.601715] serial8250 serial8250.1: preparing suspend
[  209.601806] serial8250 serial8250.2: preparing suspend
[  209.601898] platform arm-pmu.0: preparing suspend
[  209.604217] platform mpu.0: preparing suspend
[  209.604339] platform iva.0: preparing suspend
[  209.604461] platform l3_main.0: preparing suspend
[  209.604583] serial8250 serial8250: preparing suspend
[  209.607818] serial8250 serial8250: suspend
[  209.608001] platform l3_main.0: suspend
[  209.608123] platform iva.0: suspend
[  209.608245] platform mpu.0: suspend
[  209.611083] platform arm-pmu.0: suspend
[  209.611236] serial8250 serial8250.2: suspend
[  209.611663] serial8250 serial8250.1: suspend
[  209.611846] serial8250 serial8250.0: suspend
[  209.612030] platform nop_usb_xceiv: suspend
[  209.612152] reg-fixed-voltage reg-fixed-voltage.1: suspend
[  209.612274] platform omapdss: suspend
[  209.612609] platform reg-dummy: suspend
[  209.612854] PM: suspend of devices complete after 6.778 msecs
[  209.614685] serial8250 serial8250: LATE suspend
[  209.614746] platform l3_main.0: LATE suspend
[  209.614776] platform iva.0: LATE suspend
[  209.614807] platform mpu.0: LATE suspend
[  209.615020] platform arm-pmu.0: LATE suspend
[  209.615051] serial8250 serial8250.2: LATE suspend
[  209.615081] serial8250 serial8250.1: LATE suspend
[  209.615112] serial8250 serial8250.0: LATE suspend
[  209.615142] platform nop_usb_xceiv: LATE suspend
[  209.615173] reg-fixed-voltage reg-fixed-voltage.1: LATE suspend
[  209.615203] platform omapdss: LATE suspend
[  209.615264] platform reg-dummy: LATE suspend
[  209.615325] PM: late suspend of devices complete after 2.412 msecs
[  220.011688] sdrc_pwr before:00000129 now:00000129
[  220.011749] Successfully put all powerdomains to target state
[  220.012115] platform reg-dummy: EARLY resume
[  220.012176] platform omapdss: EARLY resume
[  220.012207] reg-fixed-voltage reg-fixed-voltage.1: EARLY resume
[  220.012237] platform nop_usb_xceiv: EARLY resume
[  220.012268] serial8250 serial8250.0: EARLY resume
[  220.012298] serial8250 serial8250.1: EARLY resume
[  220.012329] serial8250 serial8250.2: EARLY resume
[  220.012359] platform arm-pmu.0: EARLY resume
[  220.012573] platform mpu.0: EARLY resume
[  220.012603] platform iva.0: EARLY resume
[  220.012634] platform l3_main.0: EARLY resume
[  220.012664] serial8250 serial8250: EARLY resume
[  220.012847] PM: early resume of devices complete after 0.793 msecs
[  220.012969] irqstatus 00000200
[  220.013488] platform reg-dummy: resume
[  220.013793] platform omapdss: resume
[  220.013885] reg-fixed-voltage reg-fixed-voltage.1: resume
[  220.014007] platform nop_usb_xceiv: resume
[  220.014099] serial8250 serial8250.0: resume
[  220.014617] serial8250 serial8250.1: resume
[  220.014801] serial8250 serial8250.2: resume
[  220.022766] platform arm-pmu.0: resume
[  220.024688] platform mpu.0: resume
[  220.024780] platform iva.0: resume
[  220.024871] platform l3_main.0: resume
[  220.024993] serial8250 serial8250: resume
[  220.026458] PM: resume of devices complete after 13.128 msecs
[  220.027740] serial8250 serial8250: completing resume
[  220.027862] platform l3_main.0: completing resume
[  220.027954] platform iva.0: completing resume
[  220.028045] platform mpu.0: completing resume
[  220.029785] platform arm-pmu.0: completing resume
[  220.029907] serial8250 serial8250.2: completing resume
[  220.029998] serial8250 serial8250.1: completing resume
[  220.030426] serial8250 serial8250.0: completing resume
[  220.030548] platform nop_usb_xceiv: completing resume
[  220.030639] reg-fixed-voltage reg-fixed-voltage.1: completing resume
[  220.030731] platform omapdss: completing resume
[  220.031005] platform reg-dummy: completing resume
[  220.393035] PM: Finishing wakeup.
[  220.396423] Restarting tasks ... done.
root@spark:/debug/pm_debug$ cat registers/1
MOD: CM_IVA2 (48014000)
  04 =3D> 00000011  20 =3D> 00000001  34 =3D> 00000001  40 =3D> 0008000=
0
  44 =3D> 00000001  48 =3D> 00000003
MOD: CM_OCP (48004800)
  00 =3D> 00000010  10 =3D> 00000001
MOD: CM_MPU (48004900)
  04 =3D> 00000077  24 =3D> 00000001  34 =3D> 00000001  40 =3D> 0010fa0=
5
  44 =3D> 00000001  48 =3D> 00000003  4c =3D> 00000001
MOD: CM_CORE (48004a00)
  10 =3D> 00000042  20 =3D> ffffffbd  24 =3D> 0000001f  28 =3D> 0000000=
d
  30 =3D> fffffed9  34 =3D> 0000001f  38 =3D> 0000000c  40 =3D> 0000030=
a
  48 =3D> 0000003f  4c =3D> 00000003
MOD: CM_SGX (48004b00)

MOD: CM_WKUP (48004c00)
  10 =3D> 0000000e  20 =3D> 000002f1  30 =3D> 0000003f  40 =3D> 0000001=
5
MOD: CM_CCR (48004d00)
  00 =3D> 00770007  04 =3D> 00000011  20 =3D> 00000003  30 =3D> 0000000=
1
  34 =3D> 00000001  40 =3D> 08a60500  44 =3D> 0000d805  48 =3D> 0000000=
9
  4c =3D> 00003204  50 =3D> 00000001  70 =3D> 00000092
MOD: CM_DSS (48004e00)
  20 =3D> 00000003  30 =3D> 00000001  40 =3D> 00001009  48 =3D> 0000000=
3
MOD: CM_CAM (48004f00)
  20 =3D> 00000001  30 =3D> 00000001  40 =3D> 00000004  48 =3D> 0000000=
3
MOD: CM_PER (48005000)
  10 =3D> 0003e000  20 =3D> 00001fff  30 =3D> 0003ffff  40 =3D> 000000f=
f
  44 =3D> 00000006  48 =3D> 00000003  4c =3D> 00000001
MOD: CM_EMU (48005100)
  40 =3D> 03020a50  48 =3D> 00000001
MOD: CM_NEON (48005300)
  48 =3D> 00000003
MOD: CM_USB (48005400)
  20 =3D> 00000003  30 =3D> 00000001  48 =3D> 00000003
MOD: PRM_IVA2 (48316000)
  50 =3D> 00000007  e0 =3D> 00ff0f04  f8 =3D> 00000002
MOD: PRM_OCP (48306800)
  04 =3D> 00000010  14 =3D> 00000001  18 =3D> 00000010  1c =3D> 0000020=
1
MOD: PRM_MPU (48306900)
  58 =3D> 0000000c  d4 =3D> 00000012  e0 =3D> 00030104  e4 =3D> 000000c=
7
  e8 =3D> 000000c7
MOD: PRM_CORE (48306a00)
  58 =3D> 00000304  a0 =3D> c33f9e18  a4 =3D> c33ffe18  e0 =3D> 000f031=
4
  e4 =3D> 000000f7  e8 =3D> 000000f7  f0 =3D> 00000004  f8 =3D> 0000000=
4
MOD: PRM_SGX (48306b00)

MOD: PRM_WKUP (48306c00)
  a0 =3D> 0001010b  a4 =3D> 0000010b  b0 =3D> 00010000
MOD: PRM_CCR (48306d00)
  70 =3D> 00000080
MOD: PRM_DSS (48306e00)
  a0 =3D> 00000001  e0 =3D> 00030104
MOD: PRM_CAM (48306f00)
  e0 =3D> 00030104
MOD: PRM_PER (48307000)
  58 =3D> 0000000c  a0 =3D> 0003e007  a4 =3D> 0003e807  c8 =3D> 0000000=
6
  e0 =3D> 00030104  e4 =3D> 00000007  e8 =3D> 00000007
MOD: PRM_EMU (48307100)
  58 =3D> 00000004  e4 =3D> 00000100
MOD: PRM_GLBL (48307200)
  38 =3D> 00000018  54 =3D> 00001006  58 =3D> 00000001  60 =3D> 0000000=
c
  64 =3D> 00000050  70 =3D> 00000049  9c =3D> 00000002  c4 =3D> 0000000=
1
  e4 =3D> 00000001
MOD: PRM_NEON (48307300)
  58 =3D> 0000000c  c8 =3D> 00000002  e0 =3D> 00000004  e4 =3D> 0000000=
3
  e8 =3D> 00000003
MOD: PRM_USB (48307400)
  58 =3D> 00000008  a0 =3D> 00000001  a4 =3D> 00000001  a8 =3D> 0000000=
1
  e0 =3D> 00030104
root@spark:/debug/pm_debug$ cat registers/2
MOD: CM_IVA2 (48014000)
  04 =3D> 00000011  20 =3D> 00000001  40 =3D> 00080000  44 =3D> 0000000=
1
MOD: CM_OCP (48004800)
  00 =3D> 00000010  10 =3D> 00000001
MOD: CM_MPU (48004900)
  04 =3D> 00000077  24 =3D> 00000001  34 =3D> 00000001  40 =3D> 0010fa0=
5
  44 =3D> 00000001  4c =3D> 00000001
MOD: CM_CORE (48004a00)
  10 =3D> 0000004a  20 =3D> ffffffbd  24 =3D> 0000001f  28 =3D> 0000000=
d
  30 =3D> 00000008  40 =3D> 0000030a  4c =3D> 00000003
MOD: CM_SGX (48004b00)

MOD: CM_WKUP (48004c00)
  20 =3D> 000002ff  40 =3D> 00000015
MOD: CM_CCR (48004d00)
  00 =3D> 00770007  04 =3D> 00000011  20 =3D> 00000003  30 =3D> 0000000=
1
  40 =3D> 08a60500  44 =3D> 0000d805  48 =3D> 00000009  50 =3D> 0000000=
1
  70 =3D> 00000003
MOD: CM_DSS (48004e00)
  20 =3D> 00000003  40 =3D> 00001010
MOD: CM_CAM (48004f00)
  20 =3D> 00000001  40 =3D> 00000010
MOD: CM_PER (48005000)
  20 =3D> 0003ffff
MOD: CM_EMU (48005100)
  40 =3D> 10100a50  48 =3D> 00000002  4c =3D> 00000001
MOD: CM_NEON (48005300)

MOD: CM_USB (48005400)
  20 =3D> 00000003
MOD: PRM_IVA2 (48316000)
  50 =3D> 00000007  e0 =3D> 00ff0f04  f8 =3D> 00000002
MOD: PRM_OCP (48306800)
  04 =3D> 00000010  14 =3D> 00000001  18 =3D> 00000210  1c =3D> 0000020=
1
MOD: PRM_MPU (48306900)
  58 =3D> 0000000c  d4 =3D> 00000012  e0 =3D> 00030104  e4 =3D> 000000c=
7
MOD: PRM_CORE (48306a00)
  58 =3D> 00000304  a0 =3D> c33f9e18  a4 =3D> c33ffe18  e0 =3D> 000f031=
4
  e4 =3D> 000000f7  f0 =3D> 00000004  f8 =3D> 00000004
MOD: PRM_SGX (48306b00)

MOD: PRM_WKUP (48306c00)
  a0 =3D> 0000010b  a4 =3D> 0000010b  b0 =3D> 00010100
MOD: PRM_CCR (48306d00)
  70 =3D> 00000080
MOD: PRM_DSS (48306e00)
  a0 =3D> 00000001  e0 =3D> 00030104
MOD: PRM_CAM (48306f00)
  e0 =3D> 00030104
MOD: PRM_PER (48307000)
  58 =3D> 0000000c  a0 =3D> 0003e007  a4 =3D> 0003e807  c8 =3D> 0000000=
6
  e0 =3D> 00030104
MOD: PRM_EMU (48307100)
  58 =3D> 00000004  e4 =3D> 00000103
MOD: PRM_GLBL (48307200)
  38 =3D> 00000018  54 =3D> 00001006  58 =3D> 00000001  60 =3D> 0000000=
c
  64 =3D> 00000050  70 =3D> 00000049  9c =3D> 00000002  c4 =3D> 0000000=
1
  e4 =3D> 00000001
MOD: PRM_NEON (48307300)
  58 =3D> 0000000c  c8 =3D> 00000002  e0 =3D> 00000004  e4 =3D> 0000000=
3
MOD: PRM_USB (48307400)
  58 =3D> 00000008  a0 =3D> 00000001  a4 =3D> 00000001  a8 =3D> 0000000=
1
  e0 =3D> 00030104
root@spark:/debug/pm_debug$ cat registers/current
MOD: CM_IVA2 (48014000)
  04 =3D> 00000011  20 =3D> 00000001  34 =3D> 00000001  40 =3D> 0008000=
0
  44 =3D> 00000001  48 =3D> 00000003
MOD: CM_OCP (48004800)
  00 =3D> 00000010  10 =3D> 00000001
MOD: CM_MPU (48004900)
  04 =3D> 00000077  24 =3D> 00000001  34 =3D> 00000001  40 =3D> 0010fa0=
5
  44 =3D> 00000001  48 =3D> 00000003  4c =3D> 00000001
MOD: CM_CORE (48004a00)
  00 =3D> 00006000  10 =3D> 00006042  20 =3D> ffff9fbd  24 =3D> 0000001=
f
  28 =3D> 0000000d  30 =3D> fffffed9  34 =3D> 0000001f  38 =3D> 0000000=
c
  40 =3D> 0000030a  48 =3D> 0000003f  4c =3D> 00000003
MOD: CM_SGX (48004b00)

MOD: CM_WKUP (48004c00)
  10 =3D> 0000000e  20 =3D> 000002f1  30 =3D> 0000003f  40 =3D> 0000001=
5
MOD: CM_CCR (48004d00)
  00 =3D> 00770007  04 =3D> 00000011  20 =3D> 0000020b  30 =3D> 0000000=
1
  34 =3D> 00000001  40 =3D> 08a60500  44 =3D> 0000d805  48 =3D> 0000000=
9
  4c =3D> 00003204  50 =3D> 00000001  70 =3D> 00000092
MOD: CM_DSS (48004e00)
  20 =3D> 00000003  30 =3D> 00000001  40 =3D> 00001009  48 =3D> 0000000=
3
MOD: CM_CAM (48004f00)
  20 =3D> 00000001  30 =3D> 00000001  40 =3D> 00000004  48 =3D> 0000000=
3
MOD: CM_PER (48005000)
  00 =3D> 00000800  10 =3D> 0003e800  20 =3D> 000017ff  30 =3D> 0003fff=
f
  40 =3D> 000000ff  44 =3D> 00000006  48 =3D> 00000003  4c =3D> 0000000=
1
MOD: CM_EMU (48005100)
  40 =3D> 03020a50  48 =3D> 00000001
MOD: CM_NEON (48005300)
  48 =3D> 00000003
MOD: CM_USB (48005400)
  20 =3D> 00000003  30 =3D> 00000001  48 =3D> 00000003
MOD: PRM_IVA2 (48316000)
  50 =3D> 00000007  e0 =3D> 00ff0f04  f8 =3D> 00000002
MOD: PRM_OCP (48306800)
  04 =3D> 00000010  14 =3D> 00000001  18 =3D> 00000010  1c =3D> 0000020=
1
MOD: PRM_MPU (48306900)
  58 =3D> 0000000c  d4 =3D> 00000012  e0 =3D> 00030104  e4 =3D> 000000c=
7
MOD: PRM_CORE (48306a00)
  58 =3D> 00000304  a0 =3D> c33f9e18  a4 =3D> c33ffe18  e0 =3D> 000f031=
4
  e4 =3D> 000000f7  f0 =3D> 00000004  f8 =3D> 00000004
MOD: PRM_SGX (48306b00)

MOD: PRM_WKUP (48306c00)
  a0 =3D> 0000000b  a4 =3D> 0000010b
MOD: PRM_CCR (48306d00)
  70 =3D> 00000080
MOD: PRM_DSS (48306e00)
  a0 =3D> 00000001  e0 =3D> 00030104
MOD: PRM_CAM (48306f00)
  e0 =3D> 00030104
MOD: PRM_PER (48307000)
  58 =3D> 0000000c  a0 =3D> 0003e007  a4 =3D> 0003e807  c8 =3D> 0000000=
6
  e0 =3D> 00030104  e4 =3D> 00000007
MOD: PRM_EMU (48307100)
  58 =3D> 00000004  e4 =3D> 00000100
MOD: PRM_GLBL (48307200)
  38 =3D> 00000018  54 =3D> 00001006  58 =3D> 00000001  60 =3D> 0000000=
c
  64 =3D> 00000050  70 =3D> 00000049  9c =3D> 00000002  c4 =3D> 0000000=
1
  e4 =3D> 00000001
MOD: PRM_NEON (48307300)
  58 =3D> 0000000c  c8 =3D> 00000002  e0 =3D> 00000004  e4 =3D> 0000000=
3
MOD: PRM_USB (48307400)
  58 =3D> 00000008  a0 =3D> 00000001  a4 =3D> 00000001  a8 =3D> 0000000=
1
  e0 =3D> 00030104
root@spark:/debug/pm_debug$ cat count
usbhost_pwrdm (OFF),OFF:1,RET:1,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1=
-OFF:0
sgx_pwrdm (OFF),OFF:1,RET:0,INA:0,ON:0,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF=
:0
per_pwrdm (ON),OFF:3,RET:0,INA:0,ON:4,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:=
0
dss_pwrdm (OFF),OFF:1,RET:1,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF=
:0
cam_pwrdm (OFF),OFF:1,RET:1,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF=
:0
core_pwrdm (ON),OFF:3,RET:0,INA:0,ON:4,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF=
:0,RET-MEMBANK2-OFF:0
neon_pwrdm (ON),OFF:3,RET:0,INA:0,ON:4,RET-LOGIC-OFF:0
mpu_pwrdm (ON),OFF:3,RET:0,INA:0,ON:4,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:=
0
iva2_pwrdm (OFF),OFF:1,RET:1,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OF=
=46:0,RET-MEMBANK2-OFF:0,RET-MEMBANK3-OFF:0,RET-MEMBANK4-OFF:0
per_clkdm->per_pwrdm (9)
usbhost_clkdm->usbhost_pwrdm (0)
cam_clkdm->cam_pwrdm (0)
dss_clkdm->dss_pwrdm (0)
core_l4_clkdm->core_pwrdm (7)
core_l3_clkdm->core_pwrdm (4)
d2d_clkdm->core_pwrdm (0)
sgx_clkdm->sgx_pwrdm (0)
iva2_clkdm->iva2_pwrdm (0)
neon_clkdm->neon_pwrdm (0)
mpu_clkdm->mpu_pwrdm (0)
prm_clkdm->wkup_pwrdm (0)
cm_clkdm->core_pwrdm (0)

Thanks,
--=20
Laine Walker-Avina
=46irmware Engineer
PASCO scientific
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
