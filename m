From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCHv4 11/18] arm: dts: add omap4430 thermal data
Date: Fri, 27 Sep 2013 07:24:39 -0500
Message-ID: <20130927122439.GA8360@kahuna>
References: <1380251605-3804-1-git-send-email-eduardo.valentin@ti.com>
 <1380251605-3804-12-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1380251605-3804-12-git-send-email-eduardo.valentin@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, wni@nvidia.com, durgadoss.r@intel.com, ian.campbell@citrix.com, pawel.moll@arm.com, swarren@wwwdotorg.org, Tony Lindgren <tony@atomide.com>, devicetree-discuss@lists.ozlabs.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, rob.herring@calxeda.com, lm-sensors@lm-sensors.org, linux-arm-kernel@lists.infradead.org, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, grant.likely@linaro.org, Russell King <linux@arm.linux.org.uk>, rui.zhang@intel.com, linux-omap@vger.kernel.org, linux@roeck-us.net
List-Id: linux-omap@vger.kernel.org

On 23:13-20130926, Eduardo Valentin wrote:
> This patch changes the dtsi entry on omap4430 to contain
> the thermal data. This data will enable the passive
> cooling with CPUfreq cooling device at 100C and the
> system will do a thermal shutdown at 125C.
> =

> Cc: "Beno=EEt Cousson" <bcousson@baylibre.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: linux-omap@vger.kernel.org
> Cc: devicetree-discuss@lists.ozlabs.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
> ---
>  arch/arm/boot/dts/omap443x.dtsi | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> =

> diff --git a/arch/arm/boot/dts/omap443x.dtsi b/arch/arm/boot/dts/omap443x=
.dtsi
> index bcf455e..e9c97d6 100644
> --- a/arch/arm/boot/dts/omap443x.dtsi
> +++ b/arch/arm/boot/dts/omap443x.dtsi
> @@ -12,7 +12,7 @@
>  =

>  / {
>  	cpus {
> -		cpu@0 {
> +		cpu0: cpu@0 {
>  			/* OMAP443x variants OPP50-OPPNT */
>  			operating-points =3D <
>  				/* kHz    uV */
> @@ -25,9 +25,15 @@
>  		};
>  	};
>  =

> -	bandgap {
> +	thermal-zones{
> +		#include "omap4-cpu-thermal.dtsi"
> +	};
> +
> +	bandgap: bandgap {
>  		reg =3D <0x4a002260 0x4
>  		       0x4a00232C 0x4>;
>  		compatible =3D "ti,omap4430-bandgap";
> +
> +		#thermal-sensor-cells =3D <0>;
2 cents:
we might want to move bandgap under ocp?

>  	};
>  };
> -- =

> 1.8.2.1.342.gfa7285d
> =

> =

> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- =

Regards,
Nishanth Menon
