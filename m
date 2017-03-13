From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/4] ARM: dts: dm8168-evm: add SATA node
Date: Mon, 13 Mar 2017 14:15:21 -0700
Message-ID: <20170313211520.GW20572@atomide.com>
References: <1489423399-3824-1-git-send-email-bgolaszewski@baylibre.com>
 <1489423399-3824-4-git-send-email-bgolaszewski@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1489423399-3824-4-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Neil Armstrong <narmstrong@baylibre.com>, Michael Turquette <mturquette@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, Patrick Titiano <ptitiano@baylibre.com>, Paul Walmsley <paul@pwsan.com>, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Bartosz Golaszewski <bgolaszewski@baylibre.com> [170313 09:45]:
> Add the SATA controller node to the dm8168-evm device tree.
> --- a/arch/arm/boot/dts/dm816x.dtsi
> +++ b/arch/arm/boot/dts/dm816x.dtsi
> @@ -293,6 +293,13 @@
>  			phy-handle = <&phy1>;
>  		};
>  
> +		sata: sata@4a140000 {
> +			compatible = "ti,dm816-ahci";
> +			reg = <0x4a140000 0xffff>;
> +			interrupts = <16>;
> +			ti,hwmods = "sata";
> +		};

The size should be 0x10000 instead of 0xffff, right?

Tony
