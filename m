From: David Lechner <david@lechnology.com>
Subject: Re: [PATCH 13/17] soc: ti: pruss: export
 pruss_intc_configure/unconfigure APIs
Date: Mon, 26 Nov 2018 15:19:20 -0600
Message-ID: <dffe2d51-7970-95c9-b608-1cfbd3c004f9@lechnology.com>
References: <1542886753-17625-1-git-send-email-rogerq@ti.com>
 <1542886753-17625-14-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1542886753-17625-14-git-send-email-rogerq@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, tony@atomide.com
Cc: robh+dt@kernel.org, bcousson@baylibre.com, ssantosh@kernel.org, ohad@wizery.com, bjorn.andersson@linaro.org, s-anna@ti.com, nsekhar@ti.com, t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com, m-karicheri2@ti.com, woods.technical@gmail.com, linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 11/22/18 5:39 AM, Roger Quadros wrote:
> The PRU remoteproc driver will need to configure the
> Interrupt controller based on the application specific
> interrupt map.
> 
> Export pruss_intc_configure() and pruss_intc_unconfigure()
> to linux/pruss.h

Do we really need a patch just to move things around in header
files and make these public? It seems like this could have just
been done in the first place when these functions were introduced.

> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>   drivers/soc/ti/pruss.h | 21 -------------------
>   include/linux/pruss.h  | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 56 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/soc/ti/pruss.h b/drivers/soc/ti/pruss.h
> index 45de1be..ce3f96a 100644
> --- a/drivers/soc/ti/pruss.h
> +++ b/drivers/soc/ti/pruss.h

...

> +/**
> + * pruss_intc_configure() - configure the PRUSS INTC
> + * @pruss: the pruss instance
> + * @intc_config: PRU core-specific INTC configuration
> + *
> + * Configures the PRUSS INTC with the provided configuration from
> + * a PRU core. Any existing event to channel mappings or channel to
> + * host interrupt mappings are checked to make sure there are no
> + * conflicting configuration between both the PRU cores. The function
> + * is intended to be used only by the PRU remoteproc driver.

If this can only be used by the remoteproc driver, then how are other
drivers supposed to configure the interrupt mapping?


> + *
> + * Returns 0 on success, or a suitable error code otherwise
> + */
> +int pruss_intc_configure(struct pruss *pruss,
> +			 struct pruss_intc_config *intc_config);
> +
> +/**
> + * pruss_intc_unconfigure() - unconfigure the PRUSS INTC
> + * @pruss: the pruss instance
> + * @intc_config: PRU core specific INTC configuration
> + *
> + * Undo whatever was done in pruss_intc_configure() for a PRU core.
> + * It should be sufficient to just mark the resources free in the
> + * global map and disable the host interrupts and sysevents.

I don't understand the second sentence of this comment. Perhaps it needs
more explanation.

> + */
> +int pruss_intc_unconfigure(struct pruss *pruss,
> +			   struct pruss_intc_config *intc_config);
> +
