From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: PM branch rebased to 2.6.29
Date: Tue, 31 Mar 2009 11:25:43 -0700
Message-ID: <87myb1wnvc.fsf@deeprootsystems.com>
References: <87bprz9zju.fsf@deeprootsystems.com>
	<1237914611.23022.124.camel@blackhole>
	<87zlfaztcd.fsf@deeprootsystems.com>
	<1237925484.23022.133.camel@blackhole>
	<49C940CA.9070805@deeprootsystems.com>
	<f9d2a5e10903271350x2d534c76nc55c492b8acd1d4e@mail.gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301CC5699A0@dbde02.ent.ti.com>
	<f9d2a5e10903301044u775edfdo7ac540b3e1bdc597@mail.gmail.com>
	<873acu26ms.fsf@deeprootsystems.com>
	<f9d2a5e10903301601q5fcd331bs44c81d854ad0082f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.169]:15206 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753751AbZCaSZz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Mar 2009 14:25:55 -0400
Received: by wf-out-1314.google.com with SMTP id 29so3311266wff.4
        for <linux-omap@vger.kernel.org>; Tue, 31 Mar 2009 11:25:53 -0700 (PDT)
In-Reply-To: <f9d2a5e10903301601q5fcd331bs44c81d854ad0082f@mail.gmail.com> (Russ Dill's message of "Mon\, 30 Mar 2009 16\:01\:24 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russ Dill <russ.dill@gmail.com>
Cc: "Premi, Sanjeev" <premi@ti.com>, Peter Barada <peterb@logicpd.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Russ Dill <russ.dill@gmail.com> writes:

> On Mon, Mar 30, 2009 at 11:43 AM, Kevin Hilman
> <khilman@deeprootsystems.com> wrote:
>> Russ Dill <russ.dill@gmail.com> writes:
>>
>>> On Mon, Mar 30, 2009 at 3:08 AM, Premi, Sanjeev <premi@ti.com> wrot=
e:
>> [...]
>>>>
>>>> I had found that two drivers that could prevent clocks_off are
>>>> USB and DSS because of the way they use clk_enable().
>>>>
>>>> Can you try building without theses drivers just for verification?
>>>>
>>>
>>> Building without dss makes things worse:
>>>
>>> Powerdomain (dss_pwrdm) didn't enter target state 0
>>>
>>> Maybe by looking at what the dss driver is doing I can get core and
>>> per to turn off.
>>
>> Russ,
>>
>> Can you try with the latest HEAD of PM branch. =A0After suspend/resu=
me,
>> do
>>
>> # cat /debug/pm_debug/registers/1
>>
>> and post results to list. =A0We can then see the exact state of PM
>> registers before going into WFI.

Russ,

With the dump below, what was the output after you resumed?  Which
powerdomains did not hit their target state?  It looks like PER and
CORE did not hit target state.

Also, you didn't mention what hardware you're using or your .config or
your bootloader etc.  All of these play an important role.

> root@beagleboard:/sys# cat /debug/pm_debug/registers/1
> MOD: CM_IVA2 (48014000)
>   04 =3D> 00000037  20 =3D> 00000001  34 =3D> 00000001  40 =3D> 00096=
80c
>   44 =3D> 00000001  48 =3D> 00000003
> MOD: CM_OCP (48004800)
>   00 =3D> 00000010  10 =3D> 00000001
> MOD: CM_MPU (48004900)
>   04 =3D> 00000037  24 =3D> 00000001  34 =3D> 00000001  40 =3D> 0011f=
40c
>   44 =3D> 00000001  48 =3D> 00000003  4c =3D> 00000001
> MOD: CM_CORE (48004a00)
>   10 =3D> 00000042  20 =3D> ffffffbd  24 =3D> 0000001f  28 =3D> 00000=
00d
>   30 =3D> fffffed9  34 =3D> 0000001f  38 =3D> 0000000c  40 =3D> 00000=
30a
>   48 =3D> 0000003f  4c =3D> 00000003
> MOD: CM_SGX (48004b00)
>   20 =3D> 00000001  48 =3D> 00000003
> MOD: CM_WKUP (48004c00)
>   10 =3D> 0000000e  20 =3D> 000002f1  30 =3D> 0000003f  40 =3D> 00000=
015

Here is at least one problem.

Offset 0x40 is CM_CLKSEL_WKUP, and bit 0 shows which clock is the
source clock for GPTIMER1.  Here, bit 0 is 1 which means SYS_CLK
is used as the timer source. =20

Based on this, you must have:

   System Type --> TI OMAP Implementations --> System Timer

set to 'MPU timer'.  Please change to 32k timer.  Using MPU timer will
keep timers not in WKUP powerdomain (which is all of them except GPT1)
running across suspend, preventing PER from hitting RET.

Using the 32k timer only uses GPT1 and sources it from the 32k clock, b=
oth
of which are in the WKUP powerdomain.

> MOD: CM_CCR (48004d00)
>   00 =3D> f8311037  04 =3D> 00000017  20 =3D> 00000201  30 =3D> 00000=
009
>   34 =3D> 00000001  40 =3D> 094c0c00  44 =3D> 0001b00c  48 =3D> 00000=
009
>   50 =3D> 00000001  70 =3D> 00000003
> MOD: CM_DSS (48004e00)
>   20 =3D> 00000003  30 =3D> 00000001  40 =3D> 00001006  48 =3D> 00000=
003
> MOD: CM_CAM (48004f00)
>   20 =3D> 00000001  30 =3D> 00000001  40 =3D> 00000004  48 =3D> 00000=
003
> MOD: CM_PER (48005000)
>   10 =3D> 0003e000  20 =3D> 00001fff  30 =3D> 0003ffff  40 =3D> 00000=
0ff
>   44 =3D> 00000006  48 =3D> 00000003  4c =3D> 00000001
> MOD: CM_EMU (48005100)
>   40 =3D> 03020a50  48 =3D> 00000002  4c =3D> 00000001
> MOD: CM_NEON (48005300)
>   48 =3D> 00000003
> MOD: CM_USB (48005400)
>   20 =3D> 00000003  30 =3D> 00000001  48 =3D> 00000003
> MOD: PRM_IVA2 (48316000)
>   50 =3D> 00000007  e0 =3D> 00ff0f04  f8 =3D> 00000007
> MOD: PRM_OCP (48306800)
>   04 =3D> 00000010  14 =3D> 00000001  1c =3D> 00000201
> MOD: PRM_MPU (48306900)
>   58 =3D> 00000005  d4 =3D> 00000012  e0 =3D> 00030104  e4 =3D> 00000=
0c7
>   e8 =3D> 000000c7
> MOD: PRM_CORE (48306a00)
>   58 =3D> 00000301  a0 =3D> c33ffe18  a4 =3D> c33ffe18  a8 =3D> c33ff=
e18
>   e0 =3D> 000f0304  e4 =3D> 000000f7  e8 =3D> 000000f7  f0 =3D> 00000=
004
>   f4 =3D> 00000004  f8 =3D> 00000004
> MOD: PRM_SGX (48306b00)
>   e0 =3D> 00030104
> MOD: PRM_WKUP (48306c00)
>   a0 =3D> 0000010b  a4 =3D> 0000010b
> MOD: PRM_CCR (48306d00)
>   40 =3D> 00000003
> MOD: PRM_DSS (48306e00)
>   58 =3D> 00000005  a0 =3D> 00000001  e0 =3D> 00030104
> MOD: PRM_CAM (48306f00)
>   58 =3D> 00000001  e0 =3D> 00030104
> MOD: PRM_PER (48307000)
>   58 =3D> 00000001  a0 =3D> 0003efff  a4 =3D> 0003efff  a8 =3D> 0003e=
fff
>   c8 =3D> 00000007  e0 =3D> 00030104  e4 =3D> 00000007  e8 =3D> 00000=
007
> MOD: PRM_EMU (48307100)
>   58 =3D> 00000005  e4 =3D> 00000103
> MOD: PRM_GLBL (48307200)
>   20 =3D> 00120012  24 =3D> 00010000  2c =3D> 301e1e30  30 =3D> 2c1e1=
e2c
>   34 =3D> 00120000  38 =3D> 00000018  54 =3D> 00001006  58 =3D> 00000=
001
>   60 =3D> 0000000e  64 =3D> 00000050  70 =3D> 00000088  90 =3D> 0fff0=
fff
>   94 =3D> 000000ff  98 =3D> 000000ff  9c =3D> 00000002  a0 =3D> 00000=
0ff
>   c4 =3D> 00000001  e4 =3D> 00000001
> MOD: PRM_NEON (48307300)
>   58 =3D> 00000005  c8 =3D> 00000002  e0 =3D> 00000004  e4 =3D> 00000=
003
>   e8 =3D> 00000003
> MOD: PRM_USB (48307400)
>   58 =3D> 00000001  a0 =3D> 00000001  a4 =3D> 00000001  a8 =3D> 00000=
001
>   e0 =3D> 00030104
>
>
>> Also, post dump of
>>
>
> root@beagleboard:/sys# cat /debug/pm_debug/count
> usbhost_pwrdm (OFF),OFF:1,RET:1,INA:0,ON:1
> sgx_pwrdm (OFF),OFF:1,RET:0,INA:0,ON:1
> per_pwrdm (ON),OFF:0,RET:0,INA:0,ON:1
> dss_pwrdm (ON),OFF:2,RET:0,INA:0,ON:3
> cam_pwrdm (OFF),OFF:1,RET:1,INA:0,ON:1
> core_pwrdm (ON),OFF:0,RET:0,INA:0,ON:1
> neon_pwrdm (ON),OFF:2,RET:0,INA:14100,ON:14103
> mpu_pwrdm (ON),OFF:2,RET:0,INA:14100,ON:14103
> iva2_pwrdm (OFF),OFF:1,RET:1,INA:0,ON:1
> per_clkdm->per_pwrdm (9)
> usbhost_clkdm->usbhost_pwrdm (0)
> cam_clkdm->cam_pwrdm (0)
> dss_clkdm->dss_pwrdm (2)
> core_l4_clkdm->core_pwrdm (8)
> core_l3_clkdm->core_pwrdm (4)
> d2d_clkdm->core_pwrdm (0)
> sgx_clkdm->sgx_pwrdm (0)
> iva2_clkdm->iva2_pwrdm (0)
> neon_clkdm->neon_pwrdm (0)
> mpu_clkdm->mpu_pwrdm (0)
> virt_opp_clkdm->wkup_pwrdm (0)
> prm_clkdm->wkup_pwrdm (10)
> cm_clkdm->core_pwrdm (3)

Based on this, I see that you're DSS is not the problem anymore as it
is hitting off, but neither PER nor CORE have made any transistions.
PER is most likely because of the timer issue above.  Not sure yet
about CORE.

In addtion to more details on your hardware and .config, Can you send
me the console log of a full boot followed by trying just retention in
suspend by doing the following right after boot:

# cat /debug/pm_debug/count
# echo 1 > /sys/power/clocks_off_while_idle
# echo mem > /sys/power/state

<after wakeup>

# cat /debug/pm_debug/count
# cat /debug/pm_debug/registers/1

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
