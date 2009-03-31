From: Russ Dill <russ.dill@gmail.com>
Subject: Re: PM branch rebased to 2.6.29
Date: Tue, 31 Mar 2009 14:31:15 -0700
Message-ID: <f9d2a5e10903311431r6f053f02l25aba8183233c2b9@mail.gmail.com>
References: <87bprz9zju.fsf@deeprootsystems.com>
	 <87zlfaztcd.fsf@deeprootsystems.com>
	 <1237925484.23022.133.camel@blackhole>
	 <49C940CA.9070805@deeprootsystems.com>
	 <f9d2a5e10903271350x2d534c76nc55c492b8acd1d4e@mail.gmail.com>
	 <B85A65D85D7EB246BE421B3FB0FBB59301CC5699A0@dbde02.ent.ti.com>
	 <f9d2a5e10903301044u775edfdo7ac540b3e1bdc597@mail.gmail.com>
	 <873acu26ms.fsf@deeprootsystems.com>
	 <f9d2a5e10903301601q5fcd331bs44c81d854ad0082f@mail.gmail.com>
	 <87myb1wnvc.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=000e0cd1554c354a28046670eb9f
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.227]:64804 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753764AbZCaVbR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Mar 2009 17:31:17 -0400
Received: by rv-out-0506.google.com with SMTP id f9so3234017rvb.1
        for <linux-omap@vger.kernel.org>; Tue, 31 Mar 2009 14:31:15 -0700 (PDT)
In-Reply-To: <87myb1wnvc.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Premi, Sanjeev" <premi@ti.com>, Peter Barada <peterb@logicpd.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

--000e0cd1554c354a28046670eb9f
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2009 at 11:25 AM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> Russ Dill <russ.dill@gmail.com> writes:
>
>> On Mon, Mar 30, 2009 at 11:43 AM, Kevin Hilman
>> <khilman@deeprootsystems.com> wrote:
>>> Russ Dill <russ.dill@gmail.com> writes:
>>>
>>>> On Mon, Mar 30, 2009 at 3:08 AM, Premi, Sanjeev <premi@ti.com> wrote:
>>> [...]
>>>>>
>>>>> I had found that two drivers that could prevent clocks_off are
>>>>> USB and DSS because of the way they use clk_enable().
>>>>>
>>>>> Can you try building without theses drivers just for verification?
>>>>>
>>>>
>>>> Building without dss makes things worse:
>>>>
>>>> Powerdomain (dss_pwrdm) didn't enter target state 0
>>>>
>>>> Maybe by looking at what the dss driver is doing I can get core and
>>>> per to turn off.
>>>
>>> Russ,
>>>
>>> Can you try with the latest HEAD of PM branch. =C2=A0After suspend/resu=
me,
>>> do
>>>
>>> # cat /debug/pm_debug/registers/1
>>>
>>> and post results to list. =C2=A0We can then see the exact state of PM
>>> registers before going into WFI.
>
> Russ,
>
> With the dump below, what was the output after you resumed? =C2=A0Which
> powerdomains did not hit their target state? =C2=A0It looks like PER and
> CORE did not hit target state.

yes, yes, and yes.

> Also, you didn't mention what hardware you're using or your .config or
> your bootloader etc. =C2=A0All of these play an important role.

Beagleboard B7, X-Loader 1.41, U-Boot 1.3.3

>> root@beagleboard:/sys# cat /debug/pm_debug/registers/1
>> MOD: CM_IVA2 (48014000)
>> =C2=A0 04 =3D> 00000037 =C2=A020 =3D> 00000001 =C2=A034 =3D> 00000001 =
=C2=A040 =3D> 0009680c
>> =C2=A0 44 =3D> 00000001 =C2=A048 =3D> 00000003
>> MOD: CM_OCP (48004800)
>> =C2=A0 00 =3D> 00000010 =C2=A010 =3D> 00000001
>> MOD: CM_MPU (48004900)
>> =C2=A0 04 =3D> 00000037 =C2=A024 =3D> 00000001 =C2=A034 =3D> 00000001 =
=C2=A040 =3D> 0011f40c
>> =C2=A0 44 =3D> 00000001 =C2=A048 =3D> 00000003 =C2=A04c =3D> 00000001
>> MOD: CM_CORE (48004a00)
>> =C2=A0 10 =3D> 00000042 =C2=A020 =3D> ffffffbd =C2=A024 =3D> 0000001f =
=C2=A028 =3D> 0000000d
>> =C2=A0 30 =3D> fffffed9 =C2=A034 =3D> 0000001f =C2=A038 =3D> 0000000c =
=C2=A040 =3D> 0000030a
>> =C2=A0 48 =3D> 0000003f =C2=A04c =3D> 00000003
>> MOD: CM_SGX (48004b00)
>> =C2=A0 20 =3D> 00000001 =C2=A048 =3D> 00000003
>> MOD: CM_WKUP (48004c00)
>> =C2=A0 10 =3D> 0000000e =C2=A020 =3D> 000002f1 =C2=A030 =3D> 0000003f =
=C2=A040 =3D> 00000015
>
> Here is at least one problem.
>
> Offset 0x40 is CM_CLKSEL_WKUP, and bit 0 shows which clock is the
> source clock for GPTIMER1. =C2=A0Here, bit 0 is 1 which means SYS_CLK
> is used as the timer source.
>
> Based on this, you must have:
>
> =C2=A0 System Type --> TI OMAP Implementations --> System Timer
>
> set to 'MPU timer'. =C2=A0Please change to 32k timer. =C2=A0Using MPU tim=
er will
> keep timers not in WKUP powerdomain (which is all of them except GPT1)
> running across suspend, preventing PER from hitting RET.
>
> Using the 32k timer only uses GPT1 and sources it from the 32k clock, bot=
h
> of which are in the WKUP powerdomain.

Nope, I have the following kernel message:

OMAP clockevent source: GPTIMER12 at 32768 Hz

and the following Kconfig options (also see the attached .config)

# CONFIG_OMAP_MPU_TIMER is not set
CONFIG_OMAP_32K_TIMER=3Dy

>> MOD: CM_CCR (48004d00)
>> =C2=A0 00 =3D> f8311037 =C2=A004 =3D> 00000017 =C2=A020 =3D> 00000201 =
=C2=A030 =3D> 00000009
>> =C2=A0 34 =3D> 00000001 =C2=A040 =3D> 094c0c00 =C2=A044 =3D> 0001b00c =
=C2=A048 =3D> 00000009
>> =C2=A0 50 =3D> 00000001 =C2=A070 =3D> 00000003
>> MOD: CM_DSS (48004e00)
>> =C2=A0 20 =3D> 00000003 =C2=A030 =3D> 00000001 =C2=A040 =3D> 00001006 =
=C2=A048 =3D> 00000003
>> MOD: CM_CAM (48004f00)
>> =C2=A0 20 =3D> 00000001 =C2=A030 =3D> 00000001 =C2=A040 =3D> 00000004 =
=C2=A048 =3D> 00000003
>> MOD: CM_PER (48005000)
>> =C2=A0 10 =3D> 0003e000 =C2=A020 =3D> 00001fff =C2=A030 =3D> 0003ffff =
=C2=A040 =3D> 000000ff
>> =C2=A0 44 =3D> 00000006 =C2=A048 =3D> 00000003 =C2=A04c =3D> 00000001
>> MOD: CM_EMU (48005100)
>> =C2=A0 40 =3D> 03020a50 =C2=A048 =3D> 00000002 =C2=A04c =3D> 00000001
>> MOD: CM_NEON (48005300)
>> =C2=A0 48 =3D> 00000003
>> MOD: CM_USB (48005400)
>> =C2=A0 20 =3D> 00000003 =C2=A030 =3D> 00000001 =C2=A048 =3D> 00000003
>> MOD: PRM_IVA2 (48316000)
>> =C2=A0 50 =3D> 00000007 =C2=A0e0 =3D> 00ff0f04 =C2=A0f8 =3D> 00000007
>> MOD: PRM_OCP (48306800)
>> =C2=A0 04 =3D> 00000010 =C2=A014 =3D> 00000001 =C2=A01c =3D> 00000201
>> MOD: PRM_MPU (48306900)
>> =C2=A0 58 =3D> 00000005 =C2=A0d4 =3D> 00000012 =C2=A0e0 =3D> 00030104 =
=C2=A0e4 =3D> 000000c7
>> =C2=A0 e8 =3D> 000000c7
>> MOD: PRM_CORE (48306a00)
>> =C2=A0 58 =3D> 00000301 =C2=A0a0 =3D> c33ffe18 =C2=A0a4 =3D> c33ffe18 =
=C2=A0a8 =3D> c33ffe18
>> =C2=A0 e0 =3D> 000f0304 =C2=A0e4 =3D> 000000f7 =C2=A0e8 =3D> 000000f7 =
=C2=A0f0 =3D> 00000004
>> =C2=A0 f4 =3D> 00000004 =C2=A0f8 =3D> 00000004
>> MOD: PRM_SGX (48306b00)
>> =C2=A0 e0 =3D> 00030104
>> MOD: PRM_WKUP (48306c00)
>> =C2=A0 a0 =3D> 0000010b =C2=A0a4 =3D> 0000010b
>> MOD: PRM_CCR (48306d00)
>> =C2=A0 40 =3D> 00000003
>> MOD: PRM_DSS (48306e00)
>> =C2=A0 58 =3D> 00000005 =C2=A0a0 =3D> 00000001 =C2=A0e0 =3D> 00030104
>> MOD: PRM_CAM (48306f00)
>> =C2=A0 58 =3D> 00000001 =C2=A0e0 =3D> 00030104
>> MOD: PRM_PER (48307000)
>> =C2=A0 58 =3D> 00000001 =C2=A0a0 =3D> 0003efff =C2=A0a4 =3D> 0003efff =
=C2=A0a8 =3D> 0003efff
>> =C2=A0 c8 =3D> 00000007 =C2=A0e0 =3D> 00030104 =C2=A0e4 =3D> 00000007 =
=C2=A0e8 =3D> 00000007
>> MOD: PRM_EMU (48307100)
>> =C2=A0 58 =3D> 00000005 =C2=A0e4 =3D> 00000103
>> MOD: PRM_GLBL (48307200)
>> =C2=A0 20 =3D> 00120012 =C2=A024 =3D> 00010000 =C2=A02c =3D> 301e1e30 =
=C2=A030 =3D> 2c1e1e2c
>> =C2=A0 34 =3D> 00120000 =C2=A038 =3D> 00000018 =C2=A054 =3D> 00001006 =
=C2=A058 =3D> 00000001
>> =C2=A0 60 =3D> 0000000e =C2=A064 =3D> 00000050 =C2=A070 =3D> 00000088 =
=C2=A090 =3D> 0fff0fff
>> =C2=A0 94 =3D> 000000ff =C2=A098 =3D> 000000ff =C2=A09c =3D> 00000002 =
=C2=A0a0 =3D> 000000ff
>> =C2=A0 c4 =3D> 00000001 =C2=A0e4 =3D> 00000001
>> MOD: PRM_NEON (48307300)
>> =C2=A0 58 =3D> 00000005 =C2=A0c8 =3D> 00000002 =C2=A0e0 =3D> 00000004 =
=C2=A0e4 =3D> 00000003
>> =C2=A0 e8 =3D> 00000003
>> MOD: PRM_USB (48307400)
>> =C2=A0 58 =3D> 00000001 =C2=A0a0 =3D> 00000001 =C2=A0a4 =3D> 00000001 =
=C2=A0a8 =3D> 00000001
>> =C2=A0 e0 =3D> 00030104
>>
>>
>>> Also, post dump of
>>>
>>
>> root@beagleboard:/sys# cat /debug/pm_debug/count
>> usbhost_pwrdm (OFF),OFF:1,RET:1,INA:0,ON:1
>> sgx_pwrdm (OFF),OFF:1,RET:0,INA:0,ON:1
>> per_pwrdm (ON),OFF:0,RET:0,INA:0,ON:1
>> dss_pwrdm (ON),OFF:2,RET:0,INA:0,ON:3
>> cam_pwrdm (OFF),OFF:1,RET:1,INA:0,ON:1
>> core_pwrdm (ON),OFF:0,RET:0,INA:0,ON:1
>> neon_pwrdm (ON),OFF:2,RET:0,INA:14100,ON:14103
>> mpu_pwrdm (ON),OFF:2,RET:0,INA:14100,ON:14103
>> iva2_pwrdm (OFF),OFF:1,RET:1,INA:0,ON:1
>> per_clkdm->per_pwrdm (9)
>> usbhost_clkdm->usbhost_pwrdm (0)
>> cam_clkdm->cam_pwrdm (0)
>> dss_clkdm->dss_pwrdm (2)
>> core_l4_clkdm->core_pwrdm (8)
>> core_l3_clkdm->core_pwrdm (4)
>> d2d_clkdm->core_pwrdm (0)
>> sgx_clkdm->sgx_pwrdm (0)
>> iva2_clkdm->iva2_pwrdm (0)
>> neon_clkdm->neon_pwrdm (0)
>> mpu_clkdm->mpu_pwrdm (0)
>> virt_opp_clkdm->wkup_pwrdm (0)
>> prm_clkdm->wkup_pwrdm (10)
>> cm_clkdm->core_pwrdm (3)
>
> Based on this, I see that you're DSS is not the problem anymore as it
> is hitting off, but neither PER nor CORE have made any transistions.
> PER is most likely because of the timer issue above. =C2=A0Not sure yet
> about CORE.
>
> In addtion to more details on your hardware and .config, Can you send
> me the console log of a full boot followed by trying just retention in
> suspend by doing the following right after boot:
>
> # cat /debug/pm_debug/count
> # echo 1 > /sys/power/clocks_off_while_idle
> # echo mem > /sys/power/state
>
> <after wakeup>
>
> # cat /debug/pm_debug/count
> # cat /debug/pm_debug/registers/1

boot log (clockdomain debug output modified to only display messages
regarding the per_clkdm. Debug outpout also modified to display all
clk add and remove events, not just those that change the use count
from 0 to 1 and vice versa)

Texas Instruments X-Loader 1.41
Starting OS Bootloader...


U-Boot 1.3.3 (Jul 10 2008 - 16:33:09)

OMAP3530-GP rev 2, CPU-OPP2 L3-165MHz
OMAP3 Beagle Board + LPDDR/NAND
DRAM:  128 MB
NAND:  256 MiB
In:    serial
Out:   serial
Err:   serial
Audio Tone on Speakers  ... complete
Hit any key to stop autoboot:  0

NAND read: device 0 offset 0x280000, size 0x400000
 4194304 bytes read: OK
## Booting kernel from Legacy Image at 80000000 ...
   Image Name:   Linux-2.6.29-omap1-pm
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    1476992 Bytes =3D  1.4 MB
   Load Address: 80008000
   Entry Point:  80008000
   Verifying Checksum ... OK
   Loading Kernel Image ... OK
OK

Starting kernel ...

Uncompressing Linux........................................................=
........................................
done, booting the kern.
Linux version 2.6.29-omap1-pm (russ@russ-laptop) (gcc version 4.3.1
(GCC) ) #47 PREEMPT Tue Mar 31 14:13:51 MST 2009
CPU: ARMv7 Processor [411fc083] revision 3 (ARMv7), cr=3D10c5387f
CPU: VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
Machine: OMAP3 Beagle Board
Memory policy: ECC disabled, Data cache writeback
OMAP3430 ES3.0
SRAM: Mapped pa 0x40200000 to va 0xd7000000 size: 0x100000
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32512
Kernel command line: console=3DttyS2,115200n8 root=3D/dev/mtdblock4
rootfstype=3Djffs2 rw g_ether.host_addr=3DB6:A3:A1:7D:8F:F0
omapfb.mode=3Ddvi:126
Unknown boot option `g_ether.host_addr=3DB6:A3:A1:7D:8F:F0': ignoring
Unknown boot option `omapfb.mode=3Ddvi:1280x720M-16': ignoring
Clocking rate (Crystal/DPLL/ARM core): 26.0/332/500 MHz
Reprogramming SDRC
GPMC revision 5.0
IRQ: Found an INTC at 0xd8200000 (revision 4.0) with 96 interrupts
Total of 96 interrupts on 1 active controller
OMAP34xx GPIO hardware version 2.5
PID hash table entries: 512 (order: 9, 2048 bytes)
OMAP clockevent source: GPTIMER12 at 32768 Hz
Console: colour dummy device 80x30
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 128MB =3D 128MB total
Memory: 126648KB available (2692K code, 299K data, 96K init)
Calibrating delay loop... 491.57 BogoMIPS (lpj=3D1921024)
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
net_namespace: 544 bytes
regulator: core version 0.5
NET: Registered protocol family 16
Found NAND on CS0
Registering NAND on CS0
OMAP DMA hardware revision 4.0
bio: create slab <bio-0> at 0
i2c_omap i2c_omap.1: bus 1 rev3.12 at 2600 kHz
twl4030: PIH (irq 7) chaining IRQs 368..375
twl4030: power (irq 373) chaining IRQs 376..383
twl4030: gpio (irq 368) chaining IRQs 384..401
beagle_twl_gpio_setup:145
twl4030_mmc_init:324
twl4030_mmc_init:339
regulator: VMMC1: 1850 <--> 3150 mV normal standby
regulator: VDAC: 1800 mV normal standby
regulator: VUSB1V5: 1500 <--> 0 mV normal standby
regulator: VUSB1V8: 1800 <--> 0 mV normal standby
regulator: VUSB3V1: 3100 <--> 0 mV normal standby
regulator: VPLL2: 1800 mV normal standby
regulator: VSIM: 1800 <--> 3000 mV normal standby
i2c_omap i2c_omap.3: bus 3 rev3.12 at 100 kHz
SCSI subsystem initialized
twl4030_usb twl4030_usb: Initialized TWL4030 USB module
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 4096 (order: 3, 32768 bytes)
TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
TCP: Hash tables configured (established 4096 bind 4096)
TCP reno registered
NET: Registered protocol family 1
VFS: Disk quotas dquot_6.5.2
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
JFFS2 version 2.2. (NAND) =C2=A9 2001-2006 Red Hat, Inc.
msgmni has been set to 247
alg: No test for stdrng (krng)
io scheduler noop registered (default)
omapfb: configured for panel omap3beagle
omapfb: skipping hardware initialization
omapfb: DISPC version 3.0 initialized
Console: switching to colour frame buffer device 128x48
omapfb: Framebuffer initialized. Total vram 1572864 planes 1
omapfb: Pixclock 64000 kHz hfreq 59.0 kHz vfreq 76.9 Hz
Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
serial8250.0: ttyS0 at MMIO 0x4806a000 (irq =3D 72) is a ST16654
serial8250.0: ttyS1 at MMIO 0x4806c000 (irq =3D 73) is a ST16654
serial8250.0: ttyS2 at MMIO 0x49020000 (irq =3D 74) is a ST16654
console [ttyS2] enabled
i2c /dev entries driver
Driver 'sd' needs updating - please use bus_type methods
omap2-nand driver initializing
NAND device: Manufacturer ID: 0x2c, Chip ID: 0xba (Micron NAND 256MiB
1,8V 16-bit)
cmdlinepart partition parsing not available
Creating 5 MTD partitions on "omap2-nand":
0x000000000000-0x000000080000 : "X-Loader"
0x000000080000-0x000000260000 : "U-Boot"
0x000000260000-0x000000280000 : "U-Boot Env"
0x000000280000-0x000000680000 : "Kernel"
0x000000680000-0x000010000000 : "File System"
twl4030_rtc twl4030_rtc: rtc core: registered twl4030_rtc as rtc0
cpuidle: using governor ladder
cpuidle: using governor menu
mmci-omap-hs mmci-omap-hs.0: Failed to get debounce clock
TCP cubic registered
NET: Registered protocol family 17
NET: Registered protocol family 15
Power Management for TI OMAP3.
pm_dbg_init()
Disabling unused clock "sr2_fck"
Disabling unused clock "sr1_fck"
Disabling unused clock "mcbsp_fck"
Disabling unused clock "mcbsp_fck"
Disabling unused clock "mcbsp_fck"
Disabling unused clock "mcbsp_ick"
Disabling unused clock "mcbsp_ick"
Disabling unused clock "mcbsp_ick"
Disabling unused clock "gpt2_ick"
Disabling unused clock "gpt3_ick"
Disabling unused clock "gpt4_ick"
Disabling unused clock "gpt5_ick"
Disabling unused clock "gpt6_ick"
Disabling unused clock "gpt7_ick"
Disabling unused clock "gpt8_ick"
Disabling unused clock "gpt9_ick"
Disabling unused clock "wdt3_ick"
Disabling unused clock "wdt3_fck"
Disabling unused clock "gpio2_dbck"
Disabling unused clock "gpio3_dbck"
Disabling unused clock "gpio4_dbck"
Disabling unused clock "gpio5_dbck"
Disabling unused clock "gpio6_dbck"
Disabling unused clock "gpt9_fck"
Disabling unused clock "gpt8_fck"
Disabling unused clock "gpt7_fck"
Disabling unused clock "gpt6_fck"
Disabling unused clock "gpt5_fck"
Disabling unused clock "gpt4_fck"
Disabling unused clock "gpt3_fck"
Disabling unused clock "gpt2_fck"
Disabling unused clock "gpt1_ick"
Disabling unused clock "wdt1_ick"
Disabling unused clock "wdt2_ick"
Disabling unused clock "wdt2_fck"
Disabling unused clock "gpio1_dbck"
Disabling unused clock "gpt1_fck"
Disabling unused clock "cam_ick"
Disabling unused clock "cam_mclk"
Disabling unused clock "dss_96m_fck"
Disabling unused clock "des1_ick"
Disabling unused clock "sha11_ick"
Disabling unused clock "rng_ick"
Disabling unused clock "aes1_ick"
Disabling unused clock "ssi_ick"
Disabling unused clock "mailboxes_ick"
Disabling unused clock "mcbsp_ick"
Disabling unused clock "mcbsp_ick"
Disabling unused clock "gpt10_ick"
Disabling unused clock "gpt11_ick"
Disabling unused clock "i2c_ick"
Disabling unused clock "mcspi_ick"
Disabling unused clock "mcspi_ick"
Disabling unused clock "mcspi_ick"
Disabling unused clock "mcspi_ick"
Disabling unused clock "hdq_ick"
Disabling unused clock "mspro_ick"
Disabling unused clock "des2_ick"
Disabling unused clock "sha12_ick"
Disabling unused clock "aes2_ick"
Disabling unused clock "icr_ick"
Disabling unused clock "pka_ick"
Disabling unused clock "hsotgusb_ick"
Disabling unused clock "ssi_ssr_fck"
Disabling unused clock "hdq_fck"
Disabling unused clock "mcspi_fck"
Disabling unused clock "mcspi_fck"
Disabling unused clock "mcspi_fck"
Disabling unused clock "mcspi_fck"
Disabling unused clock "mcbsp_fck"
Disabling unused clock "mcbsp_fck"
Disabling unused clock "i2c_fck"
Disabling unused clock "mspro_fck"
Disabling unused clock "gpt11_fck"
Disabling unused clock "gpt10_fck"
Disabling unused clock "sad2d_ick"
Disabling unused clock "dpll5_ck"
clock: dpll5_ck failed transition to 'locked'
Disabling unused clock "dpll4_m6x2_ck"
Disabling unused clock "dpll4_m3x2_ck"
Disabling unused clock "dpll3_m3x2_ck"
Disabling unused clock "sys_clkout1"
VFP support v0.3: implementor 41 architecture 3 part 30 variant c rev 1
twl4030_rtc twl4030_rtc: setting system clock to 2009-02-28 14:45:54
UTC (1235832354)
Empty flash at 0x014d884c ends at 0x014d9000
Empty flash at 0x0365d678 ends at 0x0365d800
Empty flash at 0x03d4b128 ends at 0x03d4b800
Empty flash at 0x065f2240 ends at 0x065f2800
Empty flash at 0x081d3c08 ends at 0x081d4000
jffs2_scan_dirent_node(): Node CRC failed on node at 0x082bdfe4: Read
0xffffffff, calculated 0x8bd04d99
Empty flash at 0x082be01c ends at 0x082be800
Empty flash at 0x0ee1e7cc ends at 0x0ee1e800
JFFS2 error: (1) jffs2_build_inode_pass1: child dir "players" (ino
#35930) of dir ino #35929 appears to be a hard link
VFS: Mounted root (jffs2 filesystem) on device 31:4.
Freeing init memory: 96K
INIT: version 2.86 booting

Please wait: booting...
Starting udevudevd version 124 started

Remounting root file system...
uncorrectable error : <3>uncorrectable error : <3>end_request: I/O
error, dev mtdblock0, sector 0
Buffer I/O error on device mtdblock0, logical block 0
uncorrectable error : <3>end_request: I/O error, dev mtdblock0, sector 8
Buffer I/O error on device mtdblock0, logical block 1
uncorrectable error : <3>end_request: I/O error, dev mtdblock0, sector 16
Buffer I/O error on device mtdblock0, logical block 2
uncorrectable error : <3>end_request: I/O error, dev mtdblock0, sector 24
Buffer I/O error on device mtdblock0, logical block 3
uncorrectable error : <3>uncorrectable error : <3>end_request: I/O
error, dev mtdblock0, sector 0
Buffer I/O error on device mtdblock0, logical block 0
logger: mount: mount point /proc/bus/usb does not exist
ALSA: Restoring mixer settings...
Configuring network interfaces... done.
Starting portmap daemon: portmap.
net.ipv4.conf.default.rp_filter =3D 1
net.ipv4.conf.all.rp_filter =3D 1
/usr/sbin/alsactl: load_state:1616: No soundcards found...
INIT: Entering runlevel: 5
No LEDs detected
Starting Dropbear SSH server: dropbear.
Starting advanced power management daemon: No APM support in kernel
(failed.)
Starting system message bus: dbus.
Starting Hardware abstraction layer hald
Starting syslogd/klogd: done
 * Starting Avahi mDNS/DNS-SD Daemon: avahi-daemon
[ ok ]
Starting Bluetooth subsystem: hcid hid2hci.
Starting hidd...
Can't open HIDP control socket: Address family not supported by protocol
Starting pand...
Failed to open control socket: Address family not supported by protocol
Running ntpdate to synchronize clockError : Temporary failure in name resol=
ution
.
ERROR: Module omaplfb does not exist in /proc/modules
ERROR: Module pvrsrvkm does not exist in /proc/modules
Usage: insmod filename [args]
FATAL: Module omaplfb not found.
mknod: missing operand after `0'
Try `mknod --help' for more information.
chmod: cannot access `/dev/pvrsrvkm': No such file or directory
/dev/mem opened.
Memory mapped at address 0x4001f000.
Value at address 0x48004B40 (0x4001fb40): 0x2
Written 0x0; readback 0x0
Starting GPE display manager: gpe-dm

.-------.
|       |                  .-.
|   |   |-----.-----.-----.| |   .----..-----.-----.
|       |     | __  |  ---'| '--.|  .-'|     |     |
|   |   |  |  |     |---  ||  --'|  |  |  '  | | | |
'---'---'--'--'--.  |-----''----''--'  '-----'-'-'-'
                -'  |
                '---'

The Angstrom Distribution beagleboard ttyS2

Angstrom 2009.X-test-20090309 beagleboard ttyS2

beagleboard login: root
root@beagleboard:~# mount /debug/
root@beagleboard:~# cd /sys/power/
root@beagleboard:/sys/power# echo 1 > clocks_off_while_idle
root@beagleboard:/sys/power# dmesg -n 8
root@beagleboard:/sys/power# echo mem > state
PM: Syncing filesystems ... done.
PM: Preparing system for mem sleep
Freezing user space processes ... (elapsed 0.00 seconds) done.
Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
PM: Entering mem sleep
Suspending console(s) (use no_console_suspend to debug)
omapfb omapfb: timeout waiting for FRAME DONE
clockdomain: clkdm per_clkdm: removing clk uart3_ick
clockdomain: clkdm per_clkdm: removing clk per_48m_fck
clockdomain: clkdm per_clkdm: removing clk uart3_fck
clockdomain: clkdm per_clkdm: adding clk uart3_ick
clockdomain: clkdm per_clkdm: adding clk uart3_fck
clockdomain: clkdm per_clkdm: adding clk per_48m_fck
Powerdomain (core_pwrdm) didn't enter target state 1
Powerdomain (per_pwrdm) didn't enter target state 1
Could not enter target state in pm_suspend
PM: Finishing wakeup.
Restarting tasks ... done.
root@beagleboard:/sys/power# cat /debug/pm_debug/count
usbhost_pwrdm (RET),OFF:0,RET:1,INA:0,ON:1
sgx_pwrdm (OFF),OFF:1,RET:0,INA:0,ON:1
per_pwrdm (ON),OFF:0,RET:0,INA:0,ON:1
dss_pwrdm (ON),OFF:0,RET:1,INA:0,ON:2
cam_pwrdm (RET),OFF:0,RET:1,INA:0,ON:1
core_pwrdm (ON),OFF:0,RET:0,INA:0,ON:1
neon_pwrdm (ON),OFF:0,RET:1,INA:958,ON:960
mpu_pwrdm (ON),OFF:0,RET:1,INA:958,ON:960
iva2_pwrdm (RET),OFF:0,RET:1,INA:0,ON:1
per_clkdm->per_pwrdm (9)
usbhost_clkdm->usbhost_pwrdm (0)
cam_clkdm->cam_pwrdm (0)
dss_clkdm->dss_pwrdm (2)
core_l4_clkdm->core_pwrdm (11)
core_l3_clkdm->core_pwrdm (4)
d2d_clkdm->core_pwrdm (0)
sgx_clkdm->sgx_pwrdm (0)
iva2_clkdm->iva2_pwrdm (0)
neon_clkdm->neon_pwrdm (0)
mpu_clkdm->mpu_pwrdm (0)
virt_opp_clkdm->wkup_pwrdm (0)
prm_clkdm->wkup_pwrdm (10)
cm_clkdm->core_pwrdm (4)
root@beagleboard:/sys/power# cat /debug/pm_debug/registers/1
MOD: CM_IVA2 (48014000)
  04 =3D> 00000037  20 =3D> 00000001  34 =3D> 00000001  40 =3D> 0009680c
  44 =3D> 00000001  48 =3D> 00000003
MOD: CM_OCP (48004800)
  00 =3D> 00000010  10 =3D> 00000001
MOD: CM_MPU (48004900)
  04 =3D> 00000037  24 =3D> 00000001  34 =3D> 00000001  40 =3D> 0011f40c
  44 =3D> 00000001  48 =3D> 00000003  4c =3D> 00000001
MOD: CM_CORE (48004a00)
  10 =3D> 00000042  20 =3D> ffffffbd  24 =3D> 0000001f  28 =3D> 0000000d
  30 =3D> fffffed9  34 =3D> 0000001f  38 =3D> 0000000c  40 =3D> 0000030a
  48 =3D> 0000003f  4c =3D> 00000003
MOD: CM_SGX (48004b00)
  20 =3D> 00000001  48 =3D> 00000003
MOD: CM_WKUP (48004c00)
  10 =3D> 0000000e  20 =3D> 000002f1  30 =3D> 0000003f  40 =3D> 00000015
MOD: CM_CCR (48004d00)
  00 =3D> f8311037  04 =3D> 00000017  20 =3D> 00000201  30 =3D> 00000009
  34 =3D> 00000001  40 =3D> 094c0c00  44 =3D> 0001b00c  48 =3D> 00000009
  50 =3D> 00000001  70 =3D> 00000003
MOD: CM_DSS (48004e00)
  20 =3D> 00000003  30 =3D> 00000001  40 =3D> 00001006  48 =3D> 00000003
MOD: CM_CAM (48004f00)
  20 =3D> 00000001  30 =3D> 00000001  40 =3D> 00000004  48 =3D> 00000003
MOD: CM_PER (48005000)
  10 =3D> 0003e000  20 =3D> 00001fff  30 =3D> 0003ffff  40 =3D> 000000ff
  44 =3D> 00000006  48 =3D> 00000003  4c =3D> 00000001
MOD: CM_EMU (48005100)
  40 =3D> 03020a50  48 =3D> 00000001
MOD: CM_NEON (48005300)
  48 =3D> 00000003
MOD: CM_USB (48005400)
  20 =3D> 00000003  30 =3D> 00000001  48 =3D> 00000003
MOD: PRM_IVA2 (48316000)
  50 =3D> 00000007  e0 =3D> 00ff0f05  e4 =3D> 00000555  e8 =3D> 00000555
  f8 =3D> 00000005
MOD: PRM_OCP (48306800)
  04 =3D> 00000010  14 =3D> 00000001  1c =3D> 00000201
MOD: PRM_MPU (48306900)
  58 =3D> 00000001  d4 =3D> 00000012  e0 =3D> 00030105  e4 =3D> 000000c7
  e8 =3D> 000000c7
MOD: PRM_CORE (48306a00)
  58 =3D> 00000301  a0 =3D> c33ffe18  a4 =3D> c33ffe18  a8 =3D> c33ffe18
  e0 =3D> 000f0305  e4 =3D> 000000f7  e8 =3D> 000000f7  f0 =3D> 00000004
  f4 =3D> 00000004  f8 =3D> 00000004
MOD: PRM_SGX (48306b00)
  e0 =3D> 00030104
MOD: PRM_WKUP (48306c00)
  a0 =3D> 0000010b  a4 =3D> 0000010b
MOD: PRM_CCR (48306d00)
  40 =3D> 00000003
MOD: PRM_DSS (48306e00)
  58 =3D> 00000001  a0 =3D> 00000001  e0 =3D> 00030105  e4 =3D> 00000001
  e8 =3D> 00000001
MOD: PRM_CAM (48306f00)
  58 =3D> 00000001  e0 =3D> 00030105  e4 =3D> 00000001  e8 =3D> 00000001
MOD: PRM_PER (48307000)
  58 =3D> 00000001  a0 =3D> 0003efff  a4 =3D> 0003efff  a8 =3D> 0003efff
  c8 =3D> 00000007  e0 =3D> 00030105  e4 =3D> 00000007  e8 =3D> 00000007
MOD: PRM_EMU (48307100)
  58 =3D> 00000001  e4 =3D> 00000100
MOD: PRM_GLBL (48307200)
  20 =3D> 00120012  24 =3D> 00010000  2c =3D> 301e1e30  30 =3D> 2c1e1e2c
  34 =3D> 00120000  38 =3D> 00000018  54 =3D> 00001006  58 =3D> 00000001
  60 =3D> 00000002  64 =3D> 00000050  70 =3D> 00000088  90 =3D> 0fff0fff
  94 =3D> 000000ff  98 =3D> 000000ff  9c =3D> 00000002  a0 =3D> 000000ff
  c4 =3D> 00000001  e4 =3D> 00000001
MOD: PRM_NEON (48307300)
  58 =3D> 00000001  c8 =3D> 00000002  e0 =3D> 00000005  e4 =3D> 00000003
  e8 =3D> 00000003
MOD: PRM_USB (48307400)
  58 =3D> 00000001  a0 =3D> 00000001  a4 =3D> 00000001  a8 =3D> 00000001
  e0 =3D> 00030105  e4 =3D> 00000001  e8 =3D> 00000001
root@beagleboard:/sys/power#

--000e0cd1554c354a28046670eb9f
Content-Type: application/octet-stream; name=".config"
Content-Disposition: attachment; filename=".config"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fsz3qxf50

IwojIEF1dG9tYXRpY2FsbHkgZ2VuZXJhdGVkIG1ha2UgY29uZmlnOiBkb24ndCBlZGl0CiMgTGlu
dXgga2VybmVsIHZlcnNpb246IDIuNi4yOS1vbWFwMQojIE1vbiBNYXIgMzAgMjE6MTQ6NTcgMjAw
OQojCkNPTkZJR19BUk09eQpDT05GSUdfU1lTX1NVUFBPUlRTX0FQTV9FTVVMQVRJT049eQpDT05G
SUdfR0VORVJJQ19HUElPPXkKQ09ORklHX0dFTkVSSUNfVElNRT15CkNPTkZJR19HRU5FUklDX0NM
T0NLRVZFTlRTPXkKQ09ORklHX01NVT15CiMgQ09ORklHX05PX0lPUE9SVCBpcyBub3Qgc2V0CkNP
TkZJR19HRU5FUklDX0hBUkRJUlFTPXkKQ09ORklHX1NUQUNLVFJBQ0VfU1VQUE9SVD15CkNPTkZJ
R19IQVZFX0xBVEVOQ1lUT1BfU1VQUE9SVD15CkNPTkZJR19MT0NLREVQX1NVUFBPUlQ9eQpDT05G
SUdfVFJBQ0VfSVJRRkxBR1NfU1VQUE9SVD15CkNPTkZJR19IQVJESVJRU19TV19SRVNFTkQ9eQpD
T05GSUdfR0VORVJJQ19JUlFfUFJPQkU9eQpDT05GSUdfUldTRU1fR0VORVJJQ19TUElOTE9DSz15
CiMgQ09ORklHX0FSQ0hfSEFTX0lMT0cyX1UzMiBpcyBub3Qgc2V0CiMgQ09ORklHX0FSQ0hfSEFT
X0lMT0cyX1U2NCBpcyBub3Qgc2V0CkNPTkZJR19HRU5FUklDX0hXRUlHSFQ9eQpDT05GSUdfR0VO
RVJJQ19DQUxJQlJBVEVfREVMQVk9eQpDT05GSUdfR0VORVJJQ19IQVJESVJRU19OT19fRE9fSVJR
PXkKQ09ORklHX1ZFQ1RPUlNfQkFTRT0weGZmZmYwMDAwCkNPTkZJR19ERUZDT05GSUdfTElTVD0i
L2xpYi9tb2R1bGVzLyRVTkFNRV9SRUxFQVNFLy5jb25maWciCgojCiMgR2VuZXJhbCBzZXR1cAoj
CkNPTkZJR19FWFBFUklNRU5UQUw9eQpDT05GSUdfQlJPS0VOX09OX1NNUD15CkNPTkZJR19MT0NL
X0tFUk5FTD15CkNPTkZJR19JTklUX0VOVl9BUkdfTElNSVQ9MzIKQ09ORklHX0xPQ0FMVkVSU0lP
Tj0iLXBtIgojIENPTkZJR19MT0NBTFZFUlNJT05fQVVUTyBpcyBub3Qgc2V0CiMgQ09ORklHX1NX
QVAgaXMgbm90IHNldApDT05GSUdfU1lTVklQQz15CkNPTkZJR19TWVNWSVBDX1NZU0NUTD15CiMg
Q09ORklHX1BPU0lYX01RVUVVRSBpcyBub3Qgc2V0CkNPTkZJR19CU0RfUFJPQ0VTU19BQ0NUPXkK
IyBDT05GSUdfQlNEX1BST0NFU1NfQUNDVF9WMyBpcyBub3Qgc2V0CiMgQ09ORklHX1RBU0tTVEFU
UyBpcyBub3Qgc2V0CiMgQ09ORklHX0FVRElUIGlzIG5vdCBzZXQKCiMKIyBSQ1UgU3Vic3lzdGVt
CiMKQ09ORklHX0NMQVNTSUNfUkNVPXkKIyBDT05GSUdfVFJFRV9SQ1UgaXMgbm90IHNldAojIENP
TkZJR19QUkVFTVBUX1JDVSBpcyBub3Qgc2V0CiMgQ09ORklHX1RSRUVfUkNVX1RSQUNFIGlzIG5v
dCBzZXQKIyBDT05GSUdfUFJFRU1QVF9SQ1VfVFJBQ0UgaXMgbm90IHNldAojIENPTkZJR19JS0NP
TkZJRyBpcyBub3Qgc2V0CkNPTkZJR19MT0dfQlVGX1NISUZUPTE0CiMgQ09ORklHX0dST1VQX1ND
SEVEIGlzIG5vdCBzZXQKIyBDT05GSUdfQ0dST1VQUyBpcyBub3Qgc2V0CiMgQ09ORklHX1NZU0ZT
X0RFUFJFQ0FURURfVjIgaXMgbm90IHNldAojIENPTkZJR19SRUxBWSBpcyBub3Qgc2V0CiMgQ09O
RklHX05BTUVTUEFDRVMgaXMgbm90IHNldAojIENPTkZJR19CTEtfREVWX0lOSVRSRCBpcyBub3Qg
c2V0CkNPTkZJR19DQ19PUFRJTUlaRV9GT1JfU0laRT15CkNPTkZJR19TWVNDVEw9eQpDT05GSUdf
QU5PTl9JTk9ERVM9eQpDT05GSUdfRU1CRURERUQ9eQpDT05GSUdfVUlEMTY9eQojIENPTkZJR19T
WVNDVExfU1lTQ0FMTCBpcyBub3Qgc2V0CkNPTkZJR19LQUxMU1lNUz15CiMgQ09ORklHX0tBTExT
WU1TX0FMTCBpcyBub3Qgc2V0CkNPTkZJR19LQUxMU1lNU19FWFRSQV9QQVNTPXkKQ09ORklHX0hP
VFBMVUc9eQpDT05GSUdfUFJJTlRLPXkKQ09ORklHX0JVRz15CkNPTkZJR19FTEZfQ09SRT15CkNP
TkZJR19CQVNFX0ZVTEw9eQpDT05GSUdfRlVURVg9eQpDT05GSUdfRVBPTEw9eQpDT05GSUdfU0lH
TkFMRkQ9eQpDT05GSUdfVElNRVJGRD15CkNPTkZJR19FVkVOVEZEPXkKQ09ORklHX1NITUVNPXkK
Q09ORklHX0FJTz15CkNPTkZJR19WTV9FVkVOVF9DT1VOVEVSUz15CkNPTkZJR19DT01QQVRfQlJL
PXkKQ09ORklHX1NMQUI9eQojIENPTkZJR19TTFVCIGlzIG5vdCBzZXQKIyBDT05GSUdfU0xPQiBp
cyBub3Qgc2V0CiMgQ09ORklHX1BST0ZJTElORyBpcyBub3Qgc2V0CkNPTkZJR19IQVZFX09QUk9G
SUxFPXkKIyBDT05GSUdfS1BST0JFUyBpcyBub3Qgc2V0CkNPTkZJR19IQVZFX0tQUk9CRVM9eQpD
T05GSUdfSEFWRV9LUkVUUFJPQkVTPXkKQ09ORklHX0hBVkVfQ0xLPXkKQ09ORklHX0hBVkVfR0VO
RVJJQ19ETUFfQ09IRVJFTlQ9eQpDT05GSUdfU0xBQklORk89eQpDT05GSUdfUlRfTVVURVhFUz15
CkNPTkZJR19CQVNFX1NNQUxMPTAKQ09ORklHX01PRFVMRVM9eQojIENPTkZJR19NT0RVTEVfRk9S
Q0VfTE9BRCBpcyBub3Qgc2V0CkNPTkZJR19NT0RVTEVfVU5MT0FEPXkKIyBDT05GSUdfTU9EVUxF
X0ZPUkNFX1VOTE9BRCBpcyBub3Qgc2V0CkNPTkZJR19NT0RWRVJTSU9OUz15CkNPTkZJR19NT0RV
TEVfU1JDVkVSU0lPTl9BTEw9eQpDT05GSUdfQkxPQ0s9eQojIENPTkZJR19MQkQgaXMgbm90IHNl
dAojIENPTkZJR19CTEtfREVWX0lPX1RSQUNFIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9C
U0cgaXMgbm90IHNldAojIENPTkZJR19CTEtfREVWX0lOVEVHUklUWSBpcyBub3Qgc2V0CgojCiMg
SU8gU2NoZWR1bGVycwojCkNPTkZJR19JT1NDSEVEX05PT1A9eQojIENPTkZJR19JT1NDSEVEX0FT
IGlzIG5vdCBzZXQKIyBDT05GSUdfSU9TQ0hFRF9ERUFETElORSBpcyBub3Qgc2V0CiMgQ09ORklH
X0lPU0NIRURfQ0ZRIGlzIG5vdCBzZXQKIyBDT05GSUdfREVGQVVMVF9BUyBpcyBub3Qgc2V0CiMg
Q09ORklHX0RFRkFVTFRfREVBRExJTkUgaXMgbm90IHNldAojIENPTkZJR19ERUZBVUxUX0NGUSBp
cyBub3Qgc2V0CkNPTkZJR19ERUZBVUxUX05PT1A9eQpDT05GSUdfREVGQVVMVF9JT1NDSEVEPSJu
b29wIgpDT05GSUdfRlJFRVpFUj15CgojCiMgU3lzdGVtIFR5cGUKIwojIENPTkZJR19BUkNIX0FB
RUMyMDAwIGlzIG5vdCBzZXQKIyBDT05GSUdfQVJDSF9JTlRFR1JBVE9SIGlzIG5vdCBzZXQKIyBD
T05GSUdfQVJDSF9SRUFMVklFVyBpcyBub3Qgc2V0CiMgQ09ORklHX0FSQ0hfVkVSU0FUSUxFIGlz
IG5vdCBzZXQKIyBDT05GSUdfQVJDSF9BVDkxIGlzIG5vdCBzZXQKIyBDT05GSUdfQVJDSF9DTFBT
NzExWCBpcyBub3Qgc2V0CiMgQ09ORklHX0FSQ0hfRUJTQTExMCBpcyBub3Qgc2V0CiMgQ09ORklH
X0FSQ0hfRVA5M1hYIGlzIG5vdCBzZXQKIyBDT05GSUdfQVJDSF9GT09UQlJJREdFIGlzIG5vdCBz
ZXQKIyBDT05GSUdfQVJDSF9ORVRYIGlzIG5vdCBzZXQKIyBDT05GSUdfQVJDSF9INzIwWCBpcyBu
b3Qgc2V0CiMgQ09ORklHX0FSQ0hfSU1YIGlzIG5vdCBzZXQKIyBDT05GSUdfQVJDSF9JT1AxM1hY
IGlzIG5vdCBzZXQKIyBDT05GSUdfQVJDSF9JT1AzMlggaXMgbm90IHNldAojIENPTkZJR19BUkNI
X0lPUDMzWCBpcyBub3Qgc2V0CiMgQ09ORklHX0FSQ0hfSVhQMjNYWCBpcyBub3Qgc2V0CiMgQ09O
RklHX0FSQ0hfSVhQMjAwMCBpcyBub3Qgc2V0CiMgQ09ORklHX0FSQ0hfSVhQNFhYIGlzIG5vdCBz
ZXQKIyBDT05GSUdfQVJDSF9MNzIwMCBpcyBub3Qgc2V0CiMgQ09ORklHX0FSQ0hfS0lSS1dPT0Qg
aXMgbm90IHNldAojIENPTkZJR19BUkNIX0tTODY5NSBpcyBub3Qgc2V0CiMgQ09ORklHX0FSQ0hf
TlM5WFhYIGlzIG5vdCBzZXQKIyBDT05GSUdfQVJDSF9MT0tJIGlzIG5vdCBzZXQKIyBDT05GSUdf
QVJDSF9NVjc4WFgwIGlzIG5vdCBzZXQKIyBDT05GSUdfQVJDSF9NWEMgaXMgbm90IHNldAojIENP
TkZJR19BUkNIX09SSU9ONVggaXMgbm90IHNldAojIENPTkZJR19BUkNIX1BOWDQwMDggaXMgbm90
IHNldAojIENPTkZJR19BUkNIX1BYQSBpcyBub3Qgc2V0CiMgQ09ORklHX0FSQ0hfUlBDIGlzIG5v
dCBzZXQKIyBDT05GSUdfQVJDSF9TQTExMDAgaXMgbm90IHNldAojIENPTkZJR19BUkNIX1MzQzI0
MTAgaXMgbm90IHNldAojIENPTkZJR19BUkNIX1MzQzY0WFggaXMgbm90IHNldAojIENPTkZJR19B
UkNIX1NIQVJLIGlzIG5vdCBzZXQKIyBDT05GSUdfQVJDSF9MSDdBNDBYIGlzIG5vdCBzZXQKIyBD
T05GSUdfQVJDSF9EQVZJTkNJIGlzIG5vdCBzZXQKQ09ORklHX0FSQ0hfT01BUD15CiMgQ09ORklH
X0FSQ0hfTVNNIGlzIG5vdCBzZXQKIyBDT05GSUdfQVJDSF9XOTBYOTAwIGlzIG5vdCBzZXQKCiMK
IyBUSSBPTUFQIEltcGxlbWVudGF0aW9ucwojCkNPTkZJR19BUkNIX09NQVBfT1RHPXkKIyBDT05G
SUdfQVJDSF9PTUFQMSBpcyBub3Qgc2V0CiMgQ09ORklHX0FSQ0hfT01BUDIgaXMgbm90IHNldApD
T05GSUdfQVJDSF9PTUFQMz15CgojCiMgT01BUCBGZWF0dXJlIFNlbGVjdGlvbnMKIwojIENPTkZJ
R19PTUFQX0RFQlVHX1BPV0VSRE9NQUlOIGlzIG5vdCBzZXQKQ09ORklHX09NQVBfREVCVUdfQ0xP
Q0tET01BSU49eQojIENPTkZJR19PTUFQX1NNQVJUUkVGTEVYIGlzIG5vdCBzZXQKQ09ORklHX09N
QVBfUkVTRVRfQ0xPQ0tTPXkKQ09ORklHX09NQVBfQk9PVF9UQUc9eQpDT05GSUdfT01BUF9CT09U
X1JFQVNPTj15CiMgQ09ORklHX09NQVBfQ09NUE9ORU5UX1ZFUlNJT04gaXMgbm90IHNldAojIENP
TkZJR19PTUFQX0dQSU9fU1dJVENIIGlzIG5vdCBzZXQKIyBDT05GSUdfT01BUF9NVVggaXMgbm90
IHNldAojIENPTkZJR19PTUFQX01DQlNQIGlzIG5vdCBzZXQKIyBDT05GSUdfT01BUF9NQk9YX0ZX
SyBpcyBub3Qgc2V0CiMgQ09ORklHX09NQVBfTVBVX1RJTUVSIGlzIG5vdCBzZXQKQ09ORklHX09N
QVBfMzJLX1RJTUVSPXkKIyBDT05GSUdfT01BUDNfREVCT0JTIGlzIG5vdCBzZXQKQ09ORklHX09N
QVBfMzJLX1RJTUVSX0haPTEyOApDT05GSUdfT01BUF9USUNLX0dQVElNRVI9MTIKQ09ORklHX09N
QVBfRE1fVElNRVI9eQojIENPTkZJR19PTUFQX0xMX0RFQlVHX1VBUlQxIGlzIG5vdCBzZXQKIyBD
T05GSUdfT01BUF9MTF9ERUJVR19VQVJUMiBpcyBub3Qgc2V0CkNPTkZJR19PTUFQX0xMX0RFQlVH
X1VBUlQzPXkKIyBDT05GSUdfT01BUF9QTV9OT05FIGlzIG5vdCBzZXQKQ09ORklHX09NQVBfUE1f
Tk9PUD15CiMgQ09ORklHX09NQVBfUE1fU1JGIGlzIG5vdCBzZXQKQ09ORklHX0FSQ0hfT01BUDM0
WFg9eQpDT05GSUdfQVJDSF9PTUFQMzQzMD15CgojCiMgT01BUCBCb2FyZCBUeXBlCiMKIyBDT05G
SUdfTUFDSF9OT0tJQV9SWDUxIGlzIG5vdCBzZXQKIyBDT05GSUdfTUFDSF9PTUFQX0xEUCBpcyBu
b3Qgc2V0CiMgQ09ORklHX01BQ0hfT01BUF8zNDMwU0RQIGlzIG5vdCBzZXQKIyBDT05GSUdfTUFD
SF9PTUFQM0VWTSBpcyBub3Qgc2V0CkNPTkZJR19NQUNIX09NQVAzX0JFQUdMRT15CiMgQ09ORklH
X01BQ0hfT1ZFUk8gaXMgbm90IHNldAojIENPTkZJR19NQUNIX09NQVAzX1BBTkRPUkEgaXMgbm90
IHNldAoKIwojIFByb2Nlc3NvciBUeXBlCiMKQ09ORklHX0NQVV8zMj15CkNPTkZJR19DUFVfMzJ2
Nks9eQpDT05GSUdfQ1BVX1Y3PXkKQ09ORklHX0NQVV8zMnY3PXkKQ09ORklHX0NQVV9BQlJUX0VW
Nz15CkNPTkZJR19DUFVfUEFCUlRfSUZBUj15CkNPTkZJR19DUFVfQ0FDSEVfVjc9eQpDT05GSUdf
Q1BVX0NBQ0hFX1ZJUFQ9eQpDT05GSUdfQ1BVX0NPUFlfVjY9eQpDT05GSUdfQ1BVX1RMQl9WNz15
CkNPTkZJR19DUFVfSEFTX0FTSUQ9eQpDT05GSUdfQ1BVX0NQMTU9eQpDT05GSUdfQ1BVX0NQMTVf
TU1VPXkKCiMKIyBQcm9jZXNzb3IgRmVhdHVyZXMKIwojIENPTkZJR19BUk1fVEhVTUIgaXMgbm90
IHNldAojIENPTkZJR19BUk1fVEhVTUJFRSBpcyBub3Qgc2V0CiMgQ09ORklHX0NQVV9JQ0FDSEVf
RElTQUJMRSBpcyBub3Qgc2V0CiMgQ09ORklHX0NQVV9EQ0FDSEVfRElTQUJMRSBpcyBub3Qgc2V0
CiMgQ09ORklHX0NQVV9CUFJFRElDVF9ESVNBQkxFIGlzIG5vdCBzZXQKQ09ORklHX0hBU19UTFNf
UkVHPXkKIyBDT05GSUdfT1VURVJfQ0FDSEUgaXMgbm90IHNldAoKIwojIEJ1cyBzdXBwb3J0CiMK
IyBDT05GSUdfUENJX1NZU0NBTEwgaXMgbm90IHNldAojIENPTkZJR19BUkNIX1NVUFBPUlRTX01T
SSBpcyBub3Qgc2V0CiMgQ09ORklHX1BDQ0FSRCBpcyBub3Qgc2V0CgojCiMgS2VybmVsIEZlYXR1
cmVzCiMKQ09ORklHX1RJQ0tfT05FU0hPVD15CkNPTkZJR19OT19IWj15CkNPTkZJR19ISUdIX1JF
U19USU1FUlM9eQpDT05GSUdfR0VORVJJQ19DTE9DS0VWRU5UU19CVUlMRD15CkNPTkZJR19WTVNQ
TElUXzNHPXkKIyBDT05GSUdfVk1TUExJVF8yRyBpcyBub3Qgc2V0CiMgQ09ORklHX1ZNU1BMSVRf
MUcgaXMgbm90IHNldApDT05GSUdfUEFHRV9PRkZTRVQ9MHhDMDAwMDAwMApDT05GSUdfUFJFRU1Q
VD15CkNPTkZJR19IWj0xMjgKQ09ORklHX0FFQUJJPXkKIyBDT05GSUdfT0FCSV9DT01QQVQgaXMg
bm90IHNldApDT05GSUdfQVJDSF9GTEFUTUVNX0hBU19IT0xFUz15CiMgQ09ORklHX0FSQ0hfU1BB
UlNFTUVNX0RFRkFVTFQgaXMgbm90IHNldAojIENPTkZJR19BUkNIX1NFTEVDVF9NRU1PUllfTU9E
RUwgaXMgbm90IHNldApDT05GSUdfU0VMRUNUX01FTU9SWV9NT0RFTD15CkNPTkZJR19GTEFUTUVN
X01BTlVBTD15CiMgQ09ORklHX0RJU0NPTlRJR01FTV9NQU5VQUwgaXMgbm90IHNldAojIENPTkZJ
R19TUEFSU0VNRU1fTUFOVUFMIGlzIG5vdCBzZXQKQ09ORklHX0ZMQVRNRU09eQpDT05GSUdfRkxB
VF9OT0RFX01FTV9NQVA9eQpDT05GSUdfUEFHRUZMQUdTX0VYVEVOREVEPXkKQ09ORklHX1NQTElU
X1BUTE9DS19DUFVTPTQKIyBDT05GSUdfUEhZU19BRERSX1RfNjRCSVQgaXMgbm90IHNldApDT05G
SUdfWk9ORV9ETUFfRkxBRz0wCkNPTkZJR19WSVJUX1RPX0JVUz15CkNPTkZJR19VTkVWSUNUQUJM
RV9MUlU9eQojIENPTkZJR19MRURTIGlzIG5vdCBzZXQKQ09ORklHX0FMSUdOTUVOVF9UUkFQPXkK
CiMKIyBCb290IG9wdGlvbnMKIwpDT05GSUdfWkJPT1RfUk9NX1RFWFQ9MHgwCkNPTkZJR19aQk9P
VF9ST01fQlNTPTB4MApDT05GSUdfQ01ETElORT0icm9vdD0vZGV2L25mcyBuZnNyb290PTE5Mi4x
NjguMC4xOi9ob21lL3VzZXIvYnVpbGRyb290IGlwPTE5Mi4xNjguMC4yOjE5Mi4xNjguMC4xOjE5
Mi4xNjguMC4xOjI1NS4yNTUuMjU1LjA6dGd0OmV0aDA6b2ZmIHJ3IGNvbnNvbGU9dHR5UzIsMTE1
MjAwbjgiCiMgQ09ORklHX1hJUF9LRVJORUwgaXMgbm90IHNldAojIENPTkZJR19LRVhFQyBpcyBu
b3Qgc2V0CgojCiMgQ1BVIFBvd2VyIE1hbmFnZW1lbnQKIwojIENPTkZJR19DUFVfRlJFUSBpcyBu
b3Qgc2V0CkNPTkZJR19DUFVfSURMRT15CkNPTkZJR19DUFVfSURMRV9HT1ZfTEFEREVSPXkKQ09O
RklHX0NQVV9JRExFX0dPVl9NRU5VPXkKCiMKIyBGbG9hdGluZyBwb2ludCBlbXVsYXRpb24KIwoK
IwojIEF0IGxlYXN0IG9uZSBlbXVsYXRpb24gbXVzdCBiZSBzZWxlY3RlZAojCkNPTkZJR19WRlA9
eQpDT05GSUdfVkZQdjM9eQojIENPTkZJR19ORU9OIGlzIG5vdCBzZXQKCiMKIyBVc2Vyc3BhY2Ug
YmluYXJ5IGZvcm1hdHMKIwpDT05GSUdfQklORk1UX0VMRj15CiMgQ09ORklHX0NPUkVfRFVNUF9E
RUZBVUxUX0VMRl9IRUFERVJTIGlzIG5vdCBzZXQKQ09ORklHX0hBVkVfQU9VVD15CiMgQ09ORklH
X0JJTkZNVF9BT1VUIGlzIG5vdCBzZXQKIyBDT05GSUdfQklORk1UX01JU0MgaXMgbm90IHNldAoK
IwojIFBvd2VyIG1hbmFnZW1lbnQgb3B0aW9ucwojCkNPTkZJR19QTT15CkNPTkZJR19QTV9ERUJV
Rz15CiMgQ09ORklHX1BNX1ZFUkJPU0UgaXMgbm90IHNldApDT05GSUdfQ0FOX1BNX1RSQUNFPXkK
Q09ORklHX1BNX1NMRUVQPXkKQ09ORklHX1NVU1BFTkQ9eQojIENPTkZJR19QTV9URVNUX1NVU1BF
TkQgaXMgbm90IHNldApDT05GSUdfU1VTUEVORF9GUkVFWkVSPXkKIyBDT05GSUdfQVBNX0VNVUxB
VElPTiBpcyBub3Qgc2V0CkNPTkZJR19BUkNIX1NVU1BFTkRfUE9TU0lCTEU9eQpDT05GSUdfTkVU
PXkKCiMKIyBOZXR3b3JraW5nIG9wdGlvbnMKIwpDT05GSUdfQ09NUEFUX05FVF9ERVZfT1BTPXkK
Q09ORklHX1BBQ0tFVD15CiMgQ09ORklHX1BBQ0tFVF9NTUFQIGlzIG5vdCBzZXQKQ09ORklHX1VO
SVg9eQpDT05GSUdfWEZSTT15CiMgQ09ORklHX1hGUk1fVVNFUiBpcyBub3Qgc2V0CiMgQ09ORklH
X1hGUk1fU1VCX1BPTElDWSBpcyBub3Qgc2V0CiMgQ09ORklHX1hGUk1fTUlHUkFURSBpcyBub3Qg
c2V0CiMgQ09ORklHX1hGUk1fU1RBVElTVElDUyBpcyBub3Qgc2V0CkNPTkZJR19ORVRfS0VZPXkK
IyBDT05GSUdfTkVUX0tFWV9NSUdSQVRFIGlzIG5vdCBzZXQKQ09ORklHX0lORVQ9eQojIENPTkZJ
R19JUF9NVUxUSUNBU1QgaXMgbm90IHNldAojIENPTkZJR19JUF9BRFZBTkNFRF9ST1VURVIgaXMg
bm90IHNldApDT05GSUdfSVBfRklCX0hBU0g9eQojIENPTkZJR19JUF9QTlAgaXMgbm90IHNldAoj
IENPTkZJR19ORVRfSVBJUCBpcyBub3Qgc2V0CiMgQ09ORklHX05FVF9JUEdSRSBpcyBub3Qgc2V0
CiMgQ09ORklHX0FSUEQgaXMgbm90IHNldAojIENPTkZJR19TWU5fQ09PS0lFUyBpcyBub3Qgc2V0
CiMgQ09ORklHX0lORVRfQUggaXMgbm90IHNldAojIENPTkZJR19JTkVUX0VTUCBpcyBub3Qgc2V0
CiMgQ09ORklHX0lORVRfSVBDT01QIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5FVF9YRlJNX1RVTk5F
TCBpcyBub3Qgc2V0CiMgQ09ORklHX0lORVRfVFVOTkVMIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5F
VF9YRlJNX01PREVfVFJBTlNQT1JUIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5FVF9YRlJNX01PREVf
VFVOTkVMIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5FVF9YRlJNX01PREVfQkVFVCBpcyBub3Qgc2V0
CiMgQ09ORklHX0lORVRfTFJPIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5FVF9ESUFHIGlzIG5vdCBz
ZXQKIyBDT05GSUdfVENQX0NPTkdfQURWQU5DRUQgaXMgbm90IHNldApDT05GSUdfVENQX0NPTkdf
Q1VCSUM9eQpDT05GSUdfREVGQVVMVF9UQ1BfQ09ORz0iY3ViaWMiCiMgQ09ORklHX1RDUF9NRDVT
SUcgaXMgbm90IHNldAojIENPTkZJR19JUFY2IGlzIG5vdCBzZXQKIyBDT05GSUdfTkVUV09SS19T
RUNNQVJLIGlzIG5vdCBzZXQKIyBDT05GSUdfTkVURklMVEVSIGlzIG5vdCBzZXQKIyBDT05GSUdf
SVBfRENDUCBpcyBub3Qgc2V0CiMgQ09ORklHX0lQX1NDVFAgaXMgbm90IHNldAojIENPTkZJR19U
SVBDIGlzIG5vdCBzZXQKIyBDT05GSUdfQVRNIGlzIG5vdCBzZXQKIyBDT05GSUdfQlJJREdFIGlz
IG5vdCBzZXQKIyBDT05GSUdfTkVUX0RTQSBpcyBub3Qgc2V0CiMgQ09ORklHX1ZMQU5fODAyMVEg
aXMgbm90IHNldAojIENPTkZJR19ERUNORVQgaXMgbm90IHNldAojIENPTkZJR19MTEMyIGlzIG5v
dCBzZXQKIyBDT05GSUdfSVBYIGlzIG5vdCBzZXQKIyBDT05GSUdfQVRBTEsgaXMgbm90IHNldAoj
IENPTkZJR19YMjUgaXMgbm90IHNldAojIENPTkZJR19MQVBCIGlzIG5vdCBzZXQKIyBDT05GSUdf
RUNPTkVUIGlzIG5vdCBzZXQKIyBDT05GSUdfV0FOX1JPVVRFUiBpcyBub3Qgc2V0CiMgQ09ORklH
X05FVF9TQ0hFRCBpcyBub3Qgc2V0CiMgQ09ORklHX0RDQiBpcyBub3Qgc2V0CgojCiMgTmV0d29y
ayB0ZXN0aW5nCiMKIyBDT05GSUdfTkVUX1BLVEdFTiBpcyBub3Qgc2V0CiMgQ09ORklHX0hBTVJB
RElPIGlzIG5vdCBzZXQKIyBDT05GSUdfQ0FOIGlzIG5vdCBzZXQKIyBDT05GSUdfSVJEQSBpcyBu
b3Qgc2V0CiMgQ09ORklHX0JUIGlzIG5vdCBzZXQKIyBDT05GSUdfQUZfUlhSUEMgaXMgbm90IHNl
dAojIENPTkZJR19QSE9ORVQgaXMgbm90IHNldAojIENPTkZJR19XSVJFTEVTUyBpcyBub3Qgc2V0
CiMgQ09ORklHX1dJTUFYIGlzIG5vdCBzZXQKIyBDT05GSUdfUkZLSUxMIGlzIG5vdCBzZXQKIyBD
T05GSUdfTkVUXzlQIGlzIG5vdCBzZXQKCiMKIyBEZXZpY2UgRHJpdmVycwojCgojCiMgR2VuZXJp
YyBEcml2ZXIgT3B0aW9ucwojCkNPTkZJR19VRVZFTlRfSEVMUEVSX1BBVEg9Ii9zYmluL2hvdHBs
dWciCkNPTkZJR19TVEFOREFMT05FPXkKQ09ORklHX1BSRVZFTlRfRklSTVdBUkVfQlVJTEQ9eQoj
IENPTkZJR19GV19MT0FERVIgaXMgbm90IHNldAojIENPTkZJR19ERUJVR19EUklWRVIgaXMgbm90
IHNldAojIENPTkZJR19ERUJVR19ERVZSRVMgaXMgbm90IHNldAojIENPTkZJR19TWVNfSFlQRVJW
SVNPUiBpcyBub3Qgc2V0CiMgQ09ORklHX0NPTk5FQ1RPUiBpcyBub3Qgc2V0CkNPTkZJR19NVEQ9
eQojIENPTkZJR19NVERfREVCVUcgaXMgbm90IHNldAojIENPTkZJR19NVERfQ09OQ0FUIGlzIG5v
dCBzZXQKQ09ORklHX01URF9QQVJUSVRJT05TPXkKIyBDT05GSUdfTVREX1RFU1RTIGlzIG5vdCBz
ZXQKIyBDT05GSUdfTVREX1JFREJPT1RfUEFSVFMgaXMgbm90IHNldAojIENPTkZJR19NVERfQ01E
TElORV9QQVJUUyBpcyBub3Qgc2V0CiMgQ09ORklHX01URF9BRlNfUEFSVFMgaXMgbm90IHNldAoj
IENPTkZJR19NVERfQVI3X1BBUlRTIGlzIG5vdCBzZXQKCiMKIyBVc2VyIE1vZHVsZXMgQW5kIFRy
YW5zbGF0aW9uIExheWVycwojCkNPTkZJR19NVERfQ0hBUj15CkNPTkZJR19NVERfQkxLREVWUz15
CkNPTkZJR19NVERfQkxPQ0s9eQojIENPTkZJR19GVEwgaXMgbm90IHNldAojIENPTkZJR19ORlRM
IGlzIG5vdCBzZXQKIyBDT05GSUdfSU5GVEwgaXMgbm90IHNldAojIENPTkZJR19SRkRfRlRMIGlz
IG5vdCBzZXQKIyBDT05GSUdfU1NGREMgaXMgbm90IHNldAojIENPTkZJR19NVERfT09QUyBpcyBu
b3Qgc2V0CgojCiMgUkFNL1JPTS9GbGFzaCBjaGlwIGRyaXZlcnMKIwojIENPTkZJR19NVERfQ0ZJ
IGlzIG5vdCBzZXQKIyBDT05GSUdfTVREX0pFREVDUFJPQkUgaXMgbm90IHNldApDT05GSUdfTVRE
X01BUF9CQU5LX1dJRFRIXzE9eQpDT05GSUdfTVREX01BUF9CQU5LX1dJRFRIXzI9eQpDT05GSUdf
TVREX01BUF9CQU5LX1dJRFRIXzQ9eQojIENPTkZJR19NVERfTUFQX0JBTktfV0lEVEhfOCBpcyBu
b3Qgc2V0CiMgQ09ORklHX01URF9NQVBfQkFOS19XSURUSF8xNiBpcyBub3Qgc2V0CiMgQ09ORklH
X01URF9NQVBfQkFOS19XSURUSF8zMiBpcyBub3Qgc2V0CkNPTkZJR19NVERfQ0ZJX0kxPXkKQ09O
RklHX01URF9DRklfSTI9eQojIENPTkZJR19NVERfQ0ZJX0k0IGlzIG5vdCBzZXQKIyBDT05GSUdf
TVREX0NGSV9JOCBpcyBub3Qgc2V0CiMgQ09ORklHX01URF9SQU0gaXMgbm90IHNldAojIENPTkZJ
R19NVERfUk9NIGlzIG5vdCBzZXQKIyBDT05GSUdfTVREX0FCU0VOVCBpcyBub3Qgc2V0CgojCiMg
TWFwcGluZyBkcml2ZXJzIGZvciBjaGlwIGFjY2VzcwojCiMgQ09ORklHX01URF9DT01QTEVYX01B
UFBJTkdTIGlzIG5vdCBzZXQKIyBDT05GSUdfTVREX1BMQVRSQU0gaXMgbm90IHNldAoKIwojIFNl
bGYtY29udGFpbmVkIE1URCBkZXZpY2UgZHJpdmVycwojCiMgQ09ORklHX01URF9TTFJBTSBpcyBu
b3Qgc2V0CiMgQ09ORklHX01URF9QSFJBTSBpcyBub3Qgc2V0CiMgQ09ORklHX01URF9NVERSQU0g
aXMgbm90IHNldAojIENPTkZJR19NVERfQkxPQ0syTVREIGlzIG5vdCBzZXQKCiMKIyBEaXNrLU9u
LUNoaXAgRGV2aWNlIERyaXZlcnMKIwojIENPTkZJR19NVERfRE9DMjAwMCBpcyBub3Qgc2V0CiMg
Q09ORklHX01URF9ET0MyMDAxIGlzIG5vdCBzZXQKIyBDT05GSUdfTVREX0RPQzIwMDFQTFVTIGlz
IG5vdCBzZXQKQ09ORklHX01URF9OQU5EPXkKIyBDT05GSUdfTVREX05BTkRfVkVSSUZZX1dSSVRF
IGlzIG5vdCBzZXQKIyBDT05GSUdfTVREX05BTkRfRUNDX1NNQyBpcyBub3Qgc2V0CiMgQ09ORklH
X01URF9OQU5EX01VU0VVTV9JRFMgaXMgbm90IHNldAojIENPTkZJR19NVERfTkFORF9HUElPIGlz
IG5vdCBzZXQKQ09ORklHX01URF9OQU5EX09NQVAyPXkKQ09ORklHX01URF9OQU5EX0lEUz15CiMg
Q09ORklHX01URF9OQU5EX0RJU0tPTkNISVAgaXMgbm90IHNldAojIENPTkZJR19NVERfTkFORF9O
QU5EU0lNIGlzIG5vdCBzZXQKIyBDT05GSUdfTVREX05BTkRfUExBVEZPUk0gaXMgbm90IHNldAoj
IENPTkZJR19NVERfQUxBVURBIGlzIG5vdCBzZXQKIyBDT05GSUdfTVREX09ORU5BTkQgaXMgbm90
IHNldAoKIwojIExQRERSIGZsYXNoIG1lbW9yeSBkcml2ZXJzCiMKIyBDT05GSUdfTVREX0xQRERS
IGlzIG5vdCBzZXQKCiMKIyBVQkkgLSBVbnNvcnRlZCBibG9jayBpbWFnZXMKIwojIENPTkZJR19N
VERfVUJJIGlzIG5vdCBzZXQKIyBDT05GSUdfUEFSUE9SVCBpcyBub3Qgc2V0CkNPTkZJR19CTEtf
REVWPXkKIyBDT05GSUdfQkxLX0RFVl9DT1dfQ09NTU9OIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxL
X0RFVl9MT09QIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9OQkQgaXMgbm90IHNldAojIENP
TkZJR19CTEtfREVWX1VCIGlzIG5vdCBzZXQKIyBDT05GSUdfQkxLX0RFVl9SQU0gaXMgbm90IHNl
dAojIENPTkZJR19DRFJPTV9QS1RDRFZEIGlzIG5vdCBzZXQKIyBDT05GSUdfQVRBX09WRVJfRVRI
IGlzIG5vdCBzZXQKIyBDT05GSUdfTUlTQ19ERVZJQ0VTIGlzIG5vdCBzZXQKQ09ORklHX0hBVkVf
SURFPXkKIyBDT05GSUdfSURFIGlzIG5vdCBzZXQKCiMKIyBTQ1NJIGRldmljZSBzdXBwb3J0CiMK
IyBDT05GSUdfUkFJRF9BVFRSUyBpcyBub3Qgc2V0CkNPTkZJR19TQ1NJPXkKQ09ORklHX1NDU0lf
RE1BPXkKIyBDT05GSUdfU0NTSV9UR1QgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX05FVExJTksg
aXMgbm90IHNldApDT05GSUdfU0NTSV9QUk9DX0ZTPXkKCiMKIyBTQ1NJIHN1cHBvcnQgdHlwZSAo
ZGlzaywgdGFwZSwgQ0QtUk9NKQojCkNPTkZJR19CTEtfREVWX1NEPXkKIyBDT05GSUdfQ0hSX0RF
Vl9TVCBpcyBub3Qgc2V0CiMgQ09ORklHX0NIUl9ERVZfT1NTVCBpcyBub3Qgc2V0CiMgQ09ORklH
X0JMS19ERVZfU1IgaXMgbm90IHNldAojIENPTkZJR19DSFJfREVWX1NHIGlzIG5vdCBzZXQKIyBD
T05GSUdfQ0hSX0RFVl9TQ0ggaXMgbm90IHNldAoKIwojIFNvbWUgU0NTSSBkZXZpY2VzIChlLmcu
IENEIGp1a2Vib3gpIHN1cHBvcnQgbXVsdGlwbGUgTFVOcwojCiMgQ09ORklHX1NDU0lfTVVMVElf
TFVOIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9DT05TVEFOVFMgaXMgbm90IHNldAojIENPTkZJ
R19TQ1NJX0xPR0dJTkcgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX1NDQU5fQVNZTkMgaXMgbm90
IHNldApDT05GSUdfU0NTSV9XQUlUX1NDQU49bQoKIwojIFNDU0kgVHJhbnNwb3J0cwojCiMgQ09O
RklHX1NDU0lfU1BJX0FUVFJTIGlzIG5vdCBzZXQKIyBDT05GSUdfU0NTSV9GQ19BVFRSUyBpcyBu
b3Qgc2V0CiMgQ09ORklHX1NDU0lfSVNDU0lfQVRUUlMgaXMgbm90IHNldAojIENPTkZJR19TQ1NJ
X1NBU19MSUJTQVMgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX1NSUF9BVFRSUyBpcyBub3Qgc2V0
CiMgQ09ORklHX1NDU0lfTE9XTEVWRUwgaXMgbm90IHNldAojIENPTkZJR19TQ1NJX0RIIGlzIG5v
dCBzZXQKIyBDT05GSUdfQVRBIGlzIG5vdCBzZXQKIyBDT05GSUdfTUQgaXMgbm90IHNldAojIENP
TkZJR19ORVRERVZJQ0VTIGlzIG5vdCBzZXQKIyBDT05GSUdfSVNETiBpcyBub3Qgc2V0CgojCiMg
SW5wdXQgZGV2aWNlIHN1cHBvcnQKIwpDT05GSUdfSU5QVVQ9eQojIENPTkZJR19JTlBVVF9GRl9N
RU1MRVNTIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5QVVRfUE9MTERFViBpcyBub3Qgc2V0CgojCiMg
VXNlcmxhbmQgaW50ZXJmYWNlcwojCiMgQ09ORklHX0lOUFVUX01PVVNFREVWIGlzIG5vdCBzZXQK
IyBDT05GSUdfSU5QVVRfSk9ZREVWIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5QVVRfRVZERVYgaXMg
bm90IHNldAojIENPTkZJR19JTlBVVF9FVkJVRyBpcyBub3Qgc2V0CgojCiMgSW5wdXQgRGV2aWNl
IERyaXZlcnMKIwojIENPTkZJR19JTlBVVF9LRVlCT0FSRCBpcyBub3Qgc2V0CiMgQ09ORklHX0lO
UFVUX01PVVNFIGlzIG5vdCBzZXQKIyBDT05GSUdfSU5QVVRfSk9ZU1RJQ0sgaXMgbm90IHNldAoj
IENPTkZJR19JTlBVVF9UQUJMRVQgaXMgbm90IHNldAojIENPTkZJR19JTlBVVF9UT1VDSFNDUkVF
TiBpcyBub3Qgc2V0CiMgQ09ORklHX0lOUFVUX01JU0MgaXMgbm90IHNldAoKIwojIEhhcmR3YXJl
IEkvTyBwb3J0cwojCiMgQ09ORklHX1NFUklPIGlzIG5vdCBzZXQKIyBDT05GSUdfR0FNRVBPUlQg
aXMgbm90IHNldAoKIwojIENoYXJhY3RlciBkZXZpY2VzCiMKQ09ORklHX1ZUPXkKQ09ORklHX0NP
TlNPTEVfVFJBTlNMQVRJT05TPXkKQ09ORklHX1ZUX0NPTlNPTEU9eQpDT05GSUdfSFdfQ09OU09M
RT15CiMgQ09ORklHX1ZUX0hXX0NPTlNPTEVfQklORElORyBpcyBub3Qgc2V0CkNPTkZJR19ERVZL
TUVNPXkKIyBDT05GSUdfU0VSSUFMX05PTlNUQU5EQVJEIGlzIG5vdCBzZXQKCiMKIyBTZXJpYWwg
ZHJpdmVycwojCkNPTkZJR19TRVJJQUxfODI1MD15CkNPTkZJR19TRVJJQUxfODI1MF9DT05TT0xF
PXkKQ09ORklHX1NFUklBTF84MjUwX05SX1VBUlRTPTMyCkNPTkZJR19TRVJJQUxfODI1MF9SVU5U
SU1FX1VBUlRTPTQKQ09ORklHX1NFUklBTF84MjUwX0VYVEVOREVEPXkKQ09ORklHX1NFUklBTF84
MjUwX01BTllfUE9SVFM9eQpDT05GSUdfU0VSSUFMXzgyNTBfU0hBUkVfSVJRPXkKQ09ORklHX1NF
UklBTF84MjUwX0RFVEVDVF9JUlE9eQpDT05GSUdfU0VSSUFMXzgyNTBfUlNBPXkKCiMKIyBOb24t
ODI1MCBzZXJpYWwgcG9ydCBzdXBwb3J0CiMKQ09ORklHX1NFUklBTF9DT1JFPXkKQ09ORklHX1NF
UklBTF9DT1JFX0NPTlNPTEU9eQpDT05GSUdfVU5JWDk4X1BUWVM9eQojIENPTkZJR19ERVZQVFNf
TVVMVElQTEVfSU5TVEFOQ0VTIGlzIG5vdCBzZXQKIyBDT05GSUdfTEVHQUNZX1BUWVMgaXMgbm90
IHNldAojIENPTkZJR19JUE1JX0hBTkRMRVIgaXMgbm90IHNldApDT05GSUdfSFdfUkFORE9NPXkK
IyBDT05GSUdfUjM5NjQgaXMgbm90IHNldAojIENPTkZJR19SQVdfRFJJVkVSIGlzIG5vdCBzZXQK
IyBDT05GSUdfVENHX1RQTSBpcyBub3Qgc2V0CkNPTkZJR19JMkM9eQpDT05GSUdfSTJDX0JPQVJE
SU5GTz15CkNPTkZJR19JMkNfQ0hBUkRFVj15CkNPTkZJR19JMkNfSEVMUEVSX0FVVE89eQoKIwoj
IEkyQyBIYXJkd2FyZSBCdXMgc3VwcG9ydAojCgojCiMgSTJDIHN5c3RlbSBidXMgZHJpdmVycyAo
bW9zdGx5IGVtYmVkZGVkIC8gc3lzdGVtLW9uLWNoaXApCiMKIyBDT05GSUdfSTJDX0dQSU8gaXMg
bm90IHNldAojIENPTkZJR19JMkNfT0NPUkVTIGlzIG5vdCBzZXQKQ09ORklHX0kyQ19PTUFQPXkK
IyBDT05GSUdfSTJDX1NJTVRFQyBpcyBub3Qgc2V0CgojCiMgRXh0ZXJuYWwgSTJDL1NNQnVzIGFk
YXB0ZXIgZHJpdmVycwojCiMgQ09ORklHX0kyQ19QQVJQT1JUX0xJR0hUIGlzIG5vdCBzZXQKIyBD
T05GSUdfSTJDX1RBT1NfRVZNIGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX1RJTllfVVNCIGlzIG5v
dCBzZXQKCiMKIyBPdGhlciBJMkMvU01CdXMgYnVzIGRyaXZlcnMKIwojIENPTkZJR19JMkNfUENB
X1BMQVRGT1JNIGlzIG5vdCBzZXQKIyBDT05GSUdfSTJDX1NUVUIgaXMgbm90IHNldAoKIwojIE1p
c2NlbGxhbmVvdXMgSTJDIENoaXAgc3VwcG9ydAojCiMgQ09ORklHX0RTMTY4MiBpcyBub3Qgc2V0
CiMgQ09ORklHX1NFTlNPUlNfUENGODU3NCBpcyBub3Qgc2V0CiMgQ09ORklHX1BDRjg1NzUgaXMg
bm90IHNldAojIENPTkZJR19TRU5TT1JTX1BDQTk1MzkgaXMgbm90IHNldAojIENPTkZJR19TRU5T
T1JTX1BDRjg1OTEgaXMgbm90IHNldAojIENPTkZJR19UV0w0MDMwX01BREMgaXMgbm90IHNldAoj
IENPTkZJR19UV0w0MDMwX1BPV0VST0ZGIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19NQVg2
ODc1IGlzIG5vdCBzZXQKIyBDT05GSUdfU0VOU09SU19UU0wyNTUwIGlzIG5vdCBzZXQKIyBDT05G
SUdfSTJDX0RFQlVHX0NPUkUgaXMgbm90IHNldAojIENPTkZJR19JMkNfREVCVUdfQUxHTyBpcyBu
b3Qgc2V0CiMgQ09ORklHX0kyQ19ERUJVR19CVVMgaXMgbm90IHNldAojIENPTkZJR19JMkNfREVC
VUdfQ0hJUCBpcyBub3Qgc2V0CiMgQ09ORklHX1NQSSBpcyBub3Qgc2V0CkNPTkZJR19BUkNIX1JF
UVVJUkVfR1BJT0xJQj15CkNPTkZJR19HUElPTElCPXkKIyBDT05GSUdfREVCVUdfR1BJTyBpcyBu
b3Qgc2V0CiMgQ09ORklHX0dQSU9fU1lTRlMgaXMgbm90IHNldAoKIwojIE1lbW9yeSBtYXBwZWQg
R1BJTyBleHBhbmRlcnM6CiMKCiMKIyBJMkMgR1BJTyBleHBhbmRlcnM6CiMKIyBDT05GSUdfR1BJ
T19NQVg3MzJYIGlzIG5vdCBzZXQKIyBDT05GSUdfR1BJT19QQ0E5NTNYIGlzIG5vdCBzZXQKIyBD
T05GSUdfR1BJT19QQ0Y4NTdYIGlzIG5vdCBzZXQKQ09ORklHX0dQSU9fVFdMNDAzMD15CgojCiMg
UENJIEdQSU8gZXhwYW5kZXJzOgojCgojCiMgU1BJIEdQSU8gZXhwYW5kZXJzOgojCiMgQ09ORklH
X1cxIGlzIG5vdCBzZXQKIyBDT05GSUdfUE9XRVJfU1VQUExZIGlzIG5vdCBzZXQKIyBDT05GSUdf
SFdNT04gaXMgbm90IHNldAojIENPTkZJR19USEVSTUFMIGlzIG5vdCBzZXQKIyBDT05GSUdfVEhF
Uk1BTF9IV01PTiBpcyBub3Qgc2V0CiMgQ09ORklHX1dBVENIRE9HIGlzIG5vdCBzZXQKQ09ORklH
X1NTQl9QT1NTSUJMRT15CgojCiMgU29uaWNzIFNpbGljb24gQmFja3BsYW5lCiMKIyBDT05GSUdf
U1NCIGlzIG5vdCBzZXQKCiMKIyBNdWx0aWZ1bmN0aW9uIGRldmljZSBkcml2ZXJzCiMKIyBDT05G
SUdfTUZEX0NPUkUgaXMgbm90IHNldAojIENPTkZJR19NRkRfU001MDEgaXMgbm90IHNldAojIENP
TkZJR19NRkRfQVNJQzMgaXMgbm90IHNldAojIENPTkZJR19IVENfRUdQSU8gaXMgbm90IHNldAoj
IENPTkZJR19IVENfUEFTSUMzIGlzIG5vdCBzZXQKIyBDT05GSUdfVFBTNjUwMTAgaXMgbm90IHNl
dApDT05GSUdfVFdMNDAzMF9DT1JFPXkKIyBDT05GSUdfVFdMNDAzMF9QT1dFUiBpcyBub3Qgc2V0
CiMgQ09ORklHX01GRF9UTUlPIGlzIG5vdCBzZXQKIyBDT05GSUdfTUZEX1Q3TDY2WEIgaXMgbm90
IHNldAojIENPTkZJR19NRkRfVEM2Mzg3WEIgaXMgbm90IHNldAojIENPTkZJR19NRkRfVEM2Mzkz
WEIgaXMgbm90IHNldAojIENPTkZJR19QTUlDX0RBOTAzWCBpcyBub3Qgc2V0CiMgQ09ORklHX01G
RF9XTTg0MDAgaXMgbm90IHNldAojIENPTkZJR19NRkRfV004MzUwX0kyQyBpcyBub3Qgc2V0CiMg
Q09ORklHX01GRF9QQ0Y1MDYzMyBpcyBub3Qgc2V0CgojCiMgTXVsdGltZWRpYSBkZXZpY2VzCiMK
CiMKIyBNdWx0aW1lZGlhIGNvcmUgc3VwcG9ydAojCiMgQ09ORklHX1ZJREVPX0RFViBpcyBub3Qg
c2V0CiMgQ09ORklHX0RWQl9DT1JFIGlzIG5vdCBzZXQKIyBDT05GSUdfVklERU9fTUVESUEgaXMg
bm90IHNldAoKIwojIE11bHRpbWVkaWEgZHJpdmVycwojCkNPTkZJR19EQUI9eQojIENPTkZJR19V
U0JfREFCVVNCIGlzIG5vdCBzZXQKCiMKIyBHcmFwaGljcyBzdXBwb3J0CiMKIyBDT05GSUdfVkdB
U1RBVEUgaXMgbm90IHNldAojIENPTkZJR19WSURFT19PVVRQVVRfQ09OVFJPTCBpcyBub3Qgc2V0
CkNPTkZJR19GQj15CiMgQ09ORklHX0ZJUk1XQVJFX0VESUQgaXMgbm90IHNldAojIENPTkZJR19G
Ql9EREMgaXMgbm90IHNldAojIENPTkZJR19GQl9CT09UX1ZFU0FfU1VQUE9SVCBpcyBub3Qgc2V0
CkNPTkZJR19GQl9DRkJfRklMTFJFQ1Q9eQpDT05GSUdfRkJfQ0ZCX0NPUFlBUkVBPXkKQ09ORklH
X0ZCX0NGQl9JTUFHRUJMSVQ9eQojIENPTkZJR19GQl9DRkJfUkVWX1BJWEVMU19JTl9CWVRFIGlz
IG5vdCBzZXQKIyBDT05GSUdfRkJfU1lTX0ZJTExSRUNUIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJf
U1lTX0NPUFlBUkVBIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfU1lTX0lNQUdFQkxJVCBpcyBub3Qg
c2V0CiMgQ09ORklHX0ZCX0ZPUkVJR05fRU5ESUFOIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfU1lT
X0ZPUFMgaXMgbm90IHNldAojIENPTkZJR19GQl9TVkdBTElCIGlzIG5vdCBzZXQKIyBDT05GSUdf
RkJfTUFDTU9ERVMgaXMgbm90IHNldAojIENPTkZJR19GQl9CQUNLTElHSFQgaXMgbm90IHNldAoj
IENPTkZJR19GQl9NT0RFX0hFTFBFUlMgaXMgbm90IHNldAojIENPTkZJR19GQl9USUxFQkxJVFRJ
TkcgaXMgbm90IHNldAoKIwojIEZyYW1lIGJ1ZmZlciBoYXJkd2FyZSBkcml2ZXJzCiMKIyBDT05G
SUdfRkJfUzFEMTNYWFggaXMgbm90IHNldAojIENPTkZJR19GQl9WSVJUVUFMIGlzIG5vdCBzZXQK
IyBDT05GSUdfRkJfTUVUUk9OT01FIGlzIG5vdCBzZXQKIyBDT05GSUdfRkJfTUI4NjJYWCBpcyBu
b3Qgc2V0CkNPTkZJR19GQl9PTUFQPXkKIyBDT05GSUdfRkJfT01BUF9MQ0RDX0VYVEVSTkFMIGlz
IG5vdCBzZXQKQ09ORklHX0ZCX09NQVBfQk9PVExPQURFUl9JTklUPXkKQ09ORklHX0ZCX09NQVBf
Q09OU0lTVEVOVF9ETUFfU0laRT0yCiMgQ09ORklHX0JBQ0tMSUdIVF9MQ0RfU1VQUE9SVCBpcyBu
b3Qgc2V0CgojCiMgRGlzcGxheSBkZXZpY2Ugc3VwcG9ydAojCiMgQ09ORklHX0RJU1BMQVlfU1VQ
UE9SVCBpcyBub3Qgc2V0CgojCiMgQ29uc29sZSBkaXNwbGF5IGRyaXZlciBzdXBwb3J0CiMKIyBD
T05GSUdfVkdBX0NPTlNPTEUgaXMgbm90IHNldApDT05GSUdfRFVNTVlfQ09OU09MRT15CkNPTkZJ
R19GUkFNRUJVRkZFUl9DT05TT0xFPXkKIyBDT05GSUdfRlJBTUVCVUZGRVJfQ09OU09MRV9ERVRF
Q1RfUFJJTUFSWSBpcyBub3Qgc2V0CiMgQ09ORklHX0ZSQU1FQlVGRkVSX0NPTlNPTEVfUk9UQVRJ
T04gaXMgbm90IHNldAojIENPTkZJR19GT05UUyBpcyBub3Qgc2V0CkNPTkZJR19GT05UXzh4OD15
CkNPTkZJR19GT05UXzh4MTY9eQojIENPTkZJR19MT0dPIGlzIG5vdCBzZXQKIyBDT05GSUdfU09V
TkQgaXMgbm90IHNldAojIENPTkZJR19ISURfU1VQUE9SVCBpcyBub3Qgc2V0CkNPTkZJR19VU0Jf
U1VQUE9SVD15CkNPTkZJR19VU0JfQVJDSF9IQVNfSENEPXkKQ09ORklHX1VTQl9BUkNIX0hBU19P
SENJPXkKQ09ORklHX1VTQl9BUkNIX0hBU19FSENJPXkKQ09ORklHX1VTQj1tCiMgQ09ORklHX1VT
Ql9ERUJVRyBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9BTk5PVU5DRV9ORVdfREVWSUNFUyBpcyBu
b3Qgc2V0CgojCiMgTWlzY2VsbGFuZW91cyBVU0Igb3B0aW9ucwojCkNPTkZJR19VU0JfREVWSUNF
RlM9eQojIENPTkZJR19VU0JfREVWSUNFX0NMQVNTIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0RZ
TkFNSUNfTUlOT1JTIGlzIG5vdCBzZXQKQ09ORklHX1VTQl9TVVNQRU5EPXkKQ09ORklHX1VTQl9P
VEc9eQojIENPTkZJR19VU0JfT1RHX1dISVRFTElTVCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9P
VEdfQkxBQ0tMSVNUX0hVQiBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9NT04gaXMgbm90IHNldAoj
IENPTkZJR19VU0JfV1VTQiBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9XVVNCX0NCQUYgaXMgbm90
IHNldAoKIwojIFVTQiBIb3N0IENvbnRyb2xsZXIgRHJpdmVycwojCiMgQ09ORklHX1VTQl9DNjdY
MDBfSENEIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0VIQ0lfSENEIGlzIG5vdCBzZXQKIyBDT05G
SUdfVVNCX09YVTIxMEhQX0hDRCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9JU1AxMTZYX0hDRCBp
cyBub3Qgc2V0CiMgQ09ORklHX1VTQl9PSENJX0hDRCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9T
TDgxMV9IQ0QgaXMgbm90IHNldAojIENPTkZJR19VU0JfUjhBNjY1OTdfSENEIGlzIG5vdCBzZXQK
IyBDT05GSUdfVVNCX0hXQV9IQ0QgaXMgbm90IHNldApDT05GSUdfVVNCX01VU0JfSERSQz1tCkNP
TkZJR19VU0JfTVVTQl9TT0M9eQoKIwojIE9NQVAgMzQzeCBoaWdoIHNwZWVkIFVTQiBzdXBwb3J0
CiMKIyBDT05GSUdfVVNCX01VU0JfSE9TVCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9NVVNCX1BF
UklQSEVSQUwgaXMgbm90IHNldApDT05GSUdfVVNCX01VU0JfT1RHPXkKQ09ORklHX1VTQl9HQURH
RVRfTVVTQl9IRFJDPXkKQ09ORklHX1VTQl9NVVNCX0hEUkNfSENEPXkKIyBDT05GSUdfTVVTQl9Q
SU9fT05MWSBpcyBub3Qgc2V0CkNPTkZJR19VU0JfSU5WRU5UUkFfRE1BPXkKIyBDT05GSUdfVVNC
X1RJX0NQUElfRE1BIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX01VU0JfREVCVUcgaXMgbm90IHNl
dAoKIwojIFVTQiBEZXZpY2UgQ2xhc3MgZHJpdmVycwojCiMgQ09ORklHX1VTQl9BQ00gaXMgbm90
IHNldAojIENPTkZJR19VU0JfUFJJTlRFUiBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9XRE0gaXMg
bm90IHNldAojIENPTkZJR19VU0JfVE1DIGlzIG5vdCBzZXQKCiMKIyBOT1RFOiBVU0JfU1RPUkFH
RSBkZXBlbmRzIG9uIFNDU0kgYnV0IEJMS19ERVZfU0QgbWF5IGFsc28gYmUgbmVlZGVkOwojCgoj
CiMgc2VlIFVTQl9TVE9SQUdFIEhlbHAgZm9yIG1vcmUgaW5mb3JtYXRpb24KIwojIENPTkZJR19V
U0JfU1RPUkFHRSBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9MSUJVU1VBTCBpcyBub3Qgc2V0Cgoj
CiMgVVNCIEltYWdpbmcgZGV2aWNlcwojCiMgQ09ORklHX1VTQl9NREM4MDAgaXMgbm90IHNldAoj
IENPTkZJR19VU0JfTUlDUk9URUsgaXMgbm90IHNldAoKIwojIFVTQiBwb3J0IGRyaXZlcnMKIwoj
IENPTkZJR19VU0JfU0VSSUFMIGlzIG5vdCBzZXQKCiMKIyBVU0IgTWlzY2VsbGFuZW91cyBkcml2
ZXJzCiMKIyBDT05GSUdfVVNCX0VNSTYyIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0VNSTI2IGlz
IG5vdCBzZXQKIyBDT05GSUdfVVNCX0FEVVRVWCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TRVZT
RUcgaXMgbm90IHNldAojIENPTkZJR19VU0JfUklPNTAwIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNC
X0xFR09UT1dFUiBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9MQ0QgaXMgbm90IHNldAojIENPTkZJ
R19VU0JfQkVSUllfQ0hBUkdFIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0xFRCBpcyBub3Qgc2V0
CiMgQ09ORklHX1VTQl9DWVBSRVNTX0NZN0M2MyBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9DWVRI
RVJNIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1BISURHRVQgaXMgbm90IHNldAojIENPTkZJR19V
U0JfSURNT1VTRSBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9GVERJX0VMQU4gaXMgbm90IHNldAoj
IENPTkZJR19VU0JfQVBQTEVESVNQTEFZIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0xEIGlzIG5v
dCBzZXQKIyBDT05GSUdfVVNCX1RSQU5DRVZJQlJBVE9SIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNC
X0lPV0FSUklPUiBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9URVNUIGlzIG5vdCBzZXQKIyBDT05G
SUdfVVNCX0lTSUdIVEZXIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX1ZTVCBpcyBub3Qgc2V0CkNP
TkZJR19VU0JfR0FER0VUPXkKIyBDT05GSUdfVVNCX0dBREdFVF9ERUJVRyBpcyBub3Qgc2V0CiMg
Q09ORklHX1VTQl9HQURHRVRfREVCVUdfRklMRVMgaXMgbm90IHNldAojIENPTkZJR19VU0JfR0FE
R0VUX0RFQlVHX0ZTIGlzIG5vdCBzZXQKQ09ORklHX1VTQl9HQURHRVRfVkJVU19EUkFXPTIKQ09O
RklHX1VTQl9HQURHRVRfU0VMRUNURUQ9eQojIENPTkZJR19VU0JfR0FER0VUX0FUOTEgaXMgbm90
IHNldAojIENPTkZJR19VU0JfR0FER0VUX0FUTUVMX1VTQkEgaXMgbm90IHNldAojIENPTkZJR19V
U0JfR0FER0VUX0ZTTF9VU0IyIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0dBREdFVF9MSDdBNDBY
IGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0dBREdFVF9PTUFQIGlzIG5vdCBzZXQKIyBDT05GSUdf
VVNCX0dBREdFVF9QWEEyNVggaXMgbm90IHNldAojIENPTkZJR19VU0JfR0FER0VUX1BYQTI3WCBp
cyBub3Qgc2V0CiMgQ09ORklHX1VTQl9HQURHRVRfUzNDMjQxMCBpcyBub3Qgc2V0CiMgQ09ORklH
X1VTQl9HQURHRVRfSU1YIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0dBREdFVF9NNjY1OTIgaXMg
bm90IHNldAojIENPTkZJR19VU0JfR0FER0VUX0FNRDU1MzZVREMgaXMgbm90IHNldAojIENPTkZJ
R19VU0JfR0FER0VUX0ZTTF9RRSBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9HQURHRVRfQ0kxM1hY
WCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9HQURHRVRfTkVUMjI4MCBpcyBub3Qgc2V0CiMgQ09O
RklHX1VTQl9HQURHRVRfR09LVSBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9HQURHRVRfRFVNTVlf
SENEIGlzIG5vdCBzZXQKQ09ORklHX1VTQl9HQURHRVRfRFVBTFNQRUVEPXkKIyBDT05GSUdfVVNC
X1pFUk8gaXMgbm90IHNldApDT05GSUdfVVNCX0VUSD1tCkNPTkZJR19VU0JfRVRIX1JORElTPXkK
IyBDT05GSUdfVVNCX0dBREdFVEZTIGlzIG5vdCBzZXQKIyBDT05GSUdfVVNCX0ZJTEVfU1RPUkFH
RSBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9HX1NFUklBTCBpcyBub3Qgc2V0CiMgQ09ORklHX1VT
Ql9NSURJX0dBREdFVCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9HX1BSSU5URVIgaXMgbm90IHNl
dAojIENPTkZJR19VU0JfQ0RDX0NPTVBPU0lURSBpcyBub3Qgc2V0CgojCiMgT1RHIGFuZCByZWxh
dGVkIGluZnJhc3RydWN0dXJlCiMKQ09ORklHX1VTQl9PVEdfVVRJTFM9eQojIENPTkZJR19VU0Jf
R1BJT19WQlVTIGlzIG5vdCBzZXQKIyBDT05GSUdfSVNQMTMwMV9PTUFQIGlzIG5vdCBzZXQKQ09O
RklHX1RXTDQwMzBfVVNCPXkKQ09ORklHX01NQz15CiMgQ09ORklHX01NQ19ERUJVRyBpcyBub3Qg
c2V0CiMgQ09ORklHX01NQ19VTlNBRkVfUkVTVU1FIGlzIG5vdCBzZXQKCiMKIyBNTUMvU0QvU0RJ
TyBDYXJkIERyaXZlcnMKIwpDT05GSUdfTU1DX0JMT0NLPXkKIyBDT05GSUdfTU1DX0JMT0NLX0JP
VU5DRSBpcyBub3Qgc2V0CiMgQ09ORklHX1NESU9fVUFSVCBpcyBub3Qgc2V0CiMgQ09ORklHX01N
Q19URVNUIGlzIG5vdCBzZXQKCiMKIyBNTUMvU0QvU0RJTyBIb3N0IENvbnRyb2xsZXIgRHJpdmVy
cwojCiMgQ09ORklHX01NQ19TREhDSSBpcyBub3Qgc2V0CkNPTkZJR19NTUNfT01BUF9IUz15CiMg
Q09ORklHX01FTVNUSUNLIGlzIG5vdCBzZXQKIyBDT05GSUdfQUNDRVNTSUJJTElUWSBpcyBub3Qg
c2V0CiMgQ09ORklHX05FV19MRURTIGlzIG5vdCBzZXQKQ09ORklHX1JUQ19MSUI9eQpDT05GSUdf
UlRDX0NMQVNTPXkKQ09ORklHX1JUQ19IQ1RPU1lTPXkKQ09ORklHX1JUQ19IQ1RPU1lTX0RFVklD
RT0icnRjMCIKIyBDT05GSUdfUlRDX0RFQlVHIGlzIG5vdCBzZXQKCiMKIyBSVEMgaW50ZXJmYWNl
cwojCkNPTkZJR19SVENfSU5URl9TWVNGUz15CkNPTkZJR19SVENfSU5URl9QUk9DPXkKQ09ORklH
X1JUQ19JTlRGX0RFVj15CiMgQ09ORklHX1JUQ19JTlRGX0RFVl9VSUVfRU1VTCBpcyBub3Qgc2V0
CiMgQ09ORklHX1JUQ19EUlZfVEVTVCBpcyBub3Qgc2V0CgojCiMgSTJDIFJUQyBkcml2ZXJzCiMK
IyBDT05GSUdfUlRDX0RSVl9EUzEzMDcgaXMgbm90IHNldAojIENPTkZJR19SVENfRFJWX0RTMTM3
NCBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfRFMxNjcyIGlzIG5vdCBzZXQKIyBDT05GSUdf
UlRDX0RSVl9NQVg2OTAwIGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9SUzVDMzcyIGlzIG5v
dCBzZXQKIyBDT05GSUdfUlRDX0RSVl9JU0wxMjA4IGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RS
Vl9YMTIwNSBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfUENGODU2MyBpcyBub3Qgc2V0CiMg
Q09ORklHX1JUQ19EUlZfUENGODU4MyBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfTTQxVDgw
IGlzIG5vdCBzZXQKQ09ORklHX1JUQ19EUlZfVFdMNDAzMD15CiMgQ09ORklHX1JUQ19EUlZfUzM1
MzkwQSBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfRk0zMTMwIGlzIG5vdCBzZXQKIyBDT05G
SUdfUlRDX0RSVl9SWDg1ODEgaXMgbm90IHNldAoKIwojIFNQSSBSVEMgZHJpdmVycwojCgojCiMg
UGxhdGZvcm0gUlRDIGRyaXZlcnMKIwojIENPTkZJR19SVENfRFJWX0NNT1MgaXMgbm90IHNldAoj
IENPTkZJR19SVENfRFJWX0RTMTI4NiBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfRFMxNTEx
IGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9EUzE1NTMgaXMgbm90IHNldAojIENPTkZJR19S
VENfRFJWX0RTMTc0MiBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfU1RLMTdUQTggaXMgbm90
IHNldAojIENPTkZJR19SVENfRFJWX000OFQ4NiBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZf
TTQ4VDM1IGlzIG5vdCBzZXQKIyBDT05GSUdfUlRDX0RSVl9NNDhUNTkgaXMgbm90IHNldAojIENP
TkZJR19SVENfRFJWX0JRNDgwMiBpcyBub3Qgc2V0CiMgQ09ORklHX1JUQ19EUlZfVjMwMjAgaXMg
bm90IHNldAoKIwojIG9uLUNQVSBSVEMgZHJpdmVycwojCiMgQ09ORklHX0RNQURFVklDRVMgaXMg
bm90IHNldApDT05GSUdfUkVHVUxBVE9SPXkKIyBDT05GSUdfUkVHVUxBVE9SX0RFQlVHIGlzIG5v
dCBzZXQKIyBDT05GSUdfUkVHVUxBVE9SX0ZJWEVEX1ZPTFRBR0UgaXMgbm90IHNldApDT05GSUdf
UkVHVUxBVE9SX1ZJUlRVQUxfQ09OU1VNRVI9eQojIENPTkZJR19SRUdVTEFUT1JfQlEyNDAyMiBp
cyBub3Qgc2V0CkNPTkZJR19SRUdVTEFUT1JfVFdMNDAzMD15CiMgQ09ORklHX1VJTyBpcyBub3Qg
c2V0CiMgQ09ORklHX1NUQUdJTkcgaXMgbm90IHNldAoKIwojIENCVVMgc3VwcG9ydAojCiMgQ09O
RklHX0NCVVMgaXMgbm90IHNldAoKIwojIEZpbGUgc3lzdGVtcwojCkNPTkZJR19FWFQyX0ZTPXkK
IyBDT05GSUdfRVhUMl9GU19YQVRUUiBpcyBub3Qgc2V0CiMgQ09ORklHX0VYVDJfRlNfWElQIGlz
IG5vdCBzZXQKQ09ORklHX0VYVDNfRlM9eQojIENPTkZJR19FWFQzX0ZTX1hBVFRSIGlzIG5vdCBz
ZXQKIyBDT05GSUdfRVhUNF9GUyBpcyBub3Qgc2V0CkNPTkZJR19KQkQ9eQojIENPTkZJR19KQkRf
REVCVUcgaXMgbm90IHNldAojIENPTkZJR19SRUlTRVJGU19GUyBpcyBub3Qgc2V0CiMgQ09ORklH
X0pGU19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0ZTX1BPU0lYX0FDTCBpcyBub3Qgc2V0CkNPTkZJ
R19GSUxFX0xPQ0tJTkc9eQojIENPTkZJR19YRlNfRlMgaXMgbm90IHNldAojIENPTkZJR19PQ0ZT
Ml9GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0JUUkZTX0ZTIGlzIG5vdCBzZXQKQ09ORklHX0ROT1RJ
Rlk9eQpDT05GSUdfSU5PVElGWT15CkNPTkZJR19JTk9USUZZX1VTRVI9eQpDT05GSUdfUVVPVEE9
eQojIENPTkZJR19RVU9UQV9ORVRMSU5LX0lOVEVSRkFDRSBpcyBub3Qgc2V0CkNPTkZJR19QUklO
VF9RVU9UQV9XQVJOSU5HPXkKQ09ORklHX1FVT1RBX1RSRUU9eQojIENPTkZJR19RRk1UX1YxIGlz
IG5vdCBzZXQKQ09ORklHX1FGTVRfVjI9eQpDT05GSUdfUVVPVEFDVEw9eQojIENPTkZJR19BVVRP
RlNfRlMgaXMgbm90IHNldAojIENPTkZJR19BVVRPRlM0X0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdf
RlVTRV9GUyBpcyBub3Qgc2V0CgojCiMgQ0QtUk9NL0RWRCBGaWxlc3lzdGVtcwojCiMgQ09ORklH
X0lTTzk2NjBfRlMgaXMgbm90IHNldAojIENPTkZJR19VREZfRlMgaXMgbm90IHNldAoKIwojIERP
Uy9GQVQvTlQgRmlsZXN5c3RlbXMKIwojIENPTkZJR19NU0RPU19GUyBpcyBub3Qgc2V0CiMgQ09O
RklHX1ZGQVRfRlMgaXMgbm90IHNldAojIENPTkZJR19OVEZTX0ZTIGlzIG5vdCBzZXQKCiMKIyBQ
c2V1ZG8gZmlsZXN5c3RlbXMKIwpDT05GSUdfUFJPQ19GUz15CkNPTkZJR19QUk9DX1NZU0NUTD15
CkNPTkZJR19QUk9DX1BBR0VfTU9OSVRPUj15CkNPTkZJR19TWVNGUz15CkNPTkZJR19UTVBGUz15
CiMgQ09ORklHX1RNUEZTX1BPU0lYX0FDTCBpcyBub3Qgc2V0CiMgQ09ORklHX0hVR0VUTEJfUEFH
RSBpcyBub3Qgc2V0CiMgQ09ORklHX0NPTkZJR0ZTX0ZTIGlzIG5vdCBzZXQKQ09ORklHX01JU0Nf
RklMRVNZU1RFTVM9eQojIENPTkZJR19BREZTX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfQUZGU19G
UyBpcyBub3Qgc2V0CiMgQ09ORklHX0hGU19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX0hGU1BMVVNf
RlMgaXMgbm90IHNldAojIENPTkZJR19CRUZTX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfQkZTX0ZT
IGlzIG5vdCBzZXQKIyBDT05GSUdfRUZTX0ZTIGlzIG5vdCBzZXQKQ09ORklHX0pGRlMyX0ZTPXkK
Q09ORklHX0pGRlMyX0ZTX0RFQlVHPTAKQ09ORklHX0pGRlMyX0ZTX1dSSVRFQlVGRkVSPXkKIyBD
T05GSUdfSkZGUzJfRlNfV0JVRl9WRVJJRlkgaXMgbm90IHNldAojIENPTkZJR19KRkZTMl9TVU1N
QVJZIGlzIG5vdCBzZXQKIyBDT05GSUdfSkZGUzJfRlNfWEFUVFIgaXMgbm90IHNldApDT05GSUdf
SkZGUzJfQ09NUFJFU1NJT05fT1BUSU9OUz15CkNPTkZJR19KRkZTMl9aTElCPXkKQ09ORklHX0pG
RlMyX0xaTz15CkNPTkZJR19KRkZTMl9SVElNRT15CkNPTkZJR19KRkZTMl9SVUJJTj15CiMgQ09O
RklHX0pGRlMyX0NNT0RFX05PTkUgaXMgbm90IHNldAojIENPTkZJR19KRkZTMl9DTU9ERV9QUklP
UklUWSBpcyBub3Qgc2V0CiMgQ09ORklHX0pGRlMyX0NNT0RFX1NJWkUgaXMgbm90IHNldApDT05G
SUdfSkZGUzJfQ01PREVfRkFWT1VSTFpPPXkKIyBDT05GSUdfQ1JBTUZTIGlzIG5vdCBzZXQKIyBD
T05GSUdfU1FVQVNIRlMgaXMgbm90IHNldAojIENPTkZJR19WWEZTX0ZTIGlzIG5vdCBzZXQKIyBD
T05GSUdfTUlOSVhfRlMgaXMgbm90IHNldAojIENPTkZJR19PTUZTX0ZTIGlzIG5vdCBzZXQKIyBD
T05GSUdfSFBGU19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX1FOWDRGU19GUyBpcyBub3Qgc2V0CiMg
Q09ORklHX1JPTUZTX0ZTIGlzIG5vdCBzZXQKIyBDT05GSUdfU1lTVl9GUyBpcyBub3Qgc2V0CiMg
Q09ORklHX1VGU19GUyBpcyBub3Qgc2V0CiMgQ09ORklHX05FVFdPUktfRklMRVNZU1RFTVMgaXMg
bm90IHNldAoKIwojIFBhcnRpdGlvbiBUeXBlcwojCkNPTkZJR19QQVJUSVRJT05fQURWQU5DRUQ9
eQojIENPTkZJR19BQ09STl9QQVJUSVRJT04gaXMgbm90IHNldAojIENPTkZJR19PU0ZfUEFSVElU
SU9OIGlzIG5vdCBzZXQKIyBDT05GSUdfQU1JR0FfUEFSVElUSU9OIGlzIG5vdCBzZXQKIyBDT05G
SUdfQVRBUklfUEFSVElUSU9OIGlzIG5vdCBzZXQKIyBDT05GSUdfTUFDX1BBUlRJVElPTiBpcyBu
b3Qgc2V0CkNPTkZJR19NU0RPU19QQVJUSVRJT049eQojIENPTkZJR19CU0RfRElTS0xBQkVMIGlz
IG5vdCBzZXQKIyBDT05GSUdfTUlOSVhfU1VCUEFSVElUSU9OIGlzIG5vdCBzZXQKIyBDT05GSUdf
U09MQVJJU19YODZfUEFSVElUSU9OIGlzIG5vdCBzZXQKIyBDT05GSUdfVU5JWFdBUkVfRElTS0xB
QkVMIGlzIG5vdCBzZXQKIyBDT05GSUdfTERNX1BBUlRJVElPTiBpcyBub3Qgc2V0CiMgQ09ORklH
X1NHSV9QQVJUSVRJT04gaXMgbm90IHNldAojIENPTkZJR19VTFRSSVhfUEFSVElUSU9OIGlzIG5v
dCBzZXQKIyBDT05GSUdfU1VOX1BBUlRJVElPTiBpcyBub3Qgc2V0CiMgQ09ORklHX0tBUk1BX1BB
UlRJVElPTiBpcyBub3Qgc2V0CiMgQ09ORklHX0VGSV9QQVJUSVRJT04gaXMgbm90IHNldAojIENP
TkZJR19TWVNWNjhfUEFSVElUSU9OIGlzIG5vdCBzZXQKQ09ORklHX05MUz15CkNPTkZJR19OTFNf
REVGQVVMVD0iaXNvODg1OS0xIgpDT05GSUdfTkxTX0NPREVQQUdFXzQzNz15CiMgQ09ORklHX05M
U19DT0RFUEFHRV83MzcgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfNzc1IGlzIG5v
dCBzZXQKIyBDT05GSUdfTkxTX0NPREVQQUdFXzg1MCBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19D
T0RFUEFHRV84NTIgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfODU1IGlzIG5vdCBz
ZXQKIyBDT05GSUdfTkxTX0NPREVQQUdFXzg1NyBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RF
UEFHRV84NjAgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfODYxIGlzIG5vdCBzZXQK
IyBDT05GSUdfTkxTX0NPREVQQUdFXzg2MiBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RFUEFH
RV84NjMgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfODY0IGlzIG5vdCBzZXQKIyBD
T05GSUdfTkxTX0NPREVQQUdFXzg2NSBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RFUEFHRV84
NjYgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfODY5IGlzIG5vdCBzZXQKIyBDT05G
SUdfTkxTX0NPREVQQUdFXzkzNiBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RFUEFHRV85NTAg
aXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfOTMyIGlzIG5vdCBzZXQKIyBDT05GSUdf
TkxTX0NPREVQQUdFXzk0OSBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19DT0RFUEFHRV84NzQgaXMg
bm90IHNldAojIENPTkZJR19OTFNfSVNPODg1OV84IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0NP
REVQQUdFXzEyNTAgaXMgbm90IHNldAojIENPTkZJR19OTFNfQ09ERVBBR0VfMTI1MSBpcyBub3Qg
c2V0CiMgQ09ORklHX05MU19BU0NJSSBpcyBub3Qgc2V0CkNPTkZJR19OTFNfSVNPODg1OV8xPXkK
IyBDT05GSUdfTkxTX0lTTzg4NTlfMiBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19JU084ODU5XzMg
aXMgbm90IHNldAojIENPTkZJR19OTFNfSVNPODg1OV80IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxT
X0lTTzg4NTlfNSBpcyBub3Qgc2V0CiMgQ09ORklHX05MU19JU084ODU5XzYgaXMgbm90IHNldAoj
IENPTkZJR19OTFNfSVNPODg1OV83IGlzIG5vdCBzZXQKIyBDT05GSUdfTkxTX0lTTzg4NTlfOSBp
cyBub3Qgc2V0CiMgQ09ORklHX05MU19JU084ODU5XzEzIGlzIG5vdCBzZXQKIyBDT05GSUdfTkxT
X0lTTzg4NTlfMTQgaXMgbm90IHNldAojIENPTkZJR19OTFNfSVNPODg1OV8xNSBpcyBub3Qgc2V0
CiMgQ09ORklHX05MU19LT0k4X1IgaXMgbm90IHNldAojIENPTkZJR19OTFNfS09JOF9VIGlzIG5v
dCBzZXQKIyBDT05GSUdfTkxTX1VURjggaXMgbm90IHNldAojIENPTkZJR19ETE0gaXMgbm90IHNl
dAoKIwojIEtlcm5lbCBoYWNraW5nCiMKIyBDT05GSUdfUFJJTlRLX1RJTUUgaXMgbm90IHNldApD
T05GSUdfRU5BQkxFX1dBUk5fREVQUkVDQVRFRD15CkNPTkZJR19FTkFCTEVfTVVTVF9DSEVDSz15
CkNPTkZJR19GUkFNRV9XQVJOPTEwMjQKQ09ORklHX01BR0lDX1NZU1JRPXkKIyBDT05GSUdfVU5V
U0VEX1NZTUJPTFMgaXMgbm90IHNldApDT05GSUdfREVCVUdfRlM9eQojIENPTkZJR19IRUFERVJT
X0NIRUNLIGlzIG5vdCBzZXQKQ09ORklHX0RFQlVHX0tFUk5FTD15CiMgQ09ORklHX0RFQlVHX1NI
SVJRIGlzIG5vdCBzZXQKQ09ORklHX0RFVEVDVF9TT0ZUTE9DS1VQPXkKIyBDT05GSUdfQk9PVFBB
UkFNX1NPRlRMT0NLVVBfUEFOSUMgaXMgbm90IHNldApDT05GSUdfQk9PVFBBUkFNX1NPRlRMT0NL
VVBfUEFOSUNfVkFMVUU9MApDT05GSUdfU0NIRURfREVCVUc9eQojIENPTkZJR19TQ0hFRFNUQVRT
IGlzIG5vdCBzZXQKQ09ORklHX1RJTUVSX1NUQVRTPXkKIyBDT05GSUdfREVCVUdfT0JKRUNUUyBp
cyBub3Qgc2V0CiMgQ09ORklHX0RFQlVHX1NMQUIgaXMgbm90IHNldApDT05GSUdfREVCVUdfUFJF
RU1QVD15CiMgQ09ORklHX0RFQlVHX1JUX01VVEVYRVMgaXMgbm90IHNldAojIENPTkZJR19SVF9N
VVRFWF9URVNURVIgaXMgbm90IHNldAojIENPTkZJR19ERUJVR19TUElOTE9DSyBpcyBub3Qgc2V0
CkNPTkZJR19ERUJVR19NVVRFWEVTPXkKIyBDT05GSUdfREVCVUdfTE9DS19BTExPQyBpcyBub3Qg
c2V0CiMgQ09ORklHX1BST1ZFX0xPQ0tJTkcgaXMgbm90IHNldAojIENPTkZJR19MT0NLX1NUQVQg
aXMgbm90IHNldAojIENPTkZJR19ERUJVR19TUElOTE9DS19TTEVFUCBpcyBub3Qgc2V0CiMgQ09O
RklHX0RFQlVHX0xPQ0tJTkdfQVBJX1NFTEZURVNUUyBpcyBub3Qgc2V0CiMgQ09ORklHX0RFQlVH
X0tPQkpFQ1QgaXMgbm90IHNldApDT05GSUdfREVCVUdfQlVHVkVSQk9TRT15CkNPTkZJR19ERUJV
R19JTkZPPXkKIyBDT05GSUdfREVCVUdfVk0gaXMgbm90IHNldAojIENPTkZJR19ERUJVR19XUklU
RUNPVU5UIGlzIG5vdCBzZXQKIyBDT05GSUdfREVCVUdfTUVNT1JZX0lOSVQgaXMgbm90IHNldAoj
IENPTkZJR19ERUJVR19MSVNUIGlzIG5vdCBzZXQKIyBDT05GSUdfREVCVUdfU0cgaXMgbm90IHNl
dAojIENPTkZJR19ERUJVR19OT1RJRklFUlMgaXMgbm90IHNldApDT05GSUdfRlJBTUVfUE9JTlRF
Uj15CiMgQ09ORklHX0JPT1RfUFJJTlRLX0RFTEFZIGlzIG5vdCBzZXQKIyBDT05GSUdfUkNVX1RP
UlRVUkVfVEVTVCBpcyBub3Qgc2V0CiMgQ09ORklHX1JDVV9DUFVfU1RBTExfREVURUNUT1IgaXMg
bm90IHNldAojIENPTkZJR19CQUNLVFJBQ0VfU0VMRl9URVNUIGlzIG5vdCBzZXQKIyBDT05GSUdf
REVCVUdfQkxPQ0tfRVhUX0RFVlQgaXMgbm90IHNldAojIENPTkZJR19GQVVMVF9JTkpFQ1RJT04g
aXMgbm90IHNldAojIENPTkZJR19MQVRFTkNZVE9QIGlzIG5vdCBzZXQKQ09ORklHX0hBVkVfRlVO
Q1RJT05fVFJBQ0VSPXkKCiMKIyBUcmFjZXJzCiMKIyBDT05GSUdfRlVOQ1RJT05fVFJBQ0VSIGlz
IG5vdCBzZXQKIyBDT05GSUdfSVJRU09GRl9UUkFDRVIgaXMgbm90IHNldAojIENPTkZJR19QUkVF
TVBUX1RSQUNFUiBpcyBub3Qgc2V0CiMgQ09ORklHX1NDSEVEX1RSQUNFUiBpcyBub3Qgc2V0CiMg
Q09ORklHX0NPTlRFWFRfU1dJVENIX1RSQUNFUiBpcyBub3Qgc2V0CiMgQ09ORklHX0JPT1RfVFJB
Q0VSIGlzIG5vdCBzZXQKIyBDT05GSUdfVFJBQ0VfQlJBTkNIX1BST0ZJTElORyBpcyBub3Qgc2V0
CiMgQ09ORklHX1NUQUNLX1RSQUNFUiBpcyBub3Qgc2V0CiMgQ09ORklHX0RZTkFNSUNfUFJJTlRL
X0RFQlVHIGlzIG5vdCBzZXQKIyBDT05GSUdfU0FNUExFUyBpcyBub3Qgc2V0CkNPTkZJR19IQVZF
X0FSQ0hfS0dEQj15CiMgQ09ORklHX0tHREIgaXMgbm90IHNldAojIENPTkZJR19ERUJVR19VU0VS
IGlzIG5vdCBzZXQKQ09ORklHX0RFQlVHX0VSUk9SUz15CiMgQ09ORklHX0RFQlVHX1NUQUNLX1VT
QUdFIGlzIG5vdCBzZXQKIyBDT05GSUdfREVCVUdfTEwgaXMgbm90IHNldAoKIwojIFNlY3VyaXR5
IG9wdGlvbnMKIwojIENPTkZJR19LRVlTIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VDVVJJVFkgaXMg
bm90IHNldAojIENPTkZJR19TRUNVUklUWUZTIGlzIG5vdCBzZXQKIyBDT05GSUdfU0VDVVJJVFlf
RklMRV9DQVBBQklMSVRJRVMgaXMgbm90IHNldApDT05GSUdfQ1JZUFRPPXkKCiMKIyBDcnlwdG8g
Y29yZSBvciBoZWxwZXIKIwojIENPTkZJR19DUllQVE9fRklQUyBpcyBub3Qgc2V0CkNPTkZJR19D
UllQVE9fQUxHQVBJPXkKQ09ORklHX0NSWVBUT19BTEdBUEkyPXkKQ09ORklHX0NSWVBUT19BRUFE
Mj15CkNPTkZJR19DUllQVE9fQkxLQ0lQSEVSMj15CkNPTkZJR19DUllQVE9fSEFTSD15CkNPTkZJ
R19DUllQVE9fSEFTSDI9eQpDT05GSUdfQ1JZUFRPX1JORzI9eQpDT05GSUdfQ1JZUFRPX01BTkFH
RVI9eQpDT05GSUdfQ1JZUFRPX01BTkFHRVIyPXkKIyBDT05GSUdfQ1JZUFRPX0dGMTI4TVVMIGlz
IG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX05VTEwgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9f
Q1JZUFREIGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX0FVVEhFTkMgaXMgbm90IHNldAojIENP
TkZJR19DUllQVE9fVEVTVCBpcyBub3Qgc2V0CgojCiMgQXV0aGVudGljYXRlZCBFbmNyeXB0aW9u
IHdpdGggQXNzb2NpYXRlZCBEYXRhCiMKIyBDT05GSUdfQ1JZUFRPX0NDTSBpcyBub3Qgc2V0CiMg
Q09ORklHX0NSWVBUT19HQ00gaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fU0VRSVYgaXMgbm90
IHNldAoKIwojIEJsb2NrIG1vZGVzCiMKIyBDT05GSUdfQ1JZUFRPX0NCQyBpcyBub3Qgc2V0CiMg
Q09ORklHX0NSWVBUT19DVFIgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fQ1RTIGlzIG5vdCBz
ZXQKIyBDT05GSUdfQ1JZUFRPX0VDQiBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19MUlcgaXMg
bm90IHNldAojIENPTkZJR19DUllQVE9fUENCQyBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19Y
VFMgaXMgbm90IHNldAoKIwojIEhhc2ggbW9kZXMKIwojIENPTkZJR19DUllQVE9fSE1BQyBpcyBu
b3Qgc2V0CiMgQ09ORklHX0NSWVBUT19YQ0JDIGlzIG5vdCBzZXQKCiMKIyBEaWdlc3QKIwpDT05G
SUdfQ1JZUFRPX0NSQzMyQz15CiMgQ09ORklHX0NSWVBUT19NRDQgaXMgbm90IHNldAojIENPTkZJ
R19DUllQVE9fTUQ1IGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX01JQ0hBRUxfTUlDIGlzIG5v
dCBzZXQKIyBDT05GSUdfQ1JZUFRPX1JNRDEyOCBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19S
TUQxNjAgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fUk1EMjU2IGlzIG5vdCBzZXQKIyBDT05G
SUdfQ1JZUFRPX1JNRDMyMCBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19TSEExIGlzIG5vdCBz
ZXQKIyBDT05GSUdfQ1JZUFRPX1NIQTI1NiBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19TSEE1
MTIgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fVEdSMTkyIGlzIG5vdCBzZXQKIyBDT05GSUdf
Q1JZUFRPX1dQNTEyIGlzIG5vdCBzZXQKCiMKIyBDaXBoZXJzCiMKIyBDT05GSUdfQ1JZUFRPX0FF
UyBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19BTlVCSVMgaXMgbm90IHNldAojIENPTkZJR19D
UllQVE9fQVJDNCBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19CTE9XRklTSCBpcyBub3Qgc2V0
CiMgQ09ORklHX0NSWVBUT19DQU1FTExJQSBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19DQVNU
NSBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19DQVNUNiBpcyBub3Qgc2V0CiMgQ09ORklHX0NS
WVBUT19ERVMgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9fRkNSWVBUIGlzIG5vdCBzZXQKIyBD
T05GSUdfQ1JZUFRPX0tIQVpBRCBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19TQUxTQTIwIGlz
IG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX1NFRUQgaXMgbm90IHNldAojIENPTkZJR19DUllQVE9f
U0VSUEVOVCBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19URUEgaXMgbm90IHNldAojIENPTkZJ
R19DUllQVE9fVFdPRklTSCBpcyBub3Qgc2V0CgojCiMgQ29tcHJlc3Npb24KIwojIENPTkZJR19D
UllQVE9fREVGTEFURSBpcyBub3Qgc2V0CiMgQ09ORklHX0NSWVBUT19MWk8gaXMgbm90IHNldAoK
IwojIFJhbmRvbSBOdW1iZXIgR2VuZXJhdGlvbgojCiMgQ09ORklHX0NSWVBUT19BTlNJX0NQUk5H
IGlzIG5vdCBzZXQKIyBDT05GSUdfQ1JZUFRPX0hXIGlzIG5vdCBzZXQKCiMKIyBMaWJyYXJ5IHJv
dXRpbmVzCiMKQ09ORklHX0JJVFJFVkVSU0U9eQpDT05GSUdfR0VORVJJQ19GSU5EX0xBU1RfQklU
PXkKQ09ORklHX0NSQ19DQ0lUVD15CiMgQ09ORklHX0NSQzE2IGlzIG5vdCBzZXQKIyBDT05GSUdf
Q1JDX1QxMERJRiBpcyBub3Qgc2V0CiMgQ09ORklHX0NSQ19JVFVfVCBpcyBub3Qgc2V0CkNPTkZJ
R19DUkMzMj15CiMgQ09ORklHX0NSQzcgaXMgbm90IHNldApDT05GSUdfTElCQ1JDMzJDPXkKQ09O
RklHX1pMSUJfSU5GTEFURT15CkNPTkZJR19aTElCX0RFRkxBVEU9eQpDT05GSUdfTFpPX0NPTVBS
RVNTPXkKQ09ORklHX0xaT19ERUNPTVBSRVNTPXkKQ09ORklHX1BMSVNUPXkKQ09ORklHX0hBU19J
T01FTT15CkNPTkZJR19IQVNfSU9QT1JUPXkKQ09ORklHX0hBU19ETUE9eQo=
--000e0cd1554c354a28046670eb9f--
