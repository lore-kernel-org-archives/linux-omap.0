From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH v2] mtd: omap_elm: print interrupt resource using %pr
Date: Fri, 18 Dec 2015 10:24:37 -0800
Message-ID: <20151218182437.GM10460@google.com>
References: <2327550.1yLrRnIh7I@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2327550.1yLrRnIh7I@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

On Fri, Dec 18, 2015 at 02:15:17PM +0100, Arnd Bergmann wrote:
> When CONFIG_LPAE is set on ARM, resource_size_t is 64-bit wide
> and we get a warning about an incorrect format string for printing
> the interrupt number in elm_probe:
> 
> drivers/mtd/nand/omap_elm.c: In function 'elm_probe':
> drivers/mtd/nand/omap_elm.c:417:23: warning: format '%i' expects argument of type 'int', but argument 3 has type 'resource_size_t {aka long long unsigned int}' [-Wformat=]
> 
> This patch avoids the type mismatch by printing the interrupt as
> a resource using the %pr format string.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2: pass correct pointer
> 
> diff --git a/drivers/mtd/nand/omap_elm.c b/drivers/mtd/nand/omap_elm.c
> index 235ec7992b4c..a3f32f939cc1 100644
> --- a/drivers/mtd/nand/omap_elm.c
> +++ b/drivers/mtd/nand/omap_elm.c
> @@ -414,7 +414,7 @@ static int elm_probe(struct platform_device *pdev)
>  	ret = devm_request_irq(&pdev->dev, irq->start, elm_isr, 0,
>  			pdev->name, info);
>  	if (ret) {
> -		dev_err(&pdev->dev, "failure requesting irq %i\n", irq->start);
> +		dev_err(&pdev->dev, "failure requesting %pr\n", irq);

FWIW, the printk documentation isn't very specific about the formatting
for %pr. After drilling down to resource_string() in lib/vsprintf.c, it
looks like there is special case handling for various resrouce types,
even though the documentation only shows IORESOURCE_MEM types.

Applied to l2-mtd.git.

>  		return ret;
>  	}
>  
> 
