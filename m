From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] ARM: omap: Convert to using %pOFn instead of
 device_node.name
Date: Mon, 27 Aug 2018 23:55:05 -0700
Message-ID: <b2d9328b9cd48e768ac8062de60a95195b8ffb58.camel@perches.com>
References: <20180828015252.28511-1-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180828015252.28511-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Cc: =?ISO-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Mon, 2018-08-27 at 20:52 -0500, Rob Herring wrote:
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
[]
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
[]
> @@ -738,7 +738,7 @@ static int __init _setup_clkctrl_provider(struct device_node *np)
>  	provider->size = size | 0xff;
>  	provider->node = np;
>  
> -	pr_debug("%s: %s: %x...%x [+%x]\n", __func__, np->parent->name,
> +	pr_debug("%pOF: %s: %x...%x [+%x]\n", __func__, np->parent,

Wrong argument order

I didn't look at the rest.
