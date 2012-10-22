From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: OMAP baseline test results for v3.7-rc2
Date: Mon, 22 Oct 2012 11:28:52 -0500
Message-ID: <50857444.9080308@ti.com>
References: <alpine.DEB.2.00.1210202125300.774@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47705 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751820Ab2JVQ24 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Oct 2012 12:28:56 -0400
In-Reply-To: <alpine.DEB.2.00.1210202125300.774@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Paul,

On 10/20/2012 04:26 PM, Paul Walmsley wrote:
> 
> Here are some basic OMAP test results for Linux v3.7-rc2.
> Logs and other details at:
> 
>     http://www.pwsan.com/omap/testlogs/test_v3.7-rc2/20121020134755/
> 
> 
> Passing tests
> -------------
> 
> Boot to userspace: 3517evm, 3530es3beagle, 3730beaglexm, 37xxevm,
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
> 
> * 2420n800: boot hangs during UART initialization
>   - http://lkml.org/lkml/2012/9/11/454
>   - Apparently fixed by http://marc.info/?l=linux-omap&m=135068547918479&w=2
> 
> * AM335x Beaglebone: omap2plus_defconfig kernels don't boot
>   - due to a GPMC bug
>   - Apparently fixed by http://www.spinics.net/lists/arm-kernel/msg200787.html

This is now addressed and I have verified it is booting on v3.7-rc2. The
following patch address this boot problem ...

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=8119024ef7363591fd958ec89ebfaee7c18209e3

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
>   - Appears to be timer-related

I tried v3.7-rc2 on my pandaES and it is booting fine for me.

I have an OMAP4460 ES1.1 and u-boot release 2012.10.

I don't wish to create more work for you, but it could be good to add
silicon revision, u-boot release (if applicable) and toolchain used for
any failures.

Cheers
Jon
