From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP baseline test results for v3.7-rc1
Date: Fri, 19 Oct 2012 16:55:38 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1210191645390.10773@utopia.booyaka.com>
References: <alpine.DEB.2.00.1210180517450.8674@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:52183 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751194Ab2JSQzj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Oct 2012 12:55:39 -0400
In-Reply-To: <alpine.DEB.2.00.1210180517450.8674@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, 18 Oct 2012, Paul Walmsley wrote:

> Here are some basic OMAP test results for Linux v3.7-rc1.
> Logs and other details at http://www.pwsan.com/omap/testlogs/test_v3.7-rc1/

And here's two more.

> Failing tests: needing investigation
> ------------------------------------
> 
>
> Boot tests:
>
> * 2420n800: boot hangs during UART initialization
>  - http://lkml.org/lkml/2012/9/11/454
>  - Various attempts at fixes posted; etiology known; issue still unresolved
>
> * CM-T3517: L3 in-band error with IPSS during boot
>  - Cause unknown but see http://marc.info/?l=linux-omap&m=134833869730129&w=2
>  - Longstanding issue; does not occur on the 3517EVM
>
> * 3517EVM & CM-T3517: boot hangs with NFS root
>  - Likely some Kconfig, board file, and PM issues with EMAC
>
> * CM-T3517: boot hangs with MMC boot
>  - Due to missing MMC setup in board file

* 3530ES3 Beagle: I2C timeouts during userspace init
  - May be related to the threaded IRQ conversion of the I2C driver
  - Unknown cause

> PM tests:
> 
> * 3530es3beagle, 37xxevm, 3730beaglexm: I2C fails during resume from suspend
>   - Causes MMC to become unusable since regulators are not reenabled
>   - Can be worked around by reverting the I2C driver conversion to
>     threaded IRQs:
>     - http://marc.info/?l=linux-i2c&m=135026587102887&w=2
>   - Appears to be due to an accounting problem; under discussion:
>     - http://marc.info/?l=linux-arm-kernel&m=135042360725821&w=2
> 
> * 3530es3beagle: hangs during off-mode dynamic idle test
>   - Unknown cause; not investigated
> 
> * 37xx EVM: CORE not entering dynamic off-idle
>   - Cause unknown; dynamic retention-idle seems to work; system suspend to 
>     off works
> 
> * 3730 Beagle XM: does not serial wake from off-idle suspend when console
>   UART doesn't clock gate ("debug ignore_loglevel")
>   - Not shown in the current test logs; cause unknown

* 3730 Beagle XM: OPPs do not initialize
  - Several "find_device_opp: Invalid parameters" messages appear on boot; 
    related warnings follow
  - Cause unknown


- Paul
