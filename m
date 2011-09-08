From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC PATCH 01/10] OMAP2+: l3-noc: Add support for device-tree
Date: Thu, 8 Sep 2011 11:01:48 -0700
Message-ID: <20110908180148.GA2967@ponder.secretlab.ca>
References: <1314191356-10963-1-git-send-email-b-cousson@ti.com>
	<1314191356-10963-2-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1314191356-10963-2-git-send-email-b-cousson@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: khilman@ti.com, tony@atomide.com, manjugk@ti.com, devicetree-discuss@lists.ozlabs.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wed, Aug 24, 2011 at 03:09:07PM +0200, Benoit Cousson wrote:
> Add device-tree support for the l3-noc driver.
> 
> Use platform_driver_register to defer the probing at device init
> time.
> 
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm/mach-omap2/omap_l3_noc.c |   16 ++++++++++++++--
>  1 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_l3_noc.c b/arch/arm/mach-omap2/omap_l3_noc.c
> index 7b9f190..4630703 100644
> --- a/arch/arm/mach-omap2/omap_l3_noc.c
> +++ b/arch/arm/mach-omap2/omap_l3_noc.c
> @@ -228,16 +228,28 @@ static int __exit omap4_l3_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +#if defined(CONFIG_OF)
> +static const struct of_device_id l3_noc_match[] = {
> +	{.compatible = "arteris,noc", },

Missing documentation for this compatible property.  Also, it appears
to be rather on the generic side.

> +	{},
> +}
> +MODULE_DEVICE_TABLE(of, l3_noc_match);
> +#else
> +#define l3_noc_match NULL
> +#endif
> +
>  static struct platform_driver omap4_l3_driver = {
> +	.probe		= omap4_l3_probe,

.probe needs to be put into the __devinit section.

>  	.remove		= __exit_p(omap4_l3_remove),

Similarly, at the same time the remove hook should be changed to
__devexit and __devexit_p() at the same time.

>  	.driver		= {
> -	.name		= "omap_l3_noc",
> +		.name		= "omap_l3_noc",
> +		.of_match_table = l3_noc_match,

Looks like ".owner = THIS_MODULE," is missing too.

>  	},
>  };
>  
>  static int __init omap4_l3_init(void)
>  {
> -	return platform_driver_probe(&omap4_l3_driver, omap4_l3_probe);
> +	return platform_driver_register(&omap4_l3_driver);
>  }
>  postcore_initcall_sync(omap4_l3_init);
>  
> -- 
> 1.7.0.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
