From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: Fix the name of supplies for smsc911x shared
 by OMAP
Date: Mon, 2 Dec 2013 11:29:26 -0800
Message-ID: <20131202192925.GK26766@atomide.com>
References: <1385988782-21731-1-git-send-email-florian.vaussard@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:46037 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753800Ab3LBT33 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Dec 2013 14:29:29 -0500
Content-Disposition: inline
In-Reply-To: <1385988782-21731-1-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Florian Vaussard <florian.vaussard@epfl.ch>
Cc: Benoit Cousson <bcousson@baylibre.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org

* Florian Vaussard <florian.vaussard@epfl.ch> [131202 04:54]:
> drivers/net/ethernet/smsc/smsc911x.c is expecting supplies named
> "vdd33a" and "vddvario". Currently the shared DTS file provides
> "vmmc" and "vmmc_aux", and the supply lookup will fail:
> 
> smsc911x 2c000000.ethernet: Looking up vdd33a-supply from device tree
> smsc911x 2c000000.ethernet: Looking up vdd33a-supply property in node /ocp/gpmc@6e000000/ethernet@gpmc failed
> smsc911x 2c000000.ethernet: Looking up vddvario-supply from device tree
> smsc911x 2c000000.ethernet: Looking up vddvario-supply property in node /ocp/gpmc@6e000000/ethernet@gpmc failed
> 
> Fix it!
> 
> Tested on OMAP3 Overo platform.

OK, looks like we've had it wrong from the start as I just moved it from
the omap3-igep0020.dts file :) Applying into omap-for-v3.14/fixes-take4

Regards,

Tony
 
> Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
> ---
>  arch/arm/boot/dts/omap-gpmc-smsc911x.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/omap-gpmc-smsc911x.dtsi b/arch/arm/boot/dts/omap-gpmc-smsc911x.dtsi
> index 9c18adf..f577b7d 100644
> --- a/arch/arm/boot/dts/omap-gpmc-smsc911x.dtsi
> +++ b/arch/arm/boot/dts/omap-gpmc-smsc911x.dtsi
> @@ -44,8 +44,8 @@
>  		gpmc,wr-access-ns = <186>;
>  		gpmc,cycle2cycle-samecsen;
>  		gpmc,cycle2cycle-diffcsen;
> -		vmmc-supply = <&vddvario>;
> -		vmmc_aux-supply = <&vdd33a>;
> +		vddvario-supply = <&vddvario>;
> +		vdd33a-supply = <&vdd33a>;
>  		reg-io-width = <4>;
>  		smsc,save-mac-address;
>  	};
> -- 
> 1.8.1.2
> 
