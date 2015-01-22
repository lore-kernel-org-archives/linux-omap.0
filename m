From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 12/13] ARM: dts: omap3-gta04: uart4 is not connected, so
 mark it "disabled"
Date: Thu, 22 Jan 2015 13:40:53 -0800
Message-ID: <20150122214052.GY7718@atomide.com>
References: <1421959099-28319-1-git-send-email-marek@goldelico.com>
 <1421959099-28319-13-git-send-email-marek@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.ore.mailhop.org ([54.68.34.165]:56406 "EHLO
	smtp1.ore.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754554AbbAVVoQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Jan 2015 16:44:16 -0500
Content-Disposition: inline
In-Reply-To: <1421959099-28319-13-git-send-email-marek@goldelico.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Marek Belisko <marek@goldelico.com>
Cc: bcousson@baylibre.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, hns@goldelico.com, neilb@suse.de, NeilBrown <neil@brown.name>

* Marek Belisko <marek@goldelico.com> [150122 12:42]:
> From: NeilBrown <neil@brown.name>
> 
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  arch/arm/boot/dts/omap3-gta04.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
> index 228e79b..8d2b0a1 100644
> --- a/arch/arm/boot/dts/omap3-gta04.dtsi
> +++ b/arch/arm/boot/dts/omap3-gta04.dtsi
> @@ -357,6 +357,10 @@
>  	pinctrl-0 = <&uart3_pins>;
>  };
>  
> +&uart4 {
> +	status = "disabled";
> +};
> +

This you probably want to avoid from PM point of view. Depending on
bootloader state of uart4, Linux may or may not be able to hit any
deeper power states.

Marking something with status = "disabled" in dts causes the device
entry not even to be created. That means hwmod won't be able to reset
and idle this device during boot.

The uart4 device is there for sure even if not muxed and in incomplete
state. You may want to also check other places where you're using
status = "disabled" for the same reasons.

Regards,

Tony
