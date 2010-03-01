From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH] board-n8x0: add USB initialization
Date: Mon, 1 Mar 2010 08:53:12 +0200
Message-ID: <20100301065312.GA14872@gandalf>
References: <1267321831-2775-1-git-send-email-alecrim@gmail.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:46055 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750839Ab0CAGxI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Mar 2010 01:53:08 -0500
Content-Disposition: inline
In-Reply-To: <1267321831-2775-1-git-send-email-alecrim@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Francisco Alecrim <alecrim@gmail.com>
Cc: linux-omap@vger.kernel.org, Francisco Alecrim <francisco.alecrim@openbossa.org>, Kalle Valo <kalle.valo@iki.fi>, Tony Lindgren <tony@atomide.com>

Hi,

On Sat, Feb 27, 2010 at 09:50:31PM -0400, Francisco Alecrim wrote:
> +static struct musb_hdrc_eps_bits musb_eps[] = {

this structure is being removed from current code, it's
not used anywhere. You can drop it.

> +	{	"ep1_tx", 5,	},
> +	{	"ep1_rx", 5,	},
> +	{	"ep2_tx", 5,	},
> +	{	"ep2_rx", 5,	},
> +	{	"ep3_tx", 3,	},
> +	{	"ep3_rx", 3,	},
> +	{	"ep4_tx", 3,	},
> +	{	"ep4_rx", 3,	},
> +	{	"ep5_tx", 2,	},
> +	{	"ep5_rx", 2,	},
> +	{	"ep6_tx", 2,	},
> +	{	"ep6_rx", 2,	},
> +	{	"ep7_tx", 2,	},
> +	{	"ep7_rx", 2,	},
> +	{	"ep8_tx", 2,	},
> +	{	"ep8_rx", 2,	},
> +	{	"ep9_tx", 2,	},
> +	{	"ep9_rx", 2,	},
> +	{	"ep10_tx", 2,	},
> +	{	"ep10_rx", 2,	},
> +	{	"ep11_tx", 2,	},
> +	{	"ep11_rx", 2,	},
> +	{	"ep12_tx", 2,	},
> +	{	"ep12_rx", 2,	},
> +	{	"ep13_tx", 2,	},
> +	{	"ep13_rx", 2,	},
> +	{	"ep14_tx", 2,	},
> +	{	"ep14_rx", 2,	},
> +	{	"ep15_tx", 2,	},
> +	{	"ep15_rx", 2,	},
> +};
> +
> +static struct musb_hdrc_config musb_config = {
> +	.multipoint	= 1,
> +	.dyn_fifo	= 1,
> +	.soft_con	= 1,
> +	.dma		= 1,
> +	.num_eps	= 16,
> +	.dma_channels	= 7,
> +	.ram_bits	= 12,
> +	.eps_bits	= musb_eps,

also few fields from here were droped but I can't recall without looking
at my code. Will only be able to do so tomorrow though.

> @@ -1841,6 +1841,7 @@ static struct omap_clk omap2420_clks[] = {
>  	CLK(NULL,	"aes_ick",	&aes_ick,	CK_242X),
>  	CLK(NULL,	"pka_ick",	&pka_ick,	CK_242X),
>  	CLK(NULL,	"usb_fck",	&usb_fck,	CK_242X),
> +	CLK("musb_hdrc",	"fck",	&osc_ck,	CK_242X),

it's called ick on other archs, let's keep consistency so we can stop
passing clock names soon.

Unless Tony are Paul have a reason not to do so.

-- 
balbi

