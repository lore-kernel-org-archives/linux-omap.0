From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [RFC/PATCH v2 10/13] dt: omap4: panda board: set clock freq for
 i2c devices
Date: Tue, 23 Aug 2011 21:03:55 +0200
Message-ID: <4E53F99B.3060308@ti.com>
References: <1314074021-25186-11-git-send-email-manjugk@ti.com> <4E537F6B.4060608@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:32817 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754873Ab1HWTEJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Aug 2011 15:04:09 -0400
In-Reply-To: <4E537F6B.4060608@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel@lis

> From: G, Manjunath Kondaiah<manjugk@ti.com>
> To: devicetree-discuss@lists.ozlabs.org
> CC: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
>
>
> Update omap4 panda dts file with required clock frequencies
> for the i2c client devices existing on panda board.
>
> Signed-off-by: G, Manjunath Kondaiah<manjugk@ti.com>
> ---
>    arch/arm/boot/dts/omap4-panda.dts |   16 ++++++++++++++++
>    1 files changed, 16 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/boot/dts/omap4-panda.dts
> b/arch/arm/boot/dts/omap4-panda.dts
> index c28aa95..6b831ca 100644
> --- a/arch/arm/boot/dts/omap4-panda.dts
> +++ b/arch/arm/boot/dts/omap4-panda.dts
> @@ -3,4 +3,20 @@
>    / {
>    	model = "TI OMAP4 PandaBoard";
>    	compatible = "ti,omap4-panda", "ti,omap4430";
> +
> +	i2c1 {
> +		clock-frequency =<400000>;
> +	};
> +
> +	i2c2 {
> +		clock-frequency =<400000>;
> +	};
> +
> +	i2c3 {
> +		clock-frequency =<400000>;
> +	};
> +
> +	i2c4 {
> +		clock-frequency =<400000>;
> +	};
>    };

Are you sure that this patch is setting the expected frequency?
I see 100kHz in the boot log even with that patch.

I took me some time to find the proper syntax, but in order to reference 
an existing node, you have to use &i2c1 at the top level of the file. If 
you check the output of the DTC compiler, you will see the property at 
the proper node.

Benoit

