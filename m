From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH v5 00/11] ARM: OMAP2+: AM43x PRCM basic support
Date: Fri, 4 Oct 2013 12:12:14 +0530
Message-ID: <524E6346.2080208@ti.com>
References: <cover.1380608719.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36215 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751178Ab3JDGmn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 4 Oct 2013 02:42:43 -0400
In-Reply-To: <cover.1380608719.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Afzal Mohammed <afzal@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>

On Tuesday 01 October 2013 12:34 PM, Afzal Mohammed wrote:
> Hi Paul, Benoit, Tony,
> 
> This series adds PRCM support (except clock tree) for AM43x SoC's.
> Please consider this for inclusion in the coming merge window.
> 
> Patch 02/11 "ARM: OMAP2+: hwmod: AM335x/AM43x: move common data" may
> not reach mailing lists due to bigger size, this series is also present
> @git://gitorious.org/x0148406-public/linux-kernel.git tags/am43x-prcm-v5
> 
> Compared to v4, only change is in fixing the powerdomain data.
> 
> Major changes compared to rfc v3:
> 1. All register offsets properly taken care for AM43x (with rfc v3, a
>    couple of issues was detected while testing on pre-silicon)
> 2. There were two patches for common hwmod data movement (one for
>    interconnect and other for ip block data), both were combined to have
>    a cleaner series that is bisectable.
> 3. Cleaner seperation of common data
> 
> Major changes compared to v2 (v3 was only an rfc for current approach):
> 1. omap_hwmod_33xx_43xx_interconnect_data.c has the common interconnect
>    ocp's structs shared between AM335x and AM43x
> 2. omap_hwmod_33xx_43xx_ipblock_data.c has the common hwmod structs
>    shared between AM335x and AM43x

This split and reuse looks much better and readable now.

For the complete series,
Acked-by: Rajendra Nayak <rnayak@ti.com>

> 3. Instances where clock domain or clock topology has changed in the few
>    cases, have separate structures for AM335x and AM43x
> 4. To handle scenarios where register offsets are different, they are
>    dynamically init-ed in omap_hwmod_33xx_43xx_ipblock_data.c
> 5. Register offsets for hwmod's that are present either in AM335x or
>    AM43x are updated statically in omap_hwmod_33xx_data.c or
>    omap_hwmod_43xx_data.c as that was cleaner.
> 6. Remove the change that re-introduces SW_SLEEP for OMAP4, this will
>    be taken care separately.
> 
> This series has been boot tested on pre-silicon platform with the help
> of Tero's DT clock tree conversion series. This series has been tested
> on AM335x-EVM too.
> 
> Additional details:
> AM43x reuses most of the IP's from AM335x, as that is the case, much of
> the AM335x hwmod data is reused. As AM43x PRCM register layout differs
> from AM335x and is similar to OMAP4, power domain, clock domain & hwmod
> operations are reused from OMAP4. Currently there is no public TRM
> available for AM43x.
> 
> Changes based on: v3.12-rc2
> 
> Regards
> Afzal
> 
> 
> Afzal Mohammed (7):
>   ARM: OMAP2+: hwmod: AM335x/AM43x: move common data
>   ARM: OMAP2+: hwmod: AM335x: runtime register update
>   ARM: OMAP2+: hwmod: AM335x: remove static register offs
>   ARM: OMAP2+: PRCM: AM43x definitions
>   ARM: OMAP2+: hwmod: AM43x support
>   ARM: OMAP2+: hwmod: AM43x operations
>   ARM: OMAP2+: AM43x: PRCM kbuild
> 
> Ambresh K (3):
>   ARM: OMAP2+: PM: AM43x powerdomain data
>   ARM: OMAP2+: CM: AM43x clockdomain data
>   ARM: OMAP2+: AM43x PRCM init
> 
> Ankur Kishore (1):
>   ARM: OMAP2+: CM: cm_inst offset s16->u16
> 
>  arch/arm/mach-omap2/Makefile                       |    9 +-
>  arch/arm/mach-omap2/clockdomain.h                  |    4 +-
>  arch/arm/mach-omap2/clockdomains43xx_data.c        |  196 ++
>  arch/arm/mach-omap2/cm33xx.c                       |   16 +-
>  arch/arm/mach-omap2/cm33xx.h                       |   12 +-
>  arch/arm/mach-omap2/cminst44xx.c                   |   29 +-
>  arch/arm/mach-omap2/cminst44xx.h                   |   26 +-
>  arch/arm/mach-omap2/io.c                           |    6 +
>  arch/arm/mach-omap2/omap_hwmod.c                   |    8 +
>  arch/arm/mach-omap2/omap_hwmod.h                   |    1 +
>  .../mach-omap2/omap_hwmod_33xx_43xx_common_data.h  |  163 ++
>  .../omap_hwmod_33xx_43xx_interconnect_data.c       |  643 +++++++
>  .../mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c | 1456 +++++++++++++++
>  arch/arm/mach-omap2/omap_hwmod_33xx_data.c         | 1966 +-------------------
>  arch/arm/mach-omap2/omap_hwmod_43xx_data.c         |  622 +++++++
>  arch/arm/mach-omap2/powerdomain.h                  |    1 +
>  arch/arm/mach-omap2/powerdomains43xx_data.c        |  136 ++
>  arch/arm/mach-omap2/prcm43xx.h                     |  141 ++
>  18 files changed, 3432 insertions(+), 2003 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/clockdomains43xx_data.c
>  create mode 100644 arch/arm/mach-omap2/omap_hwmod_33xx_43xx_common_data.h
>  create mode 100644 arch/arm/mach-omap2/omap_hwmod_33xx_43xx_interconnect_data.c
>  create mode 100644 arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
>  create mode 100644 arch/arm/mach-omap2/omap_hwmod_43xx_data.c
>  create mode 100644 arch/arm/mach-omap2/powerdomains43xx_data.c
>  create mode 100644 arch/arm/mach-omap2/prcm43xx.h
> 

