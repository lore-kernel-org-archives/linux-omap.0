From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP1: ams-delta FIQ: Fix a typo ("Initiaize")
Date: Tue, 22 Oct 2019 09:10:16 -0700
Message-ID: <20191022161016.GS5610@atomide.com>
References: <20191002145301.11332-1-j.neuschaefer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191002145301.11332-1-j.neuschaefer@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc: linux-omap@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Jonathan Neuschäfer <j.neuschaefer@gmx.net> [191002 07:54]:
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---
>  arch/arm/mach-omap1/ams-delta-fiq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap1/ams-delta-fiq.c b/arch/arm/mach-omap1/ams-delta-fiq.c
> index 0254eb9cf8c6..4eea3e39e633 100644
> --- a/arch/arm/mach-omap1/ams-delta-fiq.c
> +++ b/arch/arm/mach-omap1/ams-delta-fiq.c
> @@ -110,7 +110,7 @@ void __init ams_delta_init_fiq(struct gpio_chip *chip,
> 
>  		/*
>  		 * FIQ handler takes full control over serio data and clk GPIO
> -		 * pins.  Initiaize them and keep requested so nobody can
> +		 * pins.  Initialize them and keep requested so nobody can
>  		 * interfere.  Fail if any of those two couldn't be requested.
>  		 */
>  		switch (i) {
> --

Thanks applying into omap-for-v5.5/omap1.

Regards,

Tony
