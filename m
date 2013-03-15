From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH V2 0/8] ARM: dts: Various OMAP2+ device-tree updates
Date: Fri, 15 Mar 2013 15:30:44 +0100
Message-ID: <51433094.1000104@ti.com>
References: <1363355861-11773-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47543 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755132Ab3COObE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Mar 2013 10:31:04 -0400
In-Reply-To: <1363355861-11773-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

Hi Jon,

On 03/15/2013 02:57 PM, Jon Hunter wrote:
> Various OMAP device-tree updates for PMU, DMA, GPIO, GPMC and boards.
> 
> The DMA, PMU and OMAP3430 SDP board changes have been sent before
> individually but re-sending here as a complete series for v3.10.
> 
> This is based upon Benoit's for_3.10/dts branch [1]. Branch available
> here [2].
> 
> V2 changes:
> - Rebased on Benoit's for_3.10/dts branch
> - Squashed patches adding support for OMAP3430 SDP board and patch
>   to add flash support for OMAP3430 SDP board.
> 
> [1] http://git.kernel.org/cgit/linux/kernel/git/bcousson/linux-omap-dt.git/log/?h=for_3.10/dts
> [2] git://github.com/jonhunter/linux.git omap-dt-for-v3.10

Thanks for the repost. I've just applied your branch in my for_3.10/dts
branch.

Regards,
Benoit


> Jon Hunter (8):
>   ARM: OMAP2+: Prepare for device-tree PMU support
>   ARM: dts: OMAP2+: Add PMU nodes
>   ARM: dts: OMAP2+: Add SDMA controller bindings and nodes
>   ARM: dts: Add GPMC node for OMAP2, OMAP4 and OMAP5
>   ARM: dts: Add OMAP2 gpio bindings
>   ARM: dts: OMAP3+: Correct gpio #interrupts-cells property
>   ARM: dts: OMAP3: Add reg and interrupt properties for gpio
>   ARM: dts: OMAP3: Add support for OMAP3430 SDP board
> 
>  arch/arm/boot/dts/Makefile           |    1 +
>  arch/arm/boot/dts/omap2.dtsi         |   17 ++++
>  arch/arm/boot/dts/omap2420.dtsi      |   55 +++++++++++++
>  arch/arm/boot/dts/omap2430.dtsi      |   66 ++++++++++++++++
>  arch/arm/boot/dts/omap3.dtsi         |   70 +++++++++++++++--
>  arch/arm/boot/dts/omap3430-sdp.dts   |  141 ++++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/omap4-panda-es.dts |    2 +
>  arch/arm/boot/dts/omap4.dtsi         |   64 +++++++++++++--
>  arch/arm/boot/dts/omap4460.dtsi      |   18 +++++
>  arch/arm/boot/dts/omap5.dtsi         |   68 ++++++++++++++--
>  arch/arm/mach-omap2/pmu.c            |   14 +++-
>  11 files changed, 493 insertions(+), 23 deletions(-)
>  create mode 100644 arch/arm/boot/dts/omap3430-sdp.dts
>  create mode 100644 arch/arm/boot/dts/omap4460.dtsi
> 

