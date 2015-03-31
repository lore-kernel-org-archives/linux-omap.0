From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv5 00/35] ARM: OMAP2+: PRCM/SCM cleanups against 4.0-rc
Date: Tue, 31 Mar 2015 21:28:29 +0300
Message-ID: <551AE74D.3070303@ti.com>
References: <1426877086-17131-1-git-send-email-t-kristo@ti.com> <20150331001019.GN10805@atomide.com> <20150331012527.GO10805@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43623 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752725AbbCaS2o (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 31 Mar 2015 14:28:44 -0400
In-Reply-To: <20150331012527.GO10805@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, sakari.ailus@iki.fi, linux-arm-kernel@lists.infradead.org

On 03/31/2015 04:25 AM, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [150330 17:15]:
>> Hi Tero,
>>
>> * Tero Kristo <t-kristo@ti.com> [150320 11:45]:
>>> Hi,
>>>
>>> v5 contains the following changes still:
>>>
>>> - re-ordered patches a bit, the single clock driver fix moved to be=
ginning
>>>    of the set, waiting for a separate merge from Mike
>>> - Changed patch #23 to fix the slightly misleading logic (removed t=
he extra +1)
>>> - Changed patches #16 and #18 to fix OMAP2/3/4 etc. only builds
>>> - Fixed ti81xx boot issues (hopefully, I don't have access to hardw=
are
>>>    to test it)
>>> - Changed control module DTS layout based on discussions with Tony,=
 this
>>>    includes addition of minimal l4 bus (patch #25+)
>>>
>>> Testing done for v5:
>>>   1: am335x-evm      : boot
>>>   2: am335x-evmsk    : boot
>>>   3: am3517-evm      : boot
>>>   4: am43x-epos-evm  : boot
>>>   5: am437x-gp-evm   : boot
>>>   6: omap3-beagle-xm : boot
>>>   7: omap3-beagle    : boot, suspend (ret/off), cpuidle (ret/off)
>>>   8: am335x-boneblack: boot
>>>   9: am335x-bone     : boot
>>> 10: dra7xx-evm      : boot
>>> 11: omap3-n900      : boot
>>> 12: omap5-uevm      : boot
>>> 13: omap4-panda-es  : boot, suspend (ret), cpuidle (ret)
>>> 14: omap4-panda     : boot
>>> 15: omap2430-sdp    : boot
>>> 16: omap3430-sdp    : boot
>>> 17: omap4-sdp-es23plus: boot
>>>
>>> Branch available at:
>>> - tree: https://github.com/t-kristo/linux-pm.git
>>> - branch: 4.0-rc1-prcm-cleanup-v5
>>
>> I found few more issues regarding diff of the dmesg before and after=
,
>> you may want to diff also dra7 before and after.
>>
>> Then I just noticed this series won't boot on omap3 with the legacy =
mode.
>> You can test this by building a uImage with the following command:
>>
>> $ mkimage -A arm -O linux -T kernel -C none -a 0x80008000 -e 0x80008=
000 \
>> 	-n "Linux" -d arch/arm/boot/zImage /tmp/uImage
>>
>> Then make sure you're not passing a .dtb file.
>>
>> Below is the error I'm getting with debug_ll + earlyprintk enabled.
>
> Also noticed a make randconfig build warning:
>
> arch/arm/mach-omap2/prm_common.c:702:35: warning: =E2=80=98scrm_data=E2=
=80=99 defined but not used [-Wunused-variable]
>
> That seems to happen at least with the following selection:
>
> # CONFIG_ARCH_OMAP2 is not set
> # CONFIG_ARCH_OMAP3 is not set
> # CONFIG_ARCH_OMAP4 is not set
> # CONFIG_SOC_OMAP5 is not set
> # CONFIG_SOC_AM33XX is not set
> CONFIG_SOC_AM43XX=3Dy
> # CONFIG_SOC_DRA7XX is not set
> CONFIG_ARCH_OMAP2PLUS=3Dy

Ok will fix that warning also and repost in a bit.

-Tero

>
> Regards,
>
> Tony
>
>
>> [    0.000000] PC is at regmap_read+0x10/0x60
>> [    0.000000] LR is at clk_memmap_readl+0x34/0x54
>> [    0.000000] pc : [<c03f2c88>]    lr : [<c0035694>]    psr: 200001=
d3
>> [    0.000000] sp : c08d1e90  ip : 00000000  fp : 00000000
>> [    0.000000] r10: c07efaa8  r9 : 00000040  r8 : c601c5c0
>> [    0.000000] r7 : c601bbc0  r6 : c601c5c0  r5 : 00000040  r4 : 000=
00001
>> [    0.000000] r3 : fa004000  r2 : c08d1ea4  r1 : 00000040  r0 : 000=
00040
>> [    0.000000] Flags: nzCv  IRQs off  FIQs off  Mode SVC_32  ISA ARM=
  Segment kernel
>> [    0.000000] Control: 10c5387d  Table: 80004019  DAC: 00000015
>> [    0.000000] Process swapper/0 (pid: 0, stack limit =3D 0xc08d0218=
)
>> [    0.000000] Stack: (0xc08d1e90 to 0xc08d2000)
>> [    0.000000] 1e80:                                     00000000 c6=
01bbc0 c601c5c0 c0035694
>> [    0.000000] 1ea0: c6001c8c c6001c40 c07f0000 c04d7d78 00000000 00=
000001 c07efaa8 c04d4dd0
>> [    0.000000] 1ec0: 00000000 00000000 c04d08c4 c115c5bc 600001d3 c6=
01bbc0 00000020 00000001
>> [    0.000000] 1ee0: 00000003 00000013 00000040 c07efaa8 00000000 c0=
4d8284 00000000 c07f0000
>> [    0.000000] 1f00: c094e4e8 c07efaa8 c06683ec c08d1efc c7eff101 00=
000020 c0951fe4 00000001
>> [    0.000000] 1f20: 00000000 00000000 c0951fcc c7eff140 c0965000 c0=
4d840c 00000013 00000003
>> [    0.000000] 1f40: 00000001 00000000 039457c8 00000040 c601bb80 c0=
951fcc c0945dac c094e504
>> [    0.000000] 1f60: c08b3280 c08a7694 00000000 c601bb80 c094e4e8 c6=
01bb80 c094e508 c08a77a8
>> [    0.000000] 1f80: c08aa480 00000000 c0965000 ffffffff c08d28c0 c0=
8b3280 c7eff140 c0965000
>> [    0.000000] 1fa0: 00000000 c08aa490 c08aa480 00000000 c0965000 c0=
86f7a4 c08b1e58 c0863aec
>> [    0.000000] 1fc0: ffffffff ffffffff c0863678 00000000 00000000 c0=
8b3280 c0965214 c08d296c
>> [    0.000000] 1fe0: c08b327c c08d7a0c 80004059 411fc083 00000000 80=
00807c 00000000 00000000
>> [    0.000000] [<c03f2c88>] (regmap_read) from [<c0035694>] (clk_mem=
map_readl+0x34/0x54)
>> [    0.000000] [<c0035694>] (clk_memmap_readl) from [<c04d7d78>] (ti=
_clk_divider_recalc_rate+0x20/0xf8)
>> [    0.000000] [<c04d7d78>] (ti_clk_divider_recalc_rate) from [<c04d=
4dd0>] (clk_register+0x360/0x6f8)
>> [    0.000000] [<c04d4dd0>] (clk_register) from [<c04d8284>] (_regis=
ter_divider.constprop.5+0xb8/0x120)
>> [    0.000000] [<c04d8284>] (_register_divider.constprop.5) from [<c=
04d840c>] (ti_clk_register_divider+0x80/0xa4)
>> [    0.000000] [<c04d840c>] (ti_clk_register_divider) from [<c08a769=
4>] (ti_clk_register_clk+0x88/0x17c)
>> [    0.000000] [<c08a7694>] (ti_clk_register_clk) from [<c08a77a8>] =
(ti_clk_register_legacy_clks+0x20/0x158)
>> [    0.000000] [<c08a77a8>] (ti_clk_register_legacy_clks) from [<c08=
aa490>] (omap3430_clk_legacy_init+0x10/0x58)
>> [    0.000000] [<c08aa490>] (omap3430_clk_legacy_init) from [<c086f7=
a4>] (omap3_sync32k_timer_init+0x8/0x58)
>> [    0.000000] [<c086f7a4>] (omap3_sync32k_timer_init) from [<c0863a=
ec>] (start_kernel+0x238/0x3e8)
>> [    0.000000] [<c0863aec>] (start_kernel) from [<8000807c>] (0x8000=
807c)
>> [    0.000000] Code: e92d4070 e1a04000 e1a05001 e1a00001 (e594117c)
>> [    0.000000] ---[ end trace cb88537fdc8fa200 ]---
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
