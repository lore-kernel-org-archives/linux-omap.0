From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [RFC/PATCH 12/14] dt: omap3: beagle board: set clock freq for
	i2c devices
Date: Wed, 10 Aug 2011 14:42:56 +0200
Message-ID: <4E427CD0.7060206@ti.com>
References: <1312897232-4792-1-git-send-email-manjugk@ti.com>
	<1312897232-4792-13-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1312897232-4792-13-git-send-email-manjugk@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On 8/9/2011 4:10 PM, G, Manjunath Kondaiah wrote:
>
> Update omap3 beagle dts file with required clock frequencies for the i2c
> client devices existing on beagle board.
>
> Beagle custom board dts file is cleaned up so that it can coexist with omap3
> soc dts file.
>
> Signed-off-by: G, Manjunath Kondaiah<manjugk@ti.com>
> ---
>   arch/arm/boot/dts/omap3-beagle-nunchuck.dts |   11 +----------
>   arch/arm/boot/dts/omap3-beagle.dts          |   18 +++++++++++++++---
>   2 files changed, 16 insertions(+), 13 deletions(-)
>
> diff --git a/arch/arm/boot/dts/omap3-beagle-nunchuck.dts b/arch/arm/boot/dts/omap3-beagle-nunchuck.dts
> index 2607be5..324ff86 100644
> --- a/arch/arm/boot/dts/omap3-beagle-nunchuck.dts
> +++ b/arch/arm/boot/dts/omap3-beagle-nunchuck.dts
> @@ -1,16 +1,7 @@
>   /include/ "omap3-beagle.dts"
>
>   / {
> -	i2c@48072000 {
> -		compatible = "ti,omap3-i2c";
> -		reg =<0x48072000 0x80>;
> -		#address-cells =<1>;
> -		#size-cells =<0>;
> -
> -		eeprom@50 {
> -			compatible = "at,at24c01";
> -			reg =<  0x50>;
> -		};

This change should probably not be there.

> +	i2c@2 {
>   		joystick@52 {
>   			compatible = "sparkfun,wiichuck";

It looks like someone is having fun with a beagle connected to a Wii 
nunchuck:-)

>   			reg =<  0x52>;
> diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
> index 4439466..49a5ac7 100644
> --- a/arch/arm/boot/dts/omap3-beagle.dts
> +++ b/arch/arm/boot/dts/omap3-beagle.dts
> @@ -1,7 +1,19 @@
> -/dts-v1/;
> -/include/ "skeleton.dtsi"
> +/include/ "omap3-soc.dtsi"

There is no need for the "-soc" postfix, otherwise all the other SoCs 
inside DTS directory should have it.

Benoit
