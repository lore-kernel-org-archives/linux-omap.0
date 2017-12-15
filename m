From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 0/4] PM / OPP: Introduce ti-opp-supply driver
Date: Fri, 15 Dec 2017 09:57:09 +0530
Message-ID: <20171215042709.GC3322@vireshk-i7>
References: <20171215042528.28715-1-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171215042528.28715-1-d-gerlach-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "Rafael J . Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 14-12-17, 22:25, Dave Gerlach wrote:
> Hi,
> This is v2 of the series to introduce the ti-opp-supply driver which makes
> use of the OPP core to enable multiple regulator DVFS and AVS Class0 for
> TI DRA7 and AM57 platforms. Version 1 of this series can be found here [1].
> 
> Very few changes since v1, just added Viresh's acks to patches 1 and 2 and
> added SPDX license to the ti-opp-supply driver in patch 4.
> 
> Pushed updated branch here just in case [2].
> 
> Regards,
> Dave
> 
> [1] https://www.spinics.net/lists/devicetree/msg205957.html
> [2] https://github.com/dgerlach/linux-pm/tree/upstream/v4.15/ti-multireg-support-v2
> 
> Dave Gerlach (4):
>   cpufreq: ti-cpufreq: Convert to module_platform_driver
>   cpufreq: ti-cpufreq: Add support for multiple regulators
>   dt-bindings: opp: Introduce ti-opp-supply bindings
>   PM / OPP: Add ti-opp-supply driver
> 
>  .../bindings/opp/ti-omap5-opp-supply.txt           |  63 +++
>  drivers/cpufreq/ti-cpufreq.c                       |  51 ++-
>  drivers/opp/Makefile                               |   1 +
>  drivers/opp/ti-opp-supply.c                        | 425 +++++++++++++++++++++
>  4 files changed, 534 insertions(+), 6 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/opp/ti-omap5-opp-supply.txt
>  create mode 100644 drivers/opp/ti-opp-supply.c

Acked-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

-- 
viresh
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
