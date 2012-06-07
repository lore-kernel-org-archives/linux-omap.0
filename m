From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH V2 00/10] ARM: OMAP4: Add PMU Support
Date: Thu, 7 Jun 2012 18:36:06 -0500
Message-ID: <4FD13AE6.6070206@ti.com>
References: <1339104132-26885-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35427 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757927Ab2FGXgK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 Jun 2012 19:36:10 -0400
In-Reply-To: <1339104132-26885-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Ming Lei <ming.lei@canonical.com>, Will Deacon <will.deacon@arm.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>


On 06/07/2012 04:22 PM, Jon Hunter wrote:
> This series adds PMU support for OMAP4 devices. This is based upon Will Deacons
> series [1]. This series fixes the management of the EMU power domain so that
> PMU can be enabled at runtime and low-power states are not prevented when PMU
> is not in-use. The fix is based upon inputs from Benoit, Paul and Kevin [2].
> 
> This series also converts OMAP2/3 devices to use HWMOD to create the PMU device
> and add a new file to mach-omap2 directory called pmu.c where the PMU devices
> are created.
> 
> This series is based upon the latest linux-omap master branch from Tony
> (3.5-rc1).
> 
> Testing:
> - Verified that PMU is working on OMAP3430 Beagle Board, OMAP4430 Blaze and
>   4460 Panda.
> - Tested on the above boards with CPU-idle enabled to ensure that PMU is working
>   with power management. For OMAP4 boards I have disabled CPU1 so that CPU0 and
>   hence the MPU power domain is reaching the low-power retention state.
> - I have booted the kernel on an OMAP2430 SDP but not verified PMU is working.
> - Unable to verify 4470 Blaze because kernel is not currently booting.

Update on the 4470 status. Now I have 4470 booting [1], I have now
verified that PMU on 4470 is also working with this series (and with
CPU-idle enabled).

Cheers
Jon

[1] http://marc.info/?l=linux-omap&m=133911023112941&w=2
