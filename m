From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 10/19] arm: dts: add cooling properties on omap4430 cpu
 node
Date: Tue, 6 May 2014 08:20:08 -0700
Message-ID: <20140506152007.GC18474@atomide.com>
References: <1395744572-20014-1-git-send-email-alex.shi@linaro.org>
 <1395744572-20014-11-git-send-email-alex.shi@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1395744572-20014-11-git-send-email-alex.shi@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Shi <alex.shi@linaro.org>
Cc: mark.hambleton@broadcom.com, mark.brown@linaro.org, eduardo.valentin@ti.com, mporter@linaro.org, lsk-interest@linaro.org, linaro-kernel@linaro.org, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Alex Shi <alex.shi@linaro.org> [140325 03:54]:
> From: Eduardo Valentin <eduardo.valentin@ti.com>
>=20
> OMAP4430 devices can reach high temperatures and thus
> needs to have cpufreq-cooling on systems running on it.
>=20
> This patch adds the required cooling device properties
> so that cpufreq-cpu0 driver loads the cooling device.

Alex, what's the status of this series? I could not find
the complete thread, so wondering what to do with patches
09 - 13?

Regards,

Tony
=20
> Cc: "Beno=C3=AEt Cousson" <bcousson@baylibre.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: linux-omap@vger.kernel.org
> Cc: devicetree-discuss@lists.ozlabs.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
> (cherry picked from commit 72af5e6d0c3e01655c1c1fc7c7ca94a2b663611e)
>=20
> Signed-off-by: Alex Shi <alex.shi@linaro.org>
> ---
>  arch/arm/boot/dts/omap443x.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/omap443x.dtsi b/arch/arm/boot/dts/omap=
443x.dtsi
> index cccf39a..d2deba0 100644
> --- a/arch/arm/boot/dts/omap443x.dtsi
> +++ b/arch/arm/boot/dts/omap443x.dtsi
> @@ -22,6 +22,11 @@
>  				1008000 1375000
>  			>;
>  			clock-latency =3D <300000>; /* From legacy driver */
> +
> +			/* cooling options */
> +			cooling-min-level =3D <0>;
> +			cooling-max-level =3D <3>;
> +			#cooling-cells =3D <2>; /* min followed by max */
>  		};
>  	};
>  };
> --=20
> 1.8.1.2
>=20
