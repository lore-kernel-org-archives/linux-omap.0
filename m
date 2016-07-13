From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH 1/2] ARM: dts: am335x: Update elm phandle binding
Date: Wed, 13 Jul 2016 10:14:07 -0700
Message-ID: <20160713171407.GB136972@google.com>
References: <1467711150-23356-1-git-send-email-t.remmet@phytec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1467711150-23356-1-git-send-email-t.remmet@phytec.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Teresa Remmet <t.remmet@phytec.de>
Cc: Mark Rutland <mark.rutland@arm.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Tony Lindgren <tony@atomide.com>, Richard Weinberger <richard@nod.at>, Rob Herring <robh+dt@kernel.org>, linux-mtd@lists.infradead.org, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, linux-omap@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

On Tue, Jul 05, 2016 at 11:32:29AM +0200, Teresa Remmet wrote:
> The check for the "elm_id" binding had been removed.
> This causes nand boot to fail on boards still using
> the old binding. Update the bindings on those boards.

Acked-by: Brian Norris <computersforpeace@gmail.com>

We're fixing the backward compatibility issue anyway, but might as well
"upgrade" the device tree.

> Signed-off-by: Teresa Remmet <t.remmet@phytec.de>
> ---
>  arch/arm/boot/dts/am335x-baltos.dtsi      | 2 +-
>  arch/arm/boot/dts/am335x-igep0033.dtsi    | 2 +-
>  arch/arm/boot/dts/am335x-phycore-som.dtsi | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/am335x-baltos.dtsi b/arch/arm/boot/dts/am335x-baltos.dtsi
> index c8609d8..b689172 100644
> --- a/arch/arm/boot/dts/am335x-baltos.dtsi
> +++ b/arch/arm/boot/dts/am335x-baltos.dtsi
> @@ -226,7 +226,7 @@
>  
>  		#address-cells = <1>;
>  		#size-cells = <1>;
> -		elm_id = <&elm>;
> +		ti,elm-id = <&elm>;
>  	};
>  };
>  
> diff --git a/arch/arm/boot/dts/am335x-igep0033.dtsi b/arch/arm/boot/dts/am335x-igep0033.dtsi
> index df63484..e7d9ca1 100644
> --- a/arch/arm/boot/dts/am335x-igep0033.dtsi
> +++ b/arch/arm/boot/dts/am335x-igep0033.dtsi
> @@ -161,7 +161,7 @@
>  
>  		#address-cells = <1>;
>  		#size-cells = <1>;
> -		elm_id = <&elm>;
> +		ti,elm-id = <&elm>;
>  
>  		/* MTD partition table */
>  		partition@0 {
> diff --git a/arch/arm/boot/dts/am335x-phycore-som.dtsi b/arch/arm/boot/dts/am335x-phycore-som.dtsi
> index 86f7731..1263c9d 100644
> --- a/arch/arm/boot/dts/am335x-phycore-som.dtsi
> +++ b/arch/arm/boot/dts/am335x-phycore-som.dtsi
> @@ -197,7 +197,7 @@
>  		gpmc,wr-access-ns = <30>;
>  		gpmc,wr-data-mux-bus-ns = <0>;
>  
> -		elm_id = <&elm>;
> +		ti,elm-id = <&elm>;
>  
>  		#address-cells = <1>;
>  		#size-cells = <1>;
> -- 
> 1.9.1
> 
