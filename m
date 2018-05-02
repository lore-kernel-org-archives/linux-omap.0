From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH] arm: dts: am437x-sk-evm: add wilink8 support
Date: Wed, 2 May 2018 14:00:52 +0530
Message-ID: <abebf4a1-11d6-413b-a3c0-4f46ac6fc485@ti.com>
References: <1525159453-32489-1-git-send-email-eyalr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1525159453-32489-1-git-send-email-eyalr@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Eyal Reizer <eyalreizer@gmail.com>, bcousson@baylibre.com, tony@atomide.com, robh+dt@kernel.org, mark.rutland@arm.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Eyal Reizer <eyalr@ti.com>
List-Id: linux-omap@vger.kernel.org

On Tuesday 01 May 2018 12:54 PM, Eyal Reizer wrote:
> enable mmc3 used for wlan and uart1 used for bluetooth
> configure the gpios used for wlan and bluetooth controls
> add fixed voltage regulator used for wlan power control
> 
> Signed-off-by: Eyal Reizer <eyalr@ti.com>

ARM should be capitalized in subject line.

> +
> +&mmc3 {
> +	status = "okay";
> +	/*
> +	 * these are on the crossbar and are outlined in the
> +	 * xbar-event-map element
> +	 */
> +	dmas = <&edma_xbar 30 0 1>,
> +		<&edma_xbar 31 0 2>;
> +	dma-names = "tx", "rx";
> +	vmmc-supply = <&vmmcwl_fixed>;
> +	bus-width = <4>;
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&mmc3_pins_default>;
> +	pinctrl-1 = <&mmc3_pins_sleep>;
> +	cap-power-off-card;
> +	keep-power-in-suspend;
> +	ti,non-removable;
> +
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	wlcore: wlcore@0 {

wlcore@2

> +		compatible = "ti,wl1835";
> +		pinctrl-names = "default", "sleep";
> +		pinctrl-0 = <&wlan_pins_default>;
> +		pinctrl-1 = <&wlan_pins_sleep>;
> +		reg = <2>;
> +		interrupt-parent = <&gpio4>;
> +		interrupts = <13 IRQ_TYPE_LEVEL_HIGH>;
> +	};
> +};

Thanks,
Sekhar
