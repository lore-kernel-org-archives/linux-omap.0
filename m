From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] ARM: dts: add dtsi for palmas
Date: Fri, 07 Jun 2013 13:56:05 -0600
Message-ID: <51B23AD5.8060006@wwwdotorg.org>
References: <1370604504-32310-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1370604504-32310-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: J Keerthy <j-keerthy@ti.com>
Cc: b-cousson@ti.com, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, ldewangan@nvidia.com, grant.likely@secretlab.ca, swarren@nvidia.com, sameo@linux.intel.com, gg@slimlogic.co.uk, lee.jones@linaro.org
List-Id: linux-omap@vger.kernel.org

On 06/07/2013 05:28 AM, J Keerthy wrote:
> Adds palmas mfd and palmas regulator nodes. This is
> based on the patch series:
> 
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg89957.html
> 
> The device tree nodes are based on:
> https://lkml.org/lkml/2013/6/6/25

> diff --git a/arch/arm/boot/dts/palmas.dtsi b/arch/arm/boot/dts/palmas.dtsi

> +&palmas {

Hmmm. That (i.e. requiring the board file to declare the node, then
setting up all the content by later including this file) is an
interesting approach. I guess it's reasonable. The one issue is that it
makes it a little harder for the board file to override any of the
properties in this file., although it certainly is possible by including
those overrides after the include.

Irrespective of that, some comments on this:

> +	palmas_pmic {

> +		ti,ldo6-vibrator;

For example, what if the board doesn't want to have the property set?

> +
> +		regulators {
> +			smps123_reg: smps123 {
> +				regulator-name = "smps123";
> +				regulator-min-microvolt = < 600000>;
> +				regulator-max-microvolt = <1500000>;

Or what if the board wants to limit the voltage range of this regulator
due to what it's used for on the board.

> +				regulator-always-on;
> +				regulator-boot-on;

And those two properties are almost certainly board-specific policy.
