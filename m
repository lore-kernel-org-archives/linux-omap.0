From: Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCHv2 00/13] ti-sysc driver changes to drop custom hwmods
 property
Date: Tue, 28 May 2019 13:32:00 +0530
Message-ID: <0ba540b0-ad04-ee56-5874-69921eb4f374@ti.com>
References: <20190528062414.27192-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190528062414.27192-1-tony@atomide.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: Nishanth Menon <nm@ti.com>, Tero Kristo <t-kristo@ti.com>, Dave Gerlach <d-gerlach@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>, devicetree@vger.kernel.org, Faiz Abbas <faiz_abbas@ti.com>, Suman Anna <s-anna@ti.com>, Rob Herring <robh@kernel.org>, linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org



On 28/05/19 11:54 AM, Tony Lindgren wrote:
> Hi all,
> 
> Here are changes to improve ti-sysc driver to the point where we can
> finally drop the custom hwmods property for most cases. This series
> drops hwmods property only for omap4 UART and MMC as those can be
> tested with core retention idle.
> 
> I'll be posting more patches for dropping hwmods properties as they
> get tested.


Added missing dra71/76 patches on linux-next which get them to boot.

Tested for boot on dra71/76.
Tested for DS0 on AM43/33.
Tested for RTC+DDR mode on am43.

For the series:

Tested-by: Keerthy <j-keerthy@ti.com>

> 
> Regards,
> 
> Tony
> 
> Changes since v1:
> 
> - Repost the series against v5.2-rc1 as the first patch in the series
>    got accidentally left out for patch "bus: ti-sysc: Add support for
>    missing clockdomain handling"
> 
> 
> Tony Lindgren (13):
>    bus: ti-sysc: Add support for missing clockdomain handling
>    bus: ti-sysc: Support 16-bit writes too
>    bus: ti-sysc: Make OCP reset work for sysstatus and sysconfig reset
>      bits
>    bus: ti-sysc: Allow QUIRK_LEGACY_IDLE even if legacy_mode is not set
>    bus: ti-sysc: Enable interconnect target module autoidle bit on enable
>    bus: ti-sysc: Handle clockactivity for enable and disable
>    bus: ti-sysc: Handle swsup idle mode quirks
>    bus: ti-sysc: Set ENAWAKEUP if available
>    bus: ti-sysc: Add support for disabling module without legacy mode
>    bus: ti-sysc: Do rstctrl reset handling in two phases
>    bus: ti-sysc: Detect uarts also on omap34xx
>    ARM: dts: Drop legacy custom hwmods property for omap4 uart
>    ARM: dts: Drop legacy custom hwmods property for omap4 mmc
> 
>   arch/arm/boot/dts/omap4-l4.dtsi       |   9 -
>   arch/arm/mach-omap2/omap_hwmod.c      |  39 +---
>   arch/arm/mach-omap2/pdata-quirks.c    |  60 +++++
>   drivers/bus/ti-sysc.c                 | 309 ++++++++++++++++++++------
>   include/linux/platform_data/ti-sysc.h |   9 +
>   5 files changed, 314 insertions(+), 112 deletions(-)
> 
