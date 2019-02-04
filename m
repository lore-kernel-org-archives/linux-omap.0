From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/4] ARM: dts: dra7: add PRU-ICSS modules
Date: Mon, 4 Feb 2019 10:03:59 -0800
Message-ID: <20190204180359.GM5720@atomide.com>
References: <1549295637-24890-1-git-send-email-rogerq@ti.com>
 <1549295637-24890-4-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1549295637-24890-4-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: s-anna@ti.com, nsekhar@ti.com, linux-omap@vger.kernel.org, t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com, m-karicheri2@ti.com, david@lechnology.com, woods.technical@gmail.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [190204 15:54]:
> --- a/arch/arm/boot/dts/dra7.dtsi
> +++ b/arch/arm/boot/dts/dra7.dtsi
> @@ -167,6 +167,200 @@
>  		l4_per3: interconnect@48800000 {
>  		};
>  
> +		pru_icss1: target-module@4b200000 {

I suggest you add these into dra7-pruss.dtsi as they
have internal interconnects. And eventually some of
the *pruss.dtsi files might become shared :) And we
avoid moving these around when we define the l3
interconnects and avoid a lot of extra long dtsi
line lengths with the added nestedness later on.

Regards,

Tony
