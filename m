From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap: mux: add AM/DM37x gpios
Date: Wed, 8 May 2013 16:30:44 -0700
Message-ID: <20130508233044.GT32546@atomide.com>
References: <1365874225.3812.53.camel@mars>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:13309 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752490Ab3EHXar (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 May 2013 19:30:47 -0400
Content-Disposition: inline
In-Reply-To: <1365874225.3812.53.camel@mars>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Christoph Fritz <chf.fritz@googlemail.com>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>, linux-omap@vger.kernel.org, Daniel Mack <daniel@zonque.org>, "Hans J. Koch" <hjk@hansjkoch.de>

* Christoph Fritz <chf.fritz@googlemail.com> [130413 10:35]:
> This patch adds GPIO pins found on AM/DM37x.

Thanks applying into omap-for-v3.10/fixes.

Tony
 
> Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
> ---
>  arch/arm/mach-omap2/mux34xx.h |    6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap2/mux34xx.h b/arch/arm/mach-omap2/mux34xx.h
> index 6543ebf..3f26d29 100644
> --- a/arch/arm/mach-omap2/mux34xx.h
> +++ b/arch/arm/mach-omap2/mux34xx.h
> @@ -393,6 +393,10 @@
>  #define OMAP3_CONTROL_PADCONF_SAD2D_SWAKEUP_OFFSET		0xa1c
>  #define OMAP3_CONTROL_PADCONF_JTAG_RTCK_OFFSET			0xa1e
>  #define OMAP3_CONTROL_PADCONF_JTAG_TDO_OFFSET			0xa20
> +#define OMAP3_CONTROL_PADCONF_GPIO_127				0xa24
> +#define OMAP3_CONTROL_PADCONF_GPIO_126				0xa26
> +#define OMAP3_CONTROL_PADCONF_GPIO_128				0xa28
> +#define OMAP3_CONTROL_PADCONF_GPIO_129				0xa2a
>  
>  #define OMAP3_CONTROL_PADCONF_MUX_SIZE				\
> -		(OMAP3_CONTROL_PADCONF_JTAG_TDO_OFFSET + 0x2)
> +		(OMAP3_CONTROL_PADCONF_GPIO_129 + 0x2)
> -- 
> 1.7.10.4
> 
> 
> 
