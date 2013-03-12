From: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] cpufreq: cpufreq-cpu0: provide compatibility string
 for DT matchup
Date: Tue, 12 Mar 2013 15:57:19 +0800
Message-ID: <20130312075716.GH18574@S2101-09.ap.freescale.net>
References: <1363043130-30270-1-git-send-email-nm@ti.com>
 <1363043130-30270-3-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1363043130-30270-3-git-send-email-nm-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, cpufreq <cpufreq-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Copied devicetree-discuss list.

On Mon, Mar 11, 2013 at 06:05:30PM -0500, Nishanth Menon wrote:
> commit 5553f9e (cpufreq: instantiate cpufreq-cpu0 as a platform_driver)
> now forces platform device to be registered for allowing cpufreq-cpu0
> to be used by SoCs. example: drivers/cpufreq/highbank-cpufreq.c
> 
> However, for SoCs that wish to link up using device tree, instead
> of platform device, provide compatibility string match:
> compatible = "cpufreq,cpu0";

This compatible is merely added for asking DT core code to populate
a platform_device for cpufreq driver.  It's not describing
hardware/cpus, and it does not belong to device tree.

Shawn

> 
> Cc: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
> Cc: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
> Cc: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: cpufreq-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> 
> Signed-off-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
> ---
>  .../devicetree/bindings/cpufreq/cpufreq-cpu0.txt   |    3 +++
>  drivers/cpufreq/cpufreq-cpu0.c                     |    6 ++++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-cpu0.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-cpu0.txt
> index f180963..a5699f0 100644
> --- a/Documentation/devicetree/bindings/cpufreq/cpufreq-cpu0.txt
> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-cpu0.txt
> @@ -10,6 +10,8 @@ under node /cpus/cpu@0.
>  Required properties:
>  - operating-points: Refer to Documentation/devicetree/bindings/power/opp.txt
>    for details
> +- compatible: if platform_device is *not* used, should be:
> +  "cpufreq,cpu0"
>  
>  Optional properties:
>  - clock-name: If the clock is not converted to device tree, then describe
> @@ -24,6 +26,7 @@ Examples:
>  cpus {
>  	#address-cells = <1>;
>  	#size-cells = <0>;
> +	compatible = "cpufreq,cpu0";
>  
>  	cpu@0 {
>  		compatible = "arm,cortex-a9";
> diff --git a/drivers/cpufreq/cpufreq-cpu0.c b/drivers/cpufreq/cpufreq-cpu0.c
> index 28223c9..a6f0a9b 100644
> --- a/drivers/cpufreq/cpufreq-cpu0.c
> +++ b/drivers/cpufreq/cpufreq-cpu0.c
> @@ -277,9 +277,15 @@ static int cpu0_cpufreq_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static struct of_device_id of_cpu0_cpufreq_match[] = {
> +	{ .compatible = "cpufreq,cpu0", },
> +	{ /* end */ }
> +};
> +
>  static struct platform_driver cpu0_cpufreq_platdrv = {
>  	.driver = {
>  		.name	= "cpufreq-cpu0",
> +		.of_match_table = of_cpu0_cpufreq_match,
>  		.owner	= THIS_MODULE,
>  	},
>  	.probe		= cpu0_cpufreq_probe,
> -- 
> 1.7.9.5
> 
