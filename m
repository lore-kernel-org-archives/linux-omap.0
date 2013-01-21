From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [PATCH 1/3] ARM: dts: AM33XX: Add ELM node
Date: Mon, 21 Jan 2013 21:47:38 +0100
Message-ID: <877gn69sb9.fsf@dell.be.48ers.dk>
References: <1358491295-4022-1-git-send-email-avinashphilip@ti.com>
	<1358491295-4022-2-git-send-email-avinashphilip@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1358491295-4022-2-git-send-email-avinashphilip@ti.com> (Philip
	Avinash's message of "Fri, 18 Jan 2013 12:11:33 +0530")
Sender: linux-kernel-owner@vger.kernel.org
To: Philip Avinash <avinashphilip@ti.com>
Cc: b-cousson@ti.com, tony@atomide.com, linux@arm.linux.org.uk, devicetree-discuss@lists.ozlabs.org, nsekhar@ti.com, linux-kernel@vger.kernel.org, gururaja.hebbar@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

>>>>> "Philip" == Philip Avinash <avinashphilip@ti.com> writes:

 Philip> From: "Philip, Avinash" <avinashphilip@ti.com>
 Philip> Add ELM data node to AM33XX device tree file.

 Philip> Signed-off-by: Philip Avinash <avinashphilip@ti.com>
 Philip> ---
 Philip>  arch/arm/boot/dts/am33xx.dtsi |    8 ++++++++
 Philip>  1 file changed, 8 insertions(+)

 Philip> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
 Philip> index c2f14e8..eaef5e7 100644
 Philip> --- a/arch/arm/boot/dts/am33xx.dtsi
 Philip> +++ b/arch/arm/boot/dts/am33xx.dtsi
 Philip> @@ -385,5 +385,13 @@
 Philip>  				mac-address = [ 00 00 00 00 00 00 ];
 Philip>  			};
 Philip>  		};
 Philip> +
 Philip> +		elm: elm@48080000 {
 Philip> +			compatible	= "ti,am33xx-elm";

Please drop the <tab> after compatible.

Other than that it looks goood.

Acked-by: Peter Korsgaard <jacmet@sunsite.dk>

-- 
Bye, Peter Korsgaard
