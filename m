From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/9] ARM: dts: omap3-gta04: Fix 'aux' gpio key flags.
Date: Thu, 13 Feb 2014 15:08:06 -0800
Message-ID: <20140213230805.GJ28216@atomide.com>
References: <1390685343-11663-1-git-send-email-marek@goldelico.com>
 <1390685343-11663-2-git-send-email-marek@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1390685343-11663-2-git-send-email-marek@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Belisko <marek@goldelico.com>
Cc: bcousson@baylibre.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, neilb@suse.de, hns@goldelico.com
List-Id: linux-omap@vger.kernel.org

* Marek Belisko <marek@goldelico.com> [140125 13:31]:
> From: NeilBrown <neilb@suse.de>
> 
> It should be ACTIVE_HIGH.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  arch/arm/boot/dts/omap3-gta04.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/omap3-gta04.dts b/arch/arm/boot/dts/omap3-gta04.dts
> index b9b55c9..9d37184 100644
> --- a/arch/arm/boot/dts/omap3-gta04.dts
> +++ b/arch/arm/boot/dts/omap3-gta04.dts
> @@ -32,7 +32,7 @@
>  		aux-button {
>  			label = "aux";
>  			linux,code = <169>;
> -			gpios = <&gpio1 7 GPIO_ACTIVE_LOW>;
> +			gpios = <&gpio1 7 GPIO_ACTIVE_HIGH>;
>  			gpio-key,wakeup;
>  		};
>  	};

Picking this one into omap-for-v3.14/fixes thanks.

Tony
