From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 3/4] DTS: Pandora: fix panel compatibility string
Date: Thu, 09 Nov 2017 05:36:23 +0200
Message-ID: <1634573.IyLVzmLhWc@avalon>
References: <cover.1510175371.git.hns@goldelico.com> <444424119f30b6e1b1e56456b870e8492b9acad6.1510175371.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <444424119f30b6e1b1e56456b870e8492b9acad6.1510175371.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?ISO-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Julia Lawall <Julia.Lawall@lip6.fr>, Sean Paul <seanpaul@chromium.org>, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org, letux-kernel@openphoenux.org, kernel@pyra-handheld.com
List-Id: linux-omap@vger.kernel.org

Hi Nikolaus,

Thank you for the patch.

On Wednesday, 8 November 2017 23:09:31 EET H. Nikolaus Schaller wrote:
> We can remove the "omapdss," prefix.

I agree but you should explain why.

> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>  arch/arm/boot/dts/omap3-pandora-common.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/omap3-pandora-common.dtsi
> b/arch/arm/boot/dts/omap3-pandora-common.dtsi index
> 53e007abdc71..64d967ec8c58 100644
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


-- 
Regards,

Laurent Pinchart
