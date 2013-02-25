From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH] ARM: OMAP4: Fix the init code to have OMAP4460 errata
 available in DT build
Date: Mon, 25 Feb 2013 09:02:14 -0600
Message-ID: <512B7CF6.8030905@ti.com>
References: <1361794156-9789-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54300 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758717Ab3BYPCT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Feb 2013 10:02:19 -0500
In-Reply-To: <1361794156-9789-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org


On 02/25/2013 06:09 AM, Santosh Shilimkar wrote:
> OMAP4460 ROM code bug needs the GIC distributor and local timer
> bases to be available for the bug work around. In current code, dt
> case these bases are not initialized leading to failure of the
> errata work-around.
> 
> Fix it by extracting the bases from dt blob and populating them.
> 
> Reported-by: Sourav Poddar <sourav.poddar@ti.com>
> Tested-by: Sourav Poddar <sourav.poddar@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
> Posting this one seperatly but will add along with rest of
> my fixes so that it doesn't get lost on the list.
> 
>  arch/arm/mach-omap2/omap4-common.c |   32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
> index 6897ae2..d07740e 100644
> --- a/arch/arm/mach-omap2/omap4-common.c
> +++ b/arch/arm/mach-omap2/omap4-common.c
> @@ -261,8 +261,40 @@ static struct of_device_id irq_match[] __initdata = {
>  	{ }
>  };
>  
> +static struct of_device_id twd_match[] __initdata = {
> +	{ .compatible = "arm,cortex-a9-twd-timer", },
> +	{ }
> +};
> +
>  void __init omap_gic_of_init(void)
>  {
> +	struct device_node *np;
> +	const void *reg_prop;
> +	unsigned long start = 0, size = 0;
> +
> +	/* Extract GIC distributor and TWD bases for OMAP4460 ROM Errata WA */
> +	if (!cpu_is_omap446x())
> +		goto skip_errata_init;
> +
> +	np = of_find_matching_node(NULL, irq_match);
> +	if (np) {
> +		reg_prop = of_get_property(np, "reg", NULL);
> +		start = of_read_number(reg_prop, 1);
> +		size = of_read_number(reg_prop + 4, 1);

Alternatively, you could replace the above 3 lines with ...

gic_dist_base_addr = of_iomap(np, 0);

> +	}
> +	gic_dist_base_addr = ioremap(start, size);
> +	WARN_ON(!gic_dist_base_addr);
> +
> +	np = of_find_matching_node(NULL, twd_match);
> +	if (np) {
> +		reg_prop = of_get_property(np, "reg", NULL);
> +		start = of_read_number(reg_prop, 1);
> +		size = of_read_number(reg_prop + 4, 1);

Same here.

Cheers
Jon
