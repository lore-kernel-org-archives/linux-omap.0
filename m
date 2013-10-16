From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 1/2] ARM: dts: omap5-uevm: remove always_on, boot_on from
 smps10_out1
Date: Wed, 16 Oct 2013 18:47:58 +0530
Message-ID: <525E9206.9010501@ti.com>
References: <1381402195-29257-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1381402195-29257-1-git-send-email-kishon@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kishon Vijay Abraham I <kishon@ti.com>, bcousson@baylibre.com
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, linux@arm.linux.org.uk, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, tony@atomide.com, swarren@wwwdotorg.org, linux-kernel@vger.kernel.org, rob.herring@calxeda.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Benoit,

On Thursday 10 October 2013 04:19 PM, Kishon Vijay Abraham I wrote:
> smps10 should be enabled only in the case of host mode. So stop
> doing always_on, boot_on from smps10_out1. The driver will enable it in host
> mode.

Can you take this patch too?

Thanks
Kishon
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  arch/arm/boot/dts/omap5-uevm.dts |    2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
> index d784b3a..e06a04a 100644
> --- a/arch/arm/boot/dts/omap5-uevm.dts
> +++ b/arch/arm/boot/dts/omap5-uevm.dts
> @@ -334,8 +334,6 @@
>  					regulator-name = "smps10_out1";
>  					regulator-min-microvolt = <5000000>;
>  					regulator-max-microvolt = <5000000>;
> -					regulator-always-on;
> -					regulator-boot-on;
>  				};
>  
>  				ldo1_reg: ldo1 {
> 
