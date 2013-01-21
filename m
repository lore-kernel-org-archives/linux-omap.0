From: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
Subject: Re: [PATCH 2/3] ARM: dts: AM33XX: Add GPMC node
Date: Mon, 21 Jan 2013 22:01:53 +0100
Message-ID: <8738xu9rni.fsf@dell.be.48ers.dk>
References: <1358491295-4022-1-git-send-email-avinashphilip@ti.com>
 <1358491295-4022-3-git-send-email-avinashphilip@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1358491295-4022-3-git-send-email-avinashphilip-l0cyMroinI0@public.gmane.org> (Philip
 Avinash's message of "Fri, 18 Jan 2013 12:11:34 +0530")
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
To: Philip Avinash <avinashphilip-l0cyMroinI0@public.gmane.org>
Cc: linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gururaja.hebbar-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

>>>>> "Philip" == Philip Avinash <avinashphilip-l0cyMroinI0@public.gmane.org> writes:

 Philip> From: "Philip, Avinash" <avinashphilip-l0cyMroinI0@public.gmane.org>
 Philip> Add GPMC data node to AM33XX device tree file.

 Philip> Signed-off-by: Philip Avinash <avinashphilip-l0cyMroinI0@public.gmane.org>
 Philip> ---
 Philip>  arch/arm/boot/dts/am33xx.dtsi |   12 ++++++++++++
 Philip>  1 file changed, 12 insertions(+)

 Philip> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
 Philip> index eaef5e7..f4209d8 100644
 Philip> --- a/arch/arm/boot/dts/am33xx.dtsi
 Philip> +++ b/arch/arm/boot/dts/am33xx.dtsi
 Philip> @@ -393,5 +393,17 @@
 Philip>  			ti,hwmods = "elm";
 Philip>  			status = "disabled";
 Philip>  		};
 Philip> +
 Philip> +		gpmc: gpmc@50000000 {
 Philip> +			compatible = "ti,am3352-gpmc";
 Philip> +			ti,hwmods = "gpmc";
 Philip> +			reg = <0x50000000 0x2000>;
 Philip> +			interrupts = <100>;
 Philip> +			num-cs = <8>;

Next to Jan's comment about am335x having 7 cs signals, I just realized
the difference in compatible string between the gpmc and elm. The gpmc
refers to a real device (which is afaik how it should be done), but the
elm compatible is simply ti,am33xx-elm.

Presumably it should have been ti,am3352-elm in the binding instead?

Other than that it looks fine.

Acked-by: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>

-- 
Bye, Peter Korsgaard
