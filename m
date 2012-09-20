From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH V2 0/7] ARM: OMAP2+: Add device-tree support for timers
Date: Thu, 20 Sep 2012 04:23:07 +0200
Message-ID: <505A7E0B.30709@ti.com>
References: <1347579091-3794-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36253 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753084Ab2ITCXW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Sep 2012 22:23:22 -0400
In-Reply-To: <1347579091-3794-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Jon Hunter <jon-hunter@ti.com>, Paul Walmsley <paul@pwsan.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

Hi Tony,

I was about to take the DTS patch, but was wondering if you will pull
the driver changes for 3.7.

Thanks,
Benoit

On 09/14/2012 01:31 AM, Jon Hunter wrote:
> This series adds device-tree support for the timers on OMAP2+ devices
> including AM33xx.
> 
> Testing:
> 1. I have booted linux with this series on OMAP2420 H4, OMAP3430 Beagle and
>    OMAP4430 Panda with/without device-tree present.
> 2. Vaibhav has booted linux on AM335x Beagle bone (thanks!)
> 3. I have tested the all the timers (not used by the kernel as sys-timers) on
>    OMAP2420 H4, OMAP3430 Beagle and OMAP4430 Panda with/without device-tree with
>    this series. The testing includes ...
>    a. Configuring, starting a timer and checking the counter value is
>       incrementing.
>    b. Testing timer overflow interrupt when timer expires.
>    c. Using different clock sources to operate the timer with.
> 4. Verified on OMAP4430 and AM33xx (Vaibhav) that the kernel boots when using a
>    GP timer as clock-source (default for OMAP is 32k-sync timer). Thanks to
>    Vaibhav for catching and tracking down a bug when using a GP-timer as the
>    clock-source!
> 
> V2 changes:
> - Remove use of device-tree alias property
> - Migrate OMAP timers to request timers by property instead of device ID
> - Include OMAP2 support
> 
> Jon Hunter (7):
>   ARM: dts: OMAP: Add timer nodes
>   ARM: OMAP3: Dynamically disable secure timer nodes for secure devices
>   ARM: OMAP4: Add timer clock aliases for device-tree
>   ARM: OMAP: Add a timer attribute for timers that can interrupt the
>     DSP
>   ARM: OMAP: Add function to request a timer by capability
>   ARM: OMAP3: Add generic machine descriptor for boards with OMAP3 GP
>     devices
>   ARM: OMAP: Add DT support for timer driver
> 
>  .../devicetree/bindings/arm/omap/timer.txt         |   30 +++++
>  arch/arm/boot/dts/am33xx.dtsi                      |   61 +++++++++
>  arch/arm/boot/dts/omap2.dtsi                       |   86 +++++++++++++
>  arch/arm/boot/dts/omap2420.dtsi                    |    8 ++
>  arch/arm/boot/dts/omap2430.dtsi                    |    8 ++
>  arch/arm/boot/dts/omap3.dtsi                       |   96 ++++++++++++++
>  arch/arm/boot/dts/omap4.dtsi                       |   86 +++++++++++++
>  arch/arm/mach-omap1/timer.c                        |    2 +-
>  arch/arm/mach-omap2/board-generic.c                |   18 +++
>  arch/arm/mach-omap2/clock44xx_data.c               |   12 ++
>  arch/arm/mach-omap2/common.h                       |    1 +
>  arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |    9 ++
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |   15 ++-
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |   15 ++-
>  arch/arm/mach-omap2/timer.c                        |  131 +++++++++++++++++---
>  arch/arm/plat-omap/dmtimer.c                       |   94 +++++++++++++-
>  arch/arm/plat-omap/include/plat/dmtimer.h          |    2 +
>  17 files changed, 646 insertions(+), 28 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/omap/timer.txt
> 

