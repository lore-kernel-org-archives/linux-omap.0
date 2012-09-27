From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: OMAP baseline test results for v3.6-rc7
Date: Thu, 27 Sep 2012 15:52:29 +0200
Message-ID: <50645A1D.5040108@compulab.co.il>
References: <alpine.DEB.2.00.1209241919130.25811@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:36736 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751411Ab2I0NxI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 27 Sep 2012 09:53:08 -0400
In-Reply-To: <alpine.DEB.2.00.1209241919130.25811@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 09/24/12 21:21, Paul Walmsley wrote:
> 
> Here are some basic OMAP boot and power management test results for 
> v3.6-rc6:
> 
>    http://www.pwsan.com/omap/testlogs/test_v3.6-rc6/20120918101040/
> 
> Some observations:
> 
> Boot tests:
> 
> * CM-T3517: L3 in-band error with IPSS during boot
>   - Cause unknown but see 
> http://marc.info/?l=linux-omap&m=134833869730129&w=2
>   - Longstanding issue; does not occur on the 3517EVM

I'll be able to put some human resources on investigating this
in a couple of weeks hopefully. Currently, it does not affect all
boards (using the same boot loader) and does not look that it interferes
with any functionality later in the boot or runtime.

> 
> * 3517EVM & CM-T3517: boot hangs               
>   - Probably due to the use of NFS root; there are likely some Kconfig,
>     board file, and PM issues with EMAC

Have you tried the nohlt boot parameter?
It looks like the wfi is killing those SoCs once you use EMAC.

> 
> PM tests:
> 
> * 37xx EVM: CORE not entering dynamic off-idle
>   - Cause unknown; dynamic retention-idle seems to work; system suspend to 
>     off works
> 
> * 3730 Beagle XM: does not serial wake from off-idle suspend when console
>   UART doesn't clock gate ("debug ignore_loglevel")
>   - Not shown in the current test logs; cause unknown
> 
> * 4430ES2 Panda: UART corruption during long transmit buffers
>   - Presumably due to either a missing hardware workaround or a bug in
>     the OMAP serial driver
> 
> Other:
> 
> * RCU stall messages appear if boards are booted into a minimal userspace
>   and left to sit for a few minutes
>   - Fixed by http://marc.info/?l=linux-arm-kernel&m=134835120600590&w=2
> 
> 
> Changes from v3.6-rc6 (test 20120918101040):
> (see http://www.pwsan.com/omap/testlogs/test_v3.6-rc6/20120918101040/ )
> 
> - Added comments about RCU stalls, appearing since at least v3.6-rc3
> 
> - Updated CM-T3517 "USB OTG" (really IPSS) comment
> 
> object size (delta in bytes from test_v3.6-rc6 (5698bd757d55b1bb87edd1a9744ab09c142abfc2)):
>   text 	  data 	   bss 	 total 	kernel
>   -328 	   +72 	     0 	  -256 	2430_testconfig
>    -16 	   +16 	     0 	     0 	5912osk_testconfig
>   -376 	   +72 	     0 	  -304 	am33xx_testconfig
>    +64 	   +32 	     0 	   +96 	n800_b_testconfig
>    +80 	   +64 	     0 	  +144 	n800_multi_omap2xxx
>    +80 	   +32 	     0 	  +112 	n800_testconfig
>    +72 	   +80 	     0 	  +152 	omap1510_defconfig
>    +40 	   +16 	     0 	   +56 	omap1_defconfig
>    +80 	   +64 	     0 	  +144 	omap2_4_testconfig
>   -376 	   +40 	     0 	  -336 	omap2plus_defconfig
>   -376 	   +72 	     0 	  -304 	omap2plus_defconfig_cpupm
>    +20 	   +72 	     0 	   +92 	omap2plus_no_pm
>    +20 	    +8 	     0 	   +28 	omap3_4_testconfig
>   +140 	   +72 	     0 	  +212 	omap3_testconfig
>    +20 	   +40 	     0 	   +60 	omap4_testconfig
>    -40 	   +72 	     0 	   +32 	rmk_omap3430_ldp_oldconfig
>   -200 	    +8 	     0 	  -192 	rmk_omap4430_sdp_oldconfig
> 
> 
> 
> - Paul
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
Regards,
Igor.
