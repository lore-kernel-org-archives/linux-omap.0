From: Anca Emanuel <anca.emanuel@gmail.com>
Subject: Re: OMAP baseline test results for v3.9-rc3
Date: Mon, 18 Mar 2013 18:21:24 +0200
Message-ID: <CAJL_dMsA+J6C4uJS_BXGJLvJiS1+YxTaW_j9=EdF70qDnQbwUg@mail.gmail.com>
References: <alpine.DEB.2.00.1303181536230.29332@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:54869 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751250Ab3CRQVZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Mar 2013 12:21:25 -0400
Received: by mail-da0-f46.google.com with SMTP id y19so107863dan.33
        for <linux-omap@vger.kernel.org>; Mon, 18 Mar 2013 09:21:24 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1303181536230.29332@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

You are not planning any resources to solve this ?
You are listing this for a number of months now. It is time to solve them.

On Mon, Mar 18, 2013 at 5:38 PM, Paul Walmsley <paul@pwsan.com> wrote:
>
> Here are some basic OMAP test results for Linux v3.9-rc3.
> Logs and other details at:
>
>     http://www.pwsan.com/omap/testlogs/test_v3.9-rc3/20130314094808/
>
>
> Test summary
> ------------
>
> Build:
>     FAIL ( 3/16): am33xx_only, omap1_defconfig_5912osk_only,
>                   omap2plus_defconfig_2430sdp_only
>     Pass (13/16): n800_multi_omap2xxx, n800_only_a, omap1_defconfig,
>                   omap1_defconfig_1510innovator_only,
>                   omap2plus_defconfig, omap2plus_defconfig_cpupm,
>                   omap2plus_defconfig_no_pm,
>                   omap2plus_defconfig_omap2_4_only,
>                   omap2plus_defconfig_omap3_4_only,
>                   rmk_omap3430_ldp_allnoconfig,
>                   rmk_omap3430_ldp_oldconfig,
>                   rmk_omap4430_sdp_allnoconfig
>                   rmk_omap4430_sdp_oldconfig
>
> Boot to userspace:
>     FAIL ( 1/11): am335xbone
>     Pass (10/11): 2420n800, 2430sdp, 3517evm, 3530es3beagle,
>                   3730beaglexm, 37xxevm, 4430es2panda, 4460pandaes,
>                   5912osk, cmt3517
>
> PM ret, suspend:
>     FAIL ( 4/ 6): 2430sdp, 37xxevm, 4430es2panda, 4460pandaes
>     Pass ( 2/ 6): 3530es3beagle, 3730beaglexm
>
> PM ret, dynamic idle:
>     FAIL ( 4/ 6): 2430sdp, 37xxevm, 4430es2panda, 4460pandaes
>     Pass ( 2/ 6): 3530es3beagle, 3730beaglexm
>
> PM off, suspend:
>     FAIL ( 3/ 5): 37xxevm, 4430es2panda, 4460pandaes
>     Pass ( 2/ 5): 3530es3beagle, 3730beaglexm
>
> PM off, dynamic idle:
>     FAIL ( 3/ 5): 37xxevm, 4430es2panda, 4460pandaes
>     Pass ( 2/ 5): 3530es3beagle, 3730beaglexm
>
>
> Failing tests: fixed by posted patches
> --------------------------------------
>
> Build:
>
> * omap1_defconfig_5912osk_only: implicit declaration of function 'cpu_is_omap15xx'
>   - Fixed by Aaro: http://www.spinics.net/lists/linux-omap/msg87523.html
>
> PM:
>
> * 4460pandaes: CORE, L3INIT didn't enter target state
>   - Caused by 17b7e7d33530e2bbd3bdc90f4db09b91cfdde2bb
>     (ARM: OMAP4: clock/hwmod data: start to remove some IP block control
>      "clocks")
>   - Fixed by "ARM: OMAP4: PM: fix PM regression introduced by recent clock
>     cleanup"
>     - http://www.spinics.net/lists/arm-kernel/msg224419.html
>
> Failing tests: needing investigation
> ------------------------------------
>
> Build:
>
> * am33xx_only, omap2plus_defconfig_2430sdp_only: omap-{smp,hotplug}.c link errors
>
> Boot tests:
>
> * 3517EVM & CM-T3517: boot hangs with NFS root
>   - Likely some Kconfig, board file, and PM issues with EMAC
>   - Longstanding bug
>
> Boot warnings:
>
> * 2430sdp & 37xxevm: nasty lock warning due to NFS root
>   - Cause unknown
>   - Breaks most remaining tests
>
> * CM-T3517: L3 in-band error with IPSS during boot
>   - Cause unknown but see http://marc.info/?l=linux-omap&m=134833869730129&w=2
>   - Longstanding issue; does not occur on the 3517EVM
>
> PM tests:
>
> * 2430sdp: pwrdm state mismatch(dsp_pwrdm) 0 != 3
>   - need to doublecheck wakeup dependencies
>   - (am assuming it's still there; userspace problems prevent the test
>      from running, probably due to the lock warning)
>
> * 2430sdp: power domains not entering retention
>   - Cause unknown
>   - (am assuming it's still there; userspace problems prevent the test
>      from running, probably due to the lock warning)
>
> * 4430es2panda, 4460pandaes: pwrdm state mismatch on CAM, DSS, ABE
>
> * 4460pandaes: pwrdm state mismatch on IVAHD, TESLA
>
> * 4430es2panda: CORE, TESLA, IVAHD, L3INIT didn't enter target state
>   - Probably due to lack of reset code for M3, DSP, SL2IF, FSUSB
>     per discussion with Tero Kristo
>   - Likely dependent on the bootloader version
>     - fails with 2012.07-00136-g755de79
>
> * 4460pandaes: chip not entering retention in dynamic idle
>   - Presumably 4430es2panda also fails this
>   - Suspend-to-RAM enters full chip retention
>
> * 3730 Beagle XM: does not serial wake from off-idle suspend when console
>   UART doesn't clock-gate ("debug ignore_loglevel")
>   - Cause unknown
>   - Not yet part of the automated test suite
>   - Re-tested at v3.7; still failing:
>     http://www.pwsan.com/omap/transcripts/20121211-3730beaglexm-3.7-pm-offmode-fail-debug.txt
>
> Other:
>
> * 4430es2panda: omap_hwmod: l3_instr: _wait_target_disable failed
>   - Unknown cause; could be due to the lack of hierarchical enable/disable
>     in hwmod code
>   - Jon Hunter reports this does not appear with the same X-loader/bootloader
>     on his 4430ES2.3 Panda, so could be ES-level dependent
>
>
> vmlinux object size
> (delta in bytes from test_v3.9-rc2
> (f6161aa153581da4a3867a2d1a7caf4be19b6ec9)):
>    text     data      bss    total  kernel
>     +72      -64        0       +8  n800_multi_omap2xxx
>     +56      -64        0       -8  n800_only_a
> +5606576  +359420  +121728  +6087724  omap1_defconfig
>    +108    +2592        0    +2700  omap1_defconfig_1510innovator_only
>    +640    +2568        0    +3208  omap2plus_defconfig
>    +704    +2560        0    +3264  omap2plus_defconfig_cpupm
>    +704    +2560        0    +3264  omap2plus_defconfig_no_pm
>    +640    +2560        0    +3200  omap2plus_defconfig_omap2_4_only
>    +628    +2576        0    +3204  omap2plus_defconfig_omap3_4_only
>  -20852     -460    +1732   -19580  rmk_omap3430_ldp_allnoconfig
>   +4352      -64        0    +4288  rmk_omap3430_ldp_oldconfig
>  -20740     -460    +1620   -19580  rmk_omap4430_sdp_allnoconfig
>    +168       -8        0     +160  rmk_omap4430_sdp_oldconfig
>
> omap1_defconfig is building again.
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
