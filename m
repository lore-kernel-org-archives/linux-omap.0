From: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: AM33XX: Add usbss node
Date: Mon, 5 Nov 2012 12:07:45 +0100
Message-ID: <50979E01.4030203@ti.com>
References: <1352095204-29028-1-git-send-email-afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1352095204-29028-1-git-send-email-afzal-l0cyMroinI0@public.gmane.org>
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
To: Afzal Mohammed <afzal-l0cyMroinI0@public.gmane.org>
Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Santhapuri Damodar <damodar.santhapuri-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Ravi Babu <ravibabu-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

+ Felipe

Hi Afzal,

On 11/05/2012 06:59 AM, Afzal Mohammed wrote:
> From: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
> 
> Device tree node for usbss on AM33XX. There are two musb
> controllers on am33xx platform so have port0-mode and
> port1-mode data.
> 
> [afzal-l0cyMroinI0@public.gmane.org: reg & interrupt property addition]
> 
> Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Santhapuri, Damodar <damodar.santhapuri-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Ravi Babu <ravibabu-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Afzal Mohammed <afzal-l0cyMroinI0@public.gmane.org>
> ---
> 
> Hi Benoit,
> 
> This is based on your "for_3.8/dts" branch.
> 
> This is made on top of "usb: musb: am335x support"
> (http://marc.info/?l=linux-omap&m=135187391904863&w=2)
> and has been tested on Beagle Bone.

That looks good to me, I just like to get an Ack from Felipe for the
accuracy of the data part.

Regards,
Benoit


> 
> Regards
> Afzal
> 
>  arch/arm/boot/dts/am33xx.dtsi | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index 5dfd682..78340a5 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -321,5 +321,22 @@
>  			ti,hwmods = "spi1";
>  			status = "disabled";
>  		};
> +
> +		usb_otg_hs@47400000 {
> +			compatible = "ti,musb-am33xx";
> +			reg = <0x47400000 0x1000	/* usbss */
> +			       0x47401000 0x800		/* musb instance 0 */
> +			       0x47401800 0x800>;	/* musb instance 1 */
> +			interrupts = <17		/* usbss */
> +				      18		/* musb instance 0 */
> +				      19>;		/* musb instance 1 */
> +			multipoint = <1>;
> +			num-eps = <16>;
> +			ram-bits = <12>;
> +			port0-mode = <3>;
> +			port1-mode = <3>;
> +			power = <250>;
> +			ti,hwmods = "usb_otg_hs";
> +		};
>  	};
>  };
> 
