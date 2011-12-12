From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 01/10] GPIO: gpio-generic: Move initialization up to
 postcore
Date: Mon, 12 Dec 2011 10:04:56 -0800
Message-ID: <20111212180456.GF31337@atomide.com>
References: <1323634328-856-1-git-send-email-jkrzyszt@tis.icnet.pl>
 <1323634328-856-2-git-send-email-jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1323634328-856-2-git-send-email-jkrzyszt@tis.icnet.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Grant Likely <grant.likely@secretlab.ca>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [111211 11:41]:
> This will allow boards with custom memory mapped GPIO ports to set up
> and use those port pins while initializing devices from arch init.

Care to explain a bit more why you need to initialize those devices
early on?

Usually moving things earlier and earlier is an endless loop 
adding more and more nasty dependencies..

I'd rather see things getting initialized later as regular
device drivers so we have decent kernel error messages when
something goes wrong without having to enable debug_ll.

Regards,

Tony


> Created against linux-3.2-rc5.
> 
> Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
> ---
>  drivers/gpio/gpio-generic.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-generic.c b/drivers/gpio/gpio-generic.c
> index 4e24436..a6eaf38 100644
> --- a/drivers/gpio/gpio-generic.c
> +++ b/drivers/gpio/gpio-generic.c
> @@ -528,7 +528,7 @@ static int __init bgpio_platform_init(void)
>  {
>  	return platform_driver_register(&bgpio_driver);
>  }
> -module_init(bgpio_platform_init);
> +postcore_initcall(bgpio_platform_init);
>  
>  static void __exit bgpio_platform_exit(void)
>  {
> -- 
> 1.7.3.4
> 
