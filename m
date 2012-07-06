From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/5] ARM: OMAP3EVM: cosmetic fixes for parent clk set
Date: Fri, 6 Jul 2012 01:38:23 -0700
Message-ID: <20120706083823.GQ1122@atomide.com>
References: <1340183693-3195-1-git-send-email-zumeng.chen@windriver.com>
 <1340183693-3195-5-git-send-email-zumeng.chen@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1340183693-3195-5-git-send-email-zumeng.chen@windriver.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Zumeng Chen <zumeng.chen@windriver.com>, Paul Walmsley <paul@pwsan.com>
Cc: khilman@ti.com, hvaibhav@ti.com, ajay.gupta@ti.com, jon-hunter@ti.com, mike@compulab.co.il, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Zumeng Chen <zumeng.chen@windriver.com> [120620 02:19]:
> Since it's no more sense to set parent for dummy clock,
> so we can just ignore it to mute failed message.

This is something Paul should look at.

Regards,

Tony
 
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> Signed-off-by: Zumeng Chen <zumeng.chen@gmail.com>
> ---
>  arch/arm/plat-omap/clock.c  |    4 ++++
>  drivers/mfd/omap-usb-host.c |    2 +-
>  2 files changed, 5 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
> index 62ec5c4..c7e26e4 100644
> --- a/arch/arm/plat-omap/clock.c
> +++ b/arch/arm/plat-omap/clock.c
> @@ -149,6 +149,10 @@ int clk_set_parent(struct clk *clk, struct clk *parent)
>  	if (!arch_clock || !arch_clock->clk_set_parent)
>  		return ret;
>  
> +	/* If the clock is a dummy clock just return */
> +	if (clk == &dummy_ck)
> +		return 0;
> +
>  	spin_lock_irqsave(&clockfw_lock, flags);
>  	if (clk->usecount == 0) {
>  		ret = arch_clock->clk_set_parent(clk, parent);
> diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
> index 7e96bb2..c9d27c4 100644
> --- a/drivers/mfd/omap-usb-host.c
> +++ b/drivers/mfd/omap-usb-host.c
> @@ -699,7 +699,7 @@ static int __devinit usbhs_omap_probe(struct platform_device *pdev)
>  	}
>  
>  	if (is_ehci_phy_mode(pdata->port_mode[0])) {
> -		/* for OMAP3 , the clk set paretn fails */
> +		/* for OMAP3 , the clk set parent fails */
>  		ret = clk_set_parent(omap->utmi_p1_fck,
>  					omap->xclk60mhsp1_ck);
>  		if (ret != 0)
> -- 
> 1.7.5.4
> 
