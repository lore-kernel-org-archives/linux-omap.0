From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: OMAP Runtime APIs
Date: Fri, 7 May 2010 17:30:08 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C5387CE0@dbde02.ent.ti.com>
References: <87wrvi2fhf.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35329 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754588Ab0EGMAP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 May 2010 08:00:15 -0400
In-Reply-To: <87wrvi2fhf.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Kevin,

While adapting some drivers to HWMOD way, I tried using pm_runtime APIs. My understanding is that instead of using clock FW APIs or omap_device APIs, we can make use of pm_runtime APIs.

But, I observed that pm_runtime_enable() does not enable the clocks (fck/ick). 

To test this, I used origin/pm-wip/mmc branch. 

In omap_hsmmc_probe() function, I tried printing the values of CM_FCLKEN1_CORE and CM_ICLKEN1_CORE registers before and after pm_runtime_enable(). The values indicated that both before and after pm_runtime_enable(), the MMC clocks (fclk & iclk) are disabled. 

Strangely, I do not find any crash while accessing MMC registers with mmc iclk disabled.

If I use clock FW APIs to enable these clocks (after pm_runtime_enable()) and print these values, I could see those clocks enabled properly and values printed accordingly.

I observed similar behavior with Watchdog and found that access of some watchdog registers end up in crash if I use pm_runtime APIs (as the wdt iclk is not enabled while using pm_runtime_enable()), but works fine if I use clk FW APIS to enable clks.

I am using origin/pm-wip/runtime branch with patches to adapt watchdog to HWMOD FW on top of.

I use "omap3_defconfig" and test on 3430SDP.

On mmc branch I am working on top of the following commit:
commit fe64f0fab492651d7f9296b9d830f2c11844b546
Author: Kevin Hilman <khilman@deeprootsystems.com>
Date:   Wed Jan 20 09:48:52 2010 -0800

    OMAP2/3 MMC: initial conversion to runtime PM


Please clarify.

Thanks,
V Charulatha
