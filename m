From: Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v6 1/5] ARM: OMAP: gpmc: don't create devices from initcall
 on DT
Date: Thu, 29 Nov 2012 12:00:43 -0600
Message-ID: <50B7A2CB.4020407@ti.com>
References: <1354204892-22762-1-git-send-email-zonque@gmail.com>
 <1354204892-22762-2-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1354204892-22762-2-git-send-email-zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: x0148406-l0cyMroinI0@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, avinashphilip-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org


On 11/29/2012 10:01 AM, Daniel Mack wrote:
> On DT driven boards, the gpmc node will match the driver. Hence, there's
> no need to do that unconditionally from the initcall.
> 
> Signed-off-by: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  arch/arm/mach-omap2/gpmc.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
> index 60f1cce..1dcb30c 100644
> --- a/arch/arm/mach-omap2/gpmc.c
> +++ b/arch/arm/mach-omap2/gpmc.c
> @@ -844,6 +844,13 @@ static int __init omap_gpmc_init(void)
>  	struct platform_device *pdev;
>  	char *oh_name = "gpmc";
>  
> +	/*
> +	 * if the board boots up with a populated DT, do not
> +	 * manually add the device from this initcall
> +	 */
> +	if (of_have_populated_dt())
> +		return -ENODEV;
> +
>  	oh = omap_hwmod_lookup(oh_name);
>  	if (!oh) {
>  		pr_err("Could not look up %s\n", oh_name);

Acked-by: Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>

Thanks
Jon
