From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: OMAP baseline test results for v3.7-rc4
Date: Wed, 7 Nov 2012 11:14:02 -0600
Message-ID: <509A96DA.2010003@ti.com>
References: <alpine.DEB.2.00.1211050241410.23228@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58173 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751748Ab2KGROH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 7 Nov 2012 12:14:07 -0500
In-Reply-To: <alpine.DEB.2.00.1211050241410.23228@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org


On 11/04/2012 08:46 PM, Paul Walmsley wrote:
> 
> Here are some basic OMAP test results for Linux v3.7-rc4.
> Logs and other details at:
> 
>     http://www.pwsan.com/omap/testlogs/test_v3.7-rc4/20121104142910/
> 
> 
> Passing tests
> -------------
> 
> Boot to userspace: 2420n800, 3517evm, 3530es3beagle, 3730beaglexm, 37xxevm,
>                    4430es2panda, 5912osk, am335xbone
> 
> PM ret/off, suspend + dynamic idle: (none)
> 
> 
> Failing tests: fixed by posted patches
> --------------------------------------
> 
> Boot tests:
> 
> * 2430sdp: vfp_reload_hw oops during MMC initialization
>   - Kernel attempts to save FP registers that don't exist; fix posted:
>     - http://www.spinics.net/lists/arm-kernel/msg200646.html
>     - added to rmk's patch system as 7566/1
> 
> * AM335x Beaglebone: omap2plus_defconfig kernels don't boot
>   - Due to GPMC missing support for DT
>   - Temporary workaround at 
> http://www.spinics.net/lists/arm-kernel/msg200787.html
>   - May be fixed now, pending retest:
>     - http://marc.info/?l=linux-omap&m=135082257727502&w=2
>   - Not yet part of the automated test suite
>   * May be due to an old U-boot with FDT support problems?
> 
> PM tests:
> 
> * 3530es3beagle, 37xxevm, 3730beaglexm: I2C fails during resume from suspend
>   - Causes MMC to become unusable since regulators are not reenabled
>   - Caused by RT throttling
>   - Fixed by http://www.spinics.net/lists/arm-kernel/msg202224.html
>   - Patch in rmk's patch system as 7565/1
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
> * 4460pandaes: boot fails early
>   - Appears to be due to X-loader problems here
>   - Need to note the X-loader version so we know it's broken

Are you still planning to investigate this further or migrate to a new
bootloader?

With 4460 and 3.7-rc4, I am seeing that resume from suspend is not
working (not sure when this broke though). I am just curious if anyone
else sees this. My u-boot version is v2012.10.

Cheers
Jon
