From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v4 1/2] DTS: GTA04: improve panel compatibility string
Date: Mon, 11 Dec 2017 07:22:03 -0800
Message-ID: <20171211152203.GH24344@atomide.com>
References: <cover.1512114082.git.hns@goldelico.com>
 <280160905017f67c91b96bf38ea9b6094ec277c3.1512114082.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <280160905017f67c91b96bf38ea9b6094ec277c3.1512114082.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Russell King <linux@armlinux.org.uk>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Julia Lawall <Julia.Lawall@lip6.fr>, Sean Paul <seanpaul@chromium.org>, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org, letux-kernel@openphoenux.org, kernel@pyra-handheld.com
List-Id: linux-omap@vger.kernel.org

* H. Nikolaus Schaller <hns@goldelico.com> [171201 07:44]:
> Official vendor string is now "tpo" and not "toppoly".
> 
> Requires patch "omapdrm: panel: fix compatible vendor string for td028ttec1"
> so that the driver understands both.

Tomi, so what's the plan with the dependency patch, is that for v4.16
or for the v4.15-rc cycle?

Regards,

Tony



> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>  arch/arm/boot/dts/omap3-gta04.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
> index 4504908c23fe..ec27ed67a22a 100644
> --- a/arch/arm/boot/dts/omap3-gta04.dtsi
> +++ b/arch/arm/boot/dts/omap3-gta04.dtsi
> @@ -86,7 +86,7 @@
>  
>  		/* lcd panel */
>  		lcd: td028ttec1@0 {
> -			compatible = "toppoly,td028ttec1";
> +			compatible = "tpo,td028ttec1";
>  			reg = <0>;
>  			spi-max-frequency = <100000>;
>  			spi-cpol;
> -- 
> 2.12.2
> 
