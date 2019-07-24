From: Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH 0/8] ti-sysc related warning fixes for v5.3-rc cycle
Date: Wed, 24 Jul 2019 11:22:15 +0530
Message-ID: <84de9487-761f-2f66-0227-97615e240477@ti.com>
References: <20190723112811.44381-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190723112811.44381-1-tony@atomide.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: Dave Gerlach <d-gerlach@ti.com>, Faiz Abbas <faiz_abbas@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nishanth Menon <nm@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Roger Quadros <rogerq@ti.com>, Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org



On 23/07/19 4:58 PM, Tony Lindgren wrote:
> Hi all,
> 
> I noticed that with recent ti-sysc driver changes some new warnings
> have crept in. Mostly they are caused by having different configuration
> in the dts compared to the legacy platform data. Let's fix these first
> before we continue dropping the legacy platform data.
> 
> I also noticed we need two fixes for the ti-sysc driver while looking
> at the warnings.

Tony,

Apart from Patch 2(breaks DS0 on AM3). Rest all work fine.

Tested for DS0/RTC+ddr on AM4, DS0 on AM3 Boneblack.

You can add my:

Tested-by: Keerthy <j-keerthy@ti.com>

For all the 7 patches except Patch 2.

Regards,
Keerthy

> 
> Regards,
> 
> Tony
> 
> Tony Lindgren (8):
>    ARM: OMAP2+: Fix missing SYSC_HAS_RESET_STATUS for dra7 epwmss
>    ARM: OMAP2+: Remove unconfigured midlemode for am3 lcdc
>    bus: ti-sysc: Fix handling of forced idle
>    bus: ti-sysc: Fix using configured sysc mask value
>    ARM: dts: Drop bogus ahclkr clocks for dra7 mcasp 3 to 8
>    ARM: dts: Fix flags for gpio7
>    ARM: dts: Fix incorrect dcan register mapping for am3, am4 and dra7
>    ARM: dts: Fix lcdc sysc flags for am3
> 
>   arch/arm/boot/dts/am33xx-l4.dtsi              |  6 +++-
>   arch/arm/boot/dts/am437x-l4.dtsi              |  4 +++
>   .../boot/dts/am57xx-beagle-x15-common.dtsi    |  2 +-
>   arch/arm/boot/dts/dra7-evm.dts                |  2 +-
>   arch/arm/boot/dts/dra7-l4.dtsi                | 31 ++++++++-----------
>   arch/arm/mach-omap2/omap_hwmod_33xx_data.c    |  2 +-
>   arch/arm/mach-omap2/omap_hwmod_7xx_data.c     |  3 +-
>   drivers/bus/ti-sysc.c                         | 10 +++---
>   8 files changed, 31 insertions(+), 29 deletions(-)
> 
