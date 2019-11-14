From: Tony Lindgren <tony@atomide.com>
Subject: Re: [uL PATCH 2/2] ARM: dts: am5729: beaglebone-ai: dra7 reqs in dts
Date: Thu, 14 Nov 2019 08:46:51 -0800
Message-ID: <20191114164651.GO5610@atomide.com>
References: <20191113221345.4795-1-c-robey@ti.com>
 <20191113221345.4795-3-c-robey@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191113221345.4795-3-c-robey@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Caleb Robey <c-robey@ti.com>
Cc: linux-patch-review@list.ti.com, Jason Kridner <jkridner@gmail.com>, Lokesh Vutla <lokeshvutla@ti.com>, Jason Kridner <jdk@ti.com>, Faiz Abbas <faiz_abbas@ti.com>, Andreas Dannenberg <dannenberg@ti.com>, Jean-Jacques Hiblot <jjhiblot@ti.com>, Praneeth Bajjuri <praneeth@ti.com>, "Andrew F . Davis" <afd@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Caleb Robey <c-robey@ti.com> [191113 22:15]:
> Small nomenclature change for beaglebone AI compatibility.
> 
> Signed-off-by: Jason Kridner <jdk@ti.com>

Hmm so should this patch be also "From: Jason Kridner <jdk@ti.com>"
if Jason's patch?

If so, please resend, and since you're the one sending it, please
also add your Signed-off-by.

Thanks,

Tony

>  arch/arm/boot/dts/dra7.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
> index 953f0ffce2a9..563d64c69fd4 100644
> --- a/arch/arm/boot/dts/dra7.dtsi
> +++ b/arch/arm/boot/dts/dra7.dtsi
> @@ -143,7 +143,7 @@
>  	 * the moment, just use a fake OCP bus entry to represent the whole bus
>  	 * hierarchy.
>  	 */
> -	ocp {
> +	ocp: ocp {
>  		compatible = "ti,dra7-l3-noc", "simple-bus";
>  		#address-cells = <1>;
>  		#size-cells = <1>;
> -- 
> 2.17.1
> 
