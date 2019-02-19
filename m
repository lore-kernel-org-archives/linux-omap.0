From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH]  arm/mach-omap2/display: fix possible object reference
 leak
Date: Tue, 19 Feb 2019 09:05:16 -0800
Message-ID: <20190219170516.GL15711@atomide.com>
References: <1550071969-86286-1-git-send-email-peng.hao2@zte.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1550071969-86286-1-git-send-email-peng.hao2@zte.com.cn>
Sender: linux-kernel-owner@vger.kernel.org
To: Peng Hao <peng.hao2@zte.com.cn>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, Julia Lawall <Julia.Lawall@lip6.fr>
List-Id: linux-omap@vger.kernel.org

Hi,

Adding devicetree list, Julia, Rob and Tomi to Cc.

* Peng Hao <peng.hao2@zte.com.cn> [190212 23:11]:
> of_find_device_by_node() takes a reference to the struct device
> when it finds a match via get_device.When returning error we should
> call put_device.
> 
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> ---
>  arch/arm/mach-omap2/display.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
> index f86b72d..c6aa9ed 100644
> --- a/arch/arm/mach-omap2/display.c
> +++ b/arch/arm/mach-omap2/display.c
> @@ -258,6 +258,7 @@ static int __init omapdss_init_of(void)
>  	r = of_platform_populate(node, NULL, NULL, &pdev->dev);
>  	if (r) {
>  		pr_err("Unable to populate DSS submodule devices\n");
> +		put_device(&pdev->dev);
>  		return r;
>  	}

In general, if the device tree node is never used afterwards,
should this be just:

	r = of_platform_populate(node, NULL, NULL, &pdev->dev);
	of_node_put(dev_node);
	if (r) {
		...
	}

If so, Julia might have a Coccinelle recpipe for it?

Regards,

Tony
