From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 4/4] DTS: Pandora: fix panel compatibility string
Date: Tue, 28 Nov 2017 08:04:37 -0800
Message-ID: <20171128160437.GD28152@atomide.com>
References: <cover.1511884135.git.hns@goldelico.com>
 <b6001c7b7fb98e7a3ad4c712084fea9dae9e6b27.1511884135.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b6001c7b7fb98e7a3ad4c712084fea9dae9e6b27.1511884135.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Russell King <linux@armlinux.org.uk>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Julia Lawall <Julia.Lawall@lip6.fr>, Sean Paul <seanpaul@chromium.org>, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org, letux-kernel@openphoenux.org, kernel@pyra-handheld.com
List-Id: linux-omap@vger.kernel.org

* H. Nikolaus Schaller <hns@goldelico.com> [171128 15:52]:
> We can remove the unnecessary "omapdss," prefix because
> the omapdrm driver takes care of it when matching with
> the driver table.

So is this needed as a fix or is this another clean-up?

So is this is really needed as a fix?

If this is just clean-up, again, please resend once the driver
changes have cleared.

Regards,

Tony

> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>  arch/arm/boot/dts/omap3-pandora-common.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/omap3-pandora-common.dtsi b/arch/arm/boot/dts/omap3-pandora-common.dtsi
> index 53e007abdc71..64d967ec8c58 100644
> --- a/arch/arm/boot/dts/omap3-pandora-common.dtsi
> +++ b/arch/arm/boot/dts/omap3-pandora-common.dtsi
> @@ -626,7 +626,7 @@
>  
>  	lcd: lcd@1 {
>  		reg = <1>;	/* CS1 */
> -		compatible =	"omapdss,tpo,td043mtea1";
> +		compatible =	"tpo,td043mtea1";
>  		spi-max-frequency = <100000>;
>  		spi-cpol;
>  		spi-cpha;
> -- 
> 2.12.2
> 
