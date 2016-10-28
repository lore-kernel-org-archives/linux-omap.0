From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3 1/3] PM / OPP: Expose _of_get_opp_desc_node as
 dev_pm_opp API
Date: Fri, 28 Oct 2016 09:35:07 +0530
Message-ID: <20161028040507.GJ10423@vireshk-i7>
References: <20161027214131.1725-1-d-gerlach@ti.com>
 <20161027214131.1725-2-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161027214131.1725-2-d-gerlach@ti.com>
Sender: linux-pm-owner@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

On 27-10-16, 16:41, Dave Gerlach wrote:
> Move _of_get_opp_desc_node into include/linux/pm_opp.h and rename it
> dev_pm_opp_of_get_opp_desc_node to allow other drivers, such as platform
> OPP and cpufreq drivers, to make use of it.
> 
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> ---
>  drivers/base/power/opp/of.c  | 8 ++++----
>  drivers/base/power/opp/opp.h | 1 -
>  include/linux/pm_opp.h       | 6 ++++++
>  3 files changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/base/power/opp/of.c b/drivers/base/power/opp/of.c
> index 5552211e6fcd..215f5a538c78 100644
> --- a/drivers/base/power/opp/of.c
> +++ b/drivers/base/power/opp/of.c
> @@ -198,7 +198,7 @@ void dev_pm_opp_of_remove_table(struct device *dev)
>  EXPORT_SYMBOL_GPL(dev_pm_opp_of_remove_table);
>  
>  /* Returns opp descriptor node for a device, caller must do of_node_put() */
> -struct device_node *_of_get_opp_desc_node(struct device *dev)
> +struct device_node *dev_pm_opp_of_get_opp_desc_node(struct device *dev)

Export as well ?

-- 
viresh
