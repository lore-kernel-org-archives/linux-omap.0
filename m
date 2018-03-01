From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH 11/12] PM / AVS: SmartReflex: Prepare to use device tree based probing
Date: Wed, 28 Feb 2018 19:07:19 -0800
Message-ID: <7hr2p41ok8.fsf@baylibre.com>
References: <20180223210100.86732-1-tony@atomide.com>
        <20180223210100.86732-12-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180223210100.86732-12-tony@atomide.com> (Tony Lindgren's
        message of "Fri, 23 Feb 2018 13:00:59 -0800")
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Dave Gerlach <d-gerlach@ti.com>, Nishanth Menon <nm@ti.com>, Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-omap@vger.kernel.org

Tony Lindgren <tony@atomide.com> writes:

> We are currently probing smartreflex with omap_device while we are
> already probing smartreflex related interconnect target module with
> ti-sysc driver and dts data.
>
> Before we can flip things on for ti-sysc, we need to prepare the
> smartreflex driver a bit:
>
> 1. The smartreflex clock is really for the whole interconnect target
>    module. So it may be configured at the parent device level with
>    ti-sysc
>
> 2. With ti-sysc, we have the child device manage interconnect target
>    module directly if pm_runtime_irq_safe() is set and there is only
>    one child. In that case nobody else is going to call pm_runtime_get
>    and put, so we need to add these calls to idle smartreflex properly
>    after probe if not fully configured
>
> 3. With ti-sysc, the parent driver may rebind. So we want to use
>    platform_driver_register() and don't want probe to be __init
>
> Note that this patch depends on the related changes to ti-sysc driver
> and omap_device probing to prevent both ti-sysc and omap_device to
> try to probe smartreflex.
>
> Cc: linux-pm@vger.kernel.org
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Acked-by: Kevin Hilman <khilman@baylibre.com>

I don't have anything else queued for this driver, so feel free to take
it along with the rest of the series.

Kevin
