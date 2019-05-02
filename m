From: Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH 0/2] Two ti-sysc driver fixes for v5.3 merge window
Date: Thu, 2 May 2019 09:40:57 +0530
Message-ID: <3cb61934-0add-38f5-dd37-6fc597e0ed6b@ti.com>
References: <20190501214129.12572-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190501214129.12572-1-tony@atomide.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: Dave Gerlach <d-gerlach@ti.com>, Faiz Abbas <faiz_abbas@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nishanth Menon <nm@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Roger Quadros <rogerq@ti.com>, Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
List-Id: linux-omap@vger.kernel.org



On 02/05/19 3:11 AM, Tony Lindgren wrote:
> Hi all,
> 
> Here are few fixes for the am335x d_can boot issue Sebastian reported for
> Beaglebone.

Tested for AM437x-gp-evm RTC+DDR mode and DS0.
Also tried DS0 on Am335x beaglebone black.

For the above:

Tested-by: Keerthy <j-keerthy@ti.com>

> 
> Regards,
> 
> Tony
> 
> 
> Tony Lindgren (2):
>    ARM: dts: Configure osc clock for d_can on am335x
>    bus: ti-sysc: Handle devices with no control registers
> 
>   arch/arm/boot/dts/am33xx-l4.dtsi | 14 ++++++--------
>   arch/arm/boot/dts/am437x-l4.dtsi |  4 ----
>   drivers/bus/ti-sysc.c            | 23 +++++++++++------------
>   3 files changed, 17 insertions(+), 24 deletions(-)
> 
