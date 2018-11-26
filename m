From: David Lechner <david@lechnology.com>
Subject: Re: [PATCH 08/17] soc: ti: pruss: Add a PRUSS irqchip driver for
 PRUSS interrupts
Date: Mon, 26 Nov 2018 15:17:49 -0600
Message-ID: <af2f8ce3-923b-aa27-59b2-2ebb848c28c9@lechnology.com>
References: <1542886753-17625-1-git-send-email-rogerq@ti.com>
 <1542886753-17625-9-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1542886753-17625-9-git-send-email-rogerq@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, tony@atomide.com
Cc: robh+dt@kernel.org, bcousson@baylibre.com, ssantosh@kernel.org, ohad@wizery.com, bjorn.andersson@linaro.org, s-anna@ti.com, nsekhar@ti.com, t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com, m-karicheri2@ti.com, woods.technical@gmail.com, linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 11/22/18 5:39 AM, Roger Quadros wrote:
> From: Suman Anna <s-anna@ti.com>
> 
> The Programmable Real-Time Unit Subsystem (PRUSS) contains an
> interrupt controller (INTC) that can handle various system input
> events and post interrupts back to the device-level initiators.
> The INTC can support upto 64 input events with individual control
> configuration and hardware prioritization. These events are mapped
> onto 10 interrupt signals through two levels of many-to-one mapping
> support. Different interrupt signals are routed to the individual
> PRU cores or to the host CPU.
> 
> The PRUSS INTC platform driver manages this PRUSS interrupt
> controller and implements an irqchip driver to provide a Linux
> standard way for the PRU client users to enable/disable/ack/
> re-trigger a PRUSS system event. The system events to interrupt
> channels and host interrupts relies on the mapping configuration
> provided through a firmware resource table for now. This will be
> revisited and enhanced in the future for a better interface. The
> mappings will currently be programmed during the boot/shutdown
> of the PRU.

Does this mapping table take up space in the PRU IRAM or DRAM? If
so, that can be a problem on the AM18xx because it has such limited
resources - every byte counts.

Perhaps one way to simplify the mapping is to take out one of the
two levels of mapping. All of the TRMs say that it is highly
recommended to have a 1:1 mapping from channels to host interrupts.
This part of the mapping could just be hard-coded in this driver.
Then the mapping tables would just effectively mapping PRU system
events to host interrupts.

> 
> The PRUSS INTC module is reference counted during the interrupt
> setup phase through the irqchip's irq_request_resources() and
> irq_release_resources() ops. This restricts the module from being
> removed as long as there are active interrupt users.
> 
> The driver currently supports the AM335x SoC.
> 
> Signed-off-by: Suman Anna <s-anna@ti.com>
> Signed-off-by: Andrew F. Davis <afd@ti.com>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>   drivers/soc/ti/Makefile     |   2 +-
>   drivers/soc/ti/pruss.h      |  29 +++
>   drivers/soc/ti/pruss_intc.c | 572 ++++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 602 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/soc/ti/pruss_intc.c
> 

...

> diff --git a/drivers/soc/ti/pruss_intc.c b/drivers/soc/ti/pruss_intc.c
> new file mode 100644
> index 0000000..dde054b
> --- /dev/null
> +++ b/drivers/soc/ti/pruss_intc.c
> @@ -0,0 +1,572 @@

...

> +int pruss_intc_configure(struct pruss *pruss,
> +			 struct pruss_intc_config *intc_config)
> +{
> +	struct device *dev = pruss->dev;
> +	struct pruss_intc *intc = to_pruss_intc(pruss);
> +	int i, idx, ret;
> +	s8 ch, host;
> +	u64 sysevt_mask = 0;
> +	u32 ch_mask = 0;
> +	u32 host_mask = 0;
> +	u32 val;
> +
> +	if (!intc)
> +		return -EINVAL;
> +
> +	mutex_lock(&intc->lock);
> +
> +	/*
> +	 * configure channel map registers - each register holds map info
> +	 * for 4 events, with each event occupying the lower nibble in
> +	 * a register byte address in little-endian fashion
> +	 */
> +	for (i = 0; i < ARRAY_SIZE(intc_config->sysev_to_ch); i++) {
> +		ch = intc_config->sysev_to_ch[i];
> +		if (ch < 0)
> +			continue;
> +
> +		/* check if sysevent already assigned */
> +		if (intc->config_map.sysev_to_ch[i] != -1) {

Perhaps define a macro for -1 so we know what it means?
