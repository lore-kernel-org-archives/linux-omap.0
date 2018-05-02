From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] arm: dts: am437x-sk-evm: add wilink8 support
Date: Wed, 2 May 2018 07:51:00 -0700
Message-ID: <20180502145100.GK98604@atomide.com>
References: <1525159453-32489-1-git-send-email-eyalr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1525159453-32489-1-git-send-email-eyalr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eyal Reizer <eyalreizer@gmail.com>
Cc: bcousson@baylibre.com, robh+dt@kernel.org, mark.rutland@arm.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Eyal Reizer <eyalr@ti.com>
List-Id: linux-omap@vger.kernel.org

* Eyal Reizer <eyalreizer@gmail.com> [180501 00:26]:
> enable mmc3 used for wlan and uart1 used for bluetooth
> configure the gpios used for wlan and bluetooth controls
> add fixed voltage regulator used for wlan power control
...
>  / {
>  	model = "TI AM437x SK EVM";
> @@ -158,6 +159,22 @@
>  			};
>  		};
>  	};
> +
> +	vmmcwl_fixed: fixedregulator-mmcwl {
> +		/*
> +		 * WL_EN is not SDIO standard compliant. It is an out of band
> +		 * signal and hard to be dealt with in a standard way by the
> +		 * SDIO core driver.
> +		 * So modelling the WL_EN line as a regulator was a natural
> +		 * choice as the MMC core already deals with MMC supplies.
> +		 */
> +		compatible = "regulator-fixed";
> +		regulator-name = "vmmcwl_fixed";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		gpio = <&gpio4 8 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
>  };

Interesting that it needs much longer delay here compared to the
earlier?

BTW, I do have a patch in work to add pwrseq support for wlcore that
allows leaving out the regulator here. It still needs a bit more
work though.

And I also have a series in work to make wlcore use runtime PM that
needs even more work, just FYI to avoid any duplicate work.

Hmm you don't happen to have a patch series somewhere making
wlcore use the SDIO dat lien interrupt?

I think we should use that when idle rather than the (edge) gpio
interrupt as the SDIO dat interrupt is level sensitive and wired
to the always on gpio bank for most SDIO controller instances.
On runtime PM wakeup, there's no status anywhere to been with the
GPIO edge interrupt.

Regards,

Tony
