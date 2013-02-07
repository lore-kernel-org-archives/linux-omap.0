From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH 2/2] dmaengine: OMAP: Register SDMA controller with Device
 Tree DMA driver
Date: Thu, 7 Feb 2013 14:39:13 +0000
Message-ID: <201302071439.13720.arnd@arndb.de>
References: <1360184596-1603-1-git-send-email-jon-hunter@ti.com>
 <1360184596-1603-3-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1360184596-1603-3-git-send-email-jon-hunter-l0cyMroinI0@public.gmane.org>
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
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, device-tree <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Balaji T K <balajitk-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wednesday 06 February 2013, Jon Hunter wrote:
> +static struct of_dma_filter_info info;

Both members of this structure are constant, so you can just initialize it here,
and it would be nice to give it a more descriptive name, such as omap_dmadev_info.

>  static struct platform_driver omap_dma_driver = {
>  	.probe	= omap_dma_probe,
>  	.remove	= omap_dma_remove,
>  	.driver = {
>  		.name = "omap-dma-engine",
>  		.owner = THIS_MODULE,
> +		.of_match_table = of_match_ptr(omap_dma_match)
>  	},
>  };

please end the new line with a comma.
  
> @@ -673,7 +702,7 @@ static int omap_dma_init(void)
>  {
>  	int rc = platform_driver_register(&omap_dma_driver);
>  
> -	if (rc == 0) {
> +	if ((rc == 0) && (!of_have_populated_dt())) {
>  		pdev = platform_device_register_full(&omap_dma_dev_info);
>  		if (IS_ERR(pdev)) {
>  			platform_driver_unregister(&omap_dma_driver);

There is already a patch in linux-next that makes this obsolete.
The device is now registered in arch/arm/mach-omap2/dma.c, so
I guess you have to change that location now.

	Arnd
