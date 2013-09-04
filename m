From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH] ARM: omap2: throw the die id into the entropy pool
Date: Wed, 04 Sep 2013 15:24:31 -0700
Message-ID: <87hae0mdi8.fsf@linaro.org>
References: <1378326324-7170-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:58548 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756646Ab3IDWYe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Sep 2013 18:24:34 -0400
Received: by mail-pd0-f180.google.com with SMTP id y10so917357pdj.39
        for <linux-omap@vger.kernel.org>; Wed, 04 Sep 2013 15:24:34 -0700 (PDT)
In-Reply-To: <1378326324-7170-1-git-send-email-linus.walleij@linaro.org>
	(Linus Walleij's message of "Wed, 4 Sep 2013 22:25:24 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, Paul Walmsley <paul@pwsan.com>

Linus Walleij <linus.walleij@linaro.org> writes:

> Atleast eight bytes of this number are totally unique for the device
> it seems, so this is a perfect candidate for feeding the entropy
> pool. One byte more or less of constants does not matter so feed in
> the entire OID struct.
>
> Cc: Theodore Ts'o <tytso@mit.edu>
> Cc: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  arch/arm/mach-omap2/id.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
> index 2dc62a2..fc03cc6 100644
> --- a/arch/arm/mach-omap2/id.c
> +++ b/arch/arm/mach-omap2/id.c
> @@ -18,6 +18,7 @@
>  #include <linux/kernel.h>
>  #include <linux/init.h>
>  #include <linux/io.h>
> +#include <linux/random.h>
>  #include <linux/slab.h>
>  
>  #ifdef CONFIG_SOC_BUS
> @@ -130,6 +131,17 @@ void omap_get_die_id(struct omap_die_id *odi)
>  	odi->id_3 = read_tap_reg(OMAP_TAP_DIE_ID_3);
>  }
>  
> +static int __init omap_feed_randpool(void)
> +{
> +	struct omap_die_id odi;
> +
> +	/* Throw the die ID into the entropy pool at boot */
> +	omap_get_die_id(&odi);
> +	add_device_randomness(&odi, sizeof(odi));
> +	return 0;
> +}
> +device_initcall(omap_feed_randpool);

Needs to be omap_device_initcall() so it doesn't get called on non-OMAPs
in a multi-platform kernel.

Otherwise looks good.

Reviewed-by: Kevin Hilman <khilman@linaro.org>

Kevin

