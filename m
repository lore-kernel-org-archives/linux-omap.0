From: "AnilKumar, Chimata" <anilkumar-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 5/5] of: Modify c_can binding documentation
Date: Sat, 1 Sep 2012 07:05:58 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA234C7@DBDE01.ent.ti.com>
References: <1346405361-29711-1-git-send-email-anilkumar@ti.com>
 <1346405361-29711-6-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1346405361-29711-6-git-send-email-anilkumar-l0cyMroinI0@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: "mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org" <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, "bryan.wu-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org" <bryan.wu-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Marc,

On Fri, Aug 31, 2012 at 14:59:21, AnilKumar, Chimata wrote:
> Modify c_can binding documentation according to recent review comments
> on device tree data addition patches.
> 
> Signed-off-by: AnilKumar Ch <anilkumar-l0cyMroinI0@public.gmane.org>
> ---
>  .../devicetree/bindings/net/can/c_can.txt          |   25 ++++++++++++++++----
>  1 file changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/can/c_can.txt b/Documentation/devicetree/bindings/net/can/c_can.txt
> index a43f083..90a70be 100644
> --- a/Documentation/devicetree/bindings/net/can/c_can.txt
> +++ b/Documentation/devicetree/bindings/net/can/c_can.txt
> @@ -8,6 +8,8 @@ Required properties:
>  			  registers map
>  - interrupts		: property with a value describing the interrupt
>  			  number
> +- status		: describes the node status either "disabled" or
> +			  "okay"
>  
>  Optional properties:
>  - interrupt-parent	: The parent interrupt controller
> @@ -20,18 +22,31 @@ Future plan is to migrate hwmod data base contents into device tree
>  blob so that, all the required data will be used from device tree dts
>  file.
>  
> -Examples:
> +Example:
>  
> -	d_can@481D0000 {
> +Step1: SoC common .dtsi file
> +
> +	d_can1: d_can@481d0000 {
>  		compatible = "bosch,d_can";
> -		reg = <0x481D0000 0x1000>;
> -		interrupts = <55 0x4>;
> +		reg = <0x481d0000 0x2000>;
> +		interrupts = <55>;
>  		interrupt-parent = <&intc>;
> +		status = "disabled";
>  	};
>  
>  (or)
>  
> -	d_can@481D0000 {
> +	d_can1: d_can@481d0000 {
>  		compatible = "bosch,d_can";
>  		ti,hwmods = "d_can1";
> +		reg = <0x481d0000 0x2000>;
> +		interrupts = <55>;
> +		interrupt-parent = <&intc>;
> +		status = "disabled";
> +	};
> +
> +Step 2: board specific .dts file
> +
> +	&dcan1 {
> +		status = "okay";
>  	};
> -- 
> 1.7.9.5
> 
> 

Can you review this patch and push it to linux-can tree?
Because initial version of this file c_can.txt is in
linux-can tree.

Thanks
AnilKumar
