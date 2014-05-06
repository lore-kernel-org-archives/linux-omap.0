From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH v4 0/5] ARM: DRA7: Add support for DRA72x devices
Date: Tue, 6 May 2014 11:15:29 +0530
Message-ID: <536876F9.7000707@ti.com>
References: <1398769513-8736-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34316 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751992AbaEFFrd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 May 2014 01:47:33 -0400
In-Reply-To: <1398769513-8736-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, tony@atomide.com, bcousson@baylibre.com, nm@ti.com, arnd@arndb.de, s-anna@ti.com

On Tuesday 29 April 2014 04:35 PM, Rajendra Nayak wrote:
> changes in v4:
> -1- used full SoC names in compatibles eg "ti,dra742" and "ti,dra722"
> -2- Created a seperate patch for replacing __initdata with __initconst
> 
> changes in v3:
> Removed wildcards from compatible strings and duplicates from
> .dt_compat strings as suggested by Arnd
> 
> DRA72x devices are single core Cortex A15 devices belonging to the
> DRA7 family (Similar to the DRA74x devices which are dual core Cortex
> A15 based)
> 
> The patches (based off 3.15-rc3) add minimal DT/kernel modifications to add
> boot support on DRA722 device reusing all the kernel data for DRA742 device.

Tony, Can this series be pulled in for 3.16? Patch 2/5 and 4/5 are acked by Arnd.
Patch 5/5 can be dropped since there are no users for soc_is_dra7**() at the moment.

> 
> Rajendra Nayak (5):
>   ARM: dts: dra7-evm: Remove the wrong and undocumented compatible
>   ARM: dts: Add support for DRA72x family of devices
>   ARM: OMAP2+: Replace all __initdata with __initconst for const init
>   ARM: OMAP2+: Add machine entry for dra72x devices
>   ARM: DRA7: Add support for soc_is_dra74x() and soc_is_dra72x()
>     varients
> 
>  .../devicetree/bindings/arm/omap/omap.txt          |   12 ++++--
>  arch/arm/boot/dts/Makefile                         |    3 +-
>  arch/arm/boot/dts/dra7-evm.dts                     |    6 +--
>  arch/arm/boot/dts/dra7.dtsi                        |   27 ------------
>  arch/arm/boot/dts/dra72-evm.dts                    |   24 +++++++++++
>  arch/arm/boot/dts/dra72x.dtsi                      |   25 +++++++++++
>  arch/arm/boot/dts/dra74x.dtsi                      |   41 ++++++++++++++++++
>  arch/arm/mach-omap2/board-generic.c                |   45 ++++++++++++++------
>  arch/arm/mach-omap2/soc.h                          |    7 +++
>  9 files changed, 142 insertions(+), 48 deletions(-)
>  create mode 100644 arch/arm/boot/dts/dra72-evm.dts
>  create mode 100644 arch/arm/boot/dts/dra72x.dtsi
>  create mode 100644 arch/arm/boot/dts/dra74x.dtsi
> 

