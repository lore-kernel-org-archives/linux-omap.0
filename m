From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH 4/5] MFD: OMAP3EVM: USB: cosmetic fix to failed parent
 clk set
Date: Tue, 12 Jun 2012 10:56:17 +0300
Message-ID: <4FD6F621.70500@compulab.co.il>
References: <zumeng.chen@gmail.com>
 <1339423216-1323-1-git-send-email-zumeng.chen@gmail.com>
 <1339423216-1323-5-git-send-email-zumeng.chen@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1339423216-1323-5-git-send-email-zumeng.chen@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Zumeng Chen <zumeng.chen@gmail.com>
Cc: khilman@ti.com, tony@atomide.com, hvaibhav@ti.com, ajay.gupta@ti.com, khasim@ti.com, jon-hunter@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 06/11/12 17:00, Zumeng Chen wrote:
> A typo fix for this cosmetic change and mute a failed message from
> a unnecessary setting of some parent clk for usbhs_omap on OMAP3EVM.
> 
> Signed-off-by: Zumeng Chen <zumeng.chen@gmail.com>
> ---
>  drivers/mfd/omap-usb-host.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
> index 7e96bb2..9aaaf3c 100644
> --- a/drivers/mfd/omap-usb-host.c
> +++ b/drivers/mfd/omap-usb-host.c
> @@ -698,8 +698,9 @@ static int __devinit usbhs_omap_probe(struct platform_device *pdev)
>  		goto err_usbtll_p2_fck;
>  	}
>  
> +#ifndef CONFIG_MACH_OMAP3EVM
> +	/* for OMAP3 , the clk set parent fails */
>  	if (is_ehci_phy_mode(pdata->port_mode[0])) {
> -		/* for OMAP3 , the clk set paretn fails */
>  		ret = clk_set_parent(omap->utmi_p1_fck,
>  					omap->xclk60mhsp1_ck);
>  		if (ret != 0)
> @@ -726,6 +727,7 @@ static int __devinit usbhs_omap_probe(struct platform_device *pdev)
>  			dev_err(dev, "init_60m_fclk set parent"
>  				"failed error:%d\n", ret);
>  	}
> +#endif

I agree with John, this is a bad fix. Fix the problem, don't hide it...

>  
>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "uhh");
>  	if (!res) {

-- 
Regards,
Igor.
