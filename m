From: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH] ARM: Convert to using %pOF instead of full_name
Date: Wed, 19 Jul 2017 10:02:20 +0200
Message-ID: <3802101.Kq7DfALjfy@phil>
References: <20170718214339.7774-1-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170718214339.7774-1-robh@kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: arm@kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Tony Lindgren <tony@atomide.com>, =?ISO-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Paul Walmsley <paul@pwsan.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Am Dienstag, 18. Juli 2017, 16:42:41 CEST schrieb Rob Herring:
> Now that we have a custom printf format specifier, convert users of
> full_name to use %pOF instead. This is preparation to remove storing
> of the full path string for each node.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

for the Rockchip part
Acked-by: Heiko Stuebner <heiko@sntech.de>

> diff --git a/arch/arm/mach-rockchip/platsmp.c b/arch/arm/mach-rockchip/platsmp.c
> index 3abafdbdd7f4..2b5b0e43d657 100644
> --- a/arch/arm/mach-rockchip/platsmp.c
> +++ b/arch/arm/mach-rockchip/platsmp.c
> @@ -182,8 +182,8 @@ static int __init rockchip_smp_prepare_sram(struct device_node *node)
> 
>  	ret = of_address_to_resource(node, 0, &res);
>  	if (ret < 0) {
> -		pr_err("%s: could not get address for node %s\n",
> -		       __func__, node->full_name);
> +		pr_err("%s: could not get address for node %pOF\n",
> +		       __func__, node);
>  		return ret;
>  	}
> 
