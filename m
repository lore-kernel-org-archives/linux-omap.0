From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 4/4] ARM: remove duplicate const qualifier
Date: Mon, 25 Apr 2016 15:22:33 +0530
Message-ID: <20160425095233.GH32183@vireshk-i7>
References: <1461577678-29517-1-git-send-email-eric.engestrom@imgtec.com>
 <1461577678-29517-4-git-send-email-eric.engestrom@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1461577678-29517-4-git-send-email-eric.engestrom@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eric Engestrom <eric.engestrom@imgtec.com>
Cc: linux-kernel@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Russell King <linux@arm.linux.org.uk>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Alexander Shiyan <shc_work@mail.ru>, Krzysztof Halasa <khalasa@piap.pl>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Roland Stigge <stigge@antcom.de>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Rajendra Nayak <rnayak@ti.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Viresh Kumar <vireshk@kernel.org>, Shiraz Hashim <shiraz.linux.kernel@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Nicolas Pitre <nicolas.pitre@li>
List-Id: linux-omap@vger.kernel.org

On 25-04-16, 10:47, Eric Engestrom wrote:
> diff --git a/arch/arm/mach-spear/time.c b/arch/arm/mach-spear/time.c
> index 9ccffc1..aaaa678 100644
> --- a/arch/arm/mach-spear/time.c
> +++ b/arch/arm/mach-spear/time.c
> @@ -204,7 +204,7 @@ static void __init spear_clockevent_init(int irq)
>  	setup_irq(irq, &spear_timer_irq);
>  }
>  
> -static const struct of_device_id const timer_of_match[] __initconst = {
> +static const struct of_device_id timer_of_match[] __initconst = {
>  	{ .compatible = "st,spear-timer", },
>  	{ },
>  };

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
