From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v7 5/5] ARM: dts: am437x-gp-evm: Update binding for
 touchscreen size
Date: Tue, 17 Jun 2014 02:50:36 -0700
Message-ID: <20140617095035.GQ17845@atomide.com>
References: <1402997507-9736-1-git-send-email-rogerq@ti.com>
 <1402997507-9736-6-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1402997507-9736-6-git-send-email-rogerq@ti.com>
Sender: linux-input-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: dmitry.torokhov@gmail.com, rydberg@euromail.se, balbi@ti.com, dmurphy@ti.com, mugunthanvnm@ti.com, nsekhar@ti.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Benoit Cousson <bcousson@baylibre.com>
List-Id: linux-omap@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [140617 02:33]:
> Update the bindings for touchscreen size.
> 
> CC: Benoit Cousson <bcousson@baylibre.com>
> CC: Tony Lindgren <tony@atomide.com>
> CC: Mugunthan V N <mugunthanvnm@ti.com>
> Signed-off-by: Roger Quadros <rogerq@ti.com>

This too:

Acked-by: Tony Lindgren <tony@atomide.com>

> ---
>  arch/arm/boot/dts/am437x-gp-evm.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
> index 003766c..2674132 100644
> --- a/arch/arm/boot/dts/am437x-gp-evm.dts
> +++ b/arch/arm/boot/dts/am437x-gp-evm.dts
> @@ -277,8 +277,8 @@
>  
>  		attb-gpio = <&gpio3 22 GPIO_ACTIVE_HIGH>;
>  
> -		x-size = <1024>;
> -		y-size = <600>;
> +		touchscreen-size-x = <1024>;
> +		touchscreen-size-y = <600>;
>  	};
>  };
>  
> -- 
> 1.8.3.2
> 
