From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 02/14] bus: ti-sysc: Handle missed no-idle property in addition to no-idle-on-init
Date: Sun, 31 Mar 2019 01:41:58 -0500
Message-ID: <5ca06138.1c69fb81.68bd3.106e@mx.google.com>
References: <20190325215849.13182-1-tony@atomide.com> <20190325215849.13182-3-tony@atomide.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190325215849.13182-3-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Dave Gerlach <d-gerlach@ti.com>, Faiz Abbas <faiz_abbas@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Roger Quadros <rogerq@ti.com>, Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, 25 Mar 2019 14:58:37 -0700, Tony Lindgren wrote:
> We have ti,no-idle in use in addition to ti,no-idle-on-init but we're
> missing handling for it in the ti-sysc interconnect target module driver.
> 
> Let's also group the idle defines together and update the binding
> documentation for it.
> 
> Cc: Rob Herring <robh@kernel.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  Documentation/devicetree/bindings/bus/ti-sysc.txt | 2 ++
>  arch/arm/mach-omap2/omap_hwmod.c                  | 2 ++
>  drivers/bus/ti-sysc.c                             | 5 ++++-
>  include/linux/platform_data/ti-sysc.h             | 5 +++--
>  4 files changed, 11 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
