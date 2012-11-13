From: Igor Mazanov <i.mazanov@gmail.com>
Subject: Re: OMAP baseline test results for v3.7-rc5
Date: Tue, 13 Nov 2012 20:04:08 +0400
Message-ID: <50A26F78.7070602@gmail.com>
References: <alpine.DEB.2.00.1211121921160.12551@utopia.booyaka.com>
Reply-To: i.mazanov@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:49650 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751576Ab2KMQE4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Nov 2012 11:04:56 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gplao-linux-omap-open-source-moved1@m.gmane.org>)
	id 1TYIz2-0004tx-EO
	for linux-omap@vger.kernel.org; Tue, 13 Nov 2012 17:05:04 +0100
Received: from 77.232.56.122 ([77.232.56.122])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Tue, 13 Nov 2012 17:05:04 +0100
Received: from i.mazanov by 77.232.56.122 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Tue, 13 Nov 2012 17:05:04 +0100
In-Reply-To: <alpine.DEB.2.00.1211121921160.12551@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Paul Walmsley wrote:
> Here are some basic OMAP test results for Linux v3.7-rc5.
> Logs and other details at:
> 
>     http://www.pwsan.com/omap/testlogs/test_v3.7-rc5/20121111081034/
> 
> 
> Passing tests
> -------------
> 
> Boot to userspace (9/11): 2420n800, 2430sdp, 3517evm, 3530es3beagle,
>     3730beaglexm, 37xxevm, 4430es2panda, 5912osk, am335xbone
>   
> PM ret/off, suspend + dynamic idle (2/4): 3730beaglexm, 37xxevm
> 
> 
> Failing tests: fixed by posted patches
> --------------------------------------
> 
> Boot tests:
> 
> * 3530ES3 Beagle: I2C timeouts during userspace init
>   - Intermittent, appears on 5 out of 6 boots here
>   - Aaro Koskinen observes this also on N900
>   - Appears to be caused by commit 3db11feffc1ad2ab9dea27789e6b5b3032827adc
>     - http://marc.info/?l=linux-arm-kernel&m=135071372426971&w=2
>     - http://marc.info/?l=linux-omap&m=135197877112220&w=2
>   - Revert posted, pending I2C maintainers:
>     - http://marc.info/?l=linux-arm-kernel&m=135221953727077&w=2
> 
> PM tests:
> 
> * 3530es3beagle: hangs during off-mode dynamic idle test
>   - Appears to be caused by commit 6c31b2150ff96755d24e0ab6d6fea08a7bf5c44c:
>     - http://marc.info/?l=linux-omap&m=135075364705188&w=2
>   - Fixed by http://www.spinics.net/lists/arm-kernel/msg202116.html
>  
> Other:
> 
> * 2420N800: powers down 30 seconds after boot
>   - Presumably due to missing CBUS patches for watchdog control
>   - http://lkml.org/lkml/2012/9/3/265
> 
> * 4430es2panda: omap_hwmod: mcpdm: cannot be enabled for reset (3)
>   - clock source is from an external I2C-controlled source
>   - must skip reset until the switchover to hwmod late init
>   - http://www.spinics.net/lists/arm-kernel/msg178138.html
> 
> 
> Failing tests: needing investigation
> ------------------------------------
> 
> Boot tests:
> 
> * CM-T3517: L3 in-band error with IPSS during boot
>   - Cause unknown but see http://marc.info/?l=linux-omap&m=134833869730129&w=2
>   - Longstanding issue; does not occur on the 3517EVM
> 
> * 3517EVM & CM-T3517: boot hangs with NFS root
>   - Likely some Kconfig, board file, and PM issues with EMAC
> 
> * CM-T3517: boot hangs with MMC boot
>   - Due to missing MMC setup in board file
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
> Failing tests: needing local investigation (may be due to testbed issues)
> -------------------------------------------------------------------------
> 
> Boot tests:
> 
> * AM335x Beaglebone: omap2plus_defconfig kernels don't boot
>   - May be fixed now, pending retest:
>     - http://marc.info/?l=linux-omap&m=135082257727502&w=2
>   - Not yet part of the automated test suite
>   * May be due to an old U-boot with FDT support problems used here?
>     Pending local investigation and re-test

I have the same result with omap2plus_defconfig and kernel 3.7.0-rc5. I dumped
the kernel log buffer via JTAG and can send this log if it could be useful.

> 
> * 4460pandaes: boot fails early
>   - Appears to be due to X-loader problems here
>   - Need to note the X-loader version so we know it's broken
> 
> PM tests:
> 
> * 3730 Beagle XM: does not serial wake from off-idle suspend when console
>   UART doesn't clock gate ("debug ignore_loglevel")
>   - Not shown in the current test logs; cause unknown
>   - Pending re-test
> 
> 
> vmlinux object size
> (delta in bytes from test_v3.7-rc4 (3d70f8c617a436c7146ecb81df2265b4626dfe89)):
>    text     data      bss    total  kernel
>    +500       -8        0     +492  am33xx_only
>    +456      +16        0     +472  n800_multi_omap2xxx
>    +424      +16        0     +440  n800_only_a
>    +164        0        0     +164  omap1_defconfig
>    +164        0        0     +164  omap1_defconfig_1510innovator_only
>    +164        0        0     +164  omap1_defconfig_5912osk_only
>    +940       -8        0     +932  omap2plus_defconfig
>    +796       -8        0     +788  omap2plus_defconfig_2430sdp_only
>    +940      +24        0     +964  omap2plus_defconfig_cpupm
>    +940       -8        0     +932  omap2plus_defconfig_no_pm
>    +940      +16        0     +956  omap2plus_defconfig_omap2_4_only
>    +820      +16        0     +836  omap2plus_defconfig_omap3_4_only
>     +20       +8      +48      +76  rmk_omap3430_ldp_allnoconfig
>    +124        0        0     +124  rmk_omap3430_ldp_oldconfig
>     +20       +8      +48      +76  rmk_omap4430_sdp_allnoconfig
>    +124       +8        0     +132  rmk_omap4430_sdp_oldconfig
> 
> 
> - Paul
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 



