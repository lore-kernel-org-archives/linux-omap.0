From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] dts: omap3-n900: cleanup english
Date: Wed, 7 Jan 2015 15:46:10 -0800
Message-ID: <20150107234610.GJ13010@atomide.com>
References: <20141207161147.GA18588@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20141207161147.GA18588@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: bcousson@baylibre.com, robh+dt@kernel.org, trivial@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [141207 08:14]:
> This fixes english in comments and removes extra empty newline.
> 
> Signed-off-by: Pavel Machek <pavel@ucw.cz>

Applying into omap-for-v3.20/dt thanks.

Tony
 
> diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
> index 11d8afd..9e0e5a2 100644
> --- a/arch/arm/boot/dts/omap3-n900.dts
> +++ b/arch/arm/boot/dts/omap3-n900.dts
> @@ -287,7 +287,7 @@
>  	regulator-name = "V28";
>  	regulator-min-microvolt = <2800000>;
>  	regulator-max-microvolt = <2800000>;
> -	regulator-always-on; /* due battery cover sensor */
> +	regulator-always-on; /* due to battery cover sensor */
>  };
>  
>  &vaux2 {
> @@ -345,7 +345,6 @@
>  	regulator-name = "VIO";
>  	regulator-min-microvolt = <1800000>;
>  	regulator-max-microvolt = <1800000>;
> -
>  };
>  
>  &vintana1 {
> 
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
> 
