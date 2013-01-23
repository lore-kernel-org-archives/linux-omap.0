From: "Philip, Avinash" <avinashphilip-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 1/3] ARM: dts: AM33XX: Add ELM node
Date: Wed, 23 Jan 2013 06:32:15 +0000
Message-ID: <518397C60809E147AF5323E0420B992E3EA62B2D@DBDE01.ent.ti.com>
References: <1358491295-4022-1-git-send-email-avinashphilip@ti.com>
 <1358491295-4022-2-git-send-email-avinashphilip@ti.com>
 <877gn69sb9.fsf@dell.be.48ers.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <877gn69sb9.fsf-D6SC8u56vOOJDPpyT6T3/w@public.gmane.org>
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
To: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
Cc: "linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org" <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Hebbar,
 Gururaja" <gururaja.hebbar-l0cyMroinI0@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Jan 22, 2013 at 02:17:38, Peter Korsgaard wrote:
> >>>>> "Philip" == Philip Avinash <avinashphilip-l0cyMroinI0@public.gmane.org> writes:
> 
>  Philip> From: "Philip, Avinash" <avinashphilip-l0cyMroinI0@public.gmane.org>
>  Philip> Add ELM data node to AM33XX device tree file.
> 
>  Philip> Signed-off-by: Philip Avinash <avinashphilip-l0cyMroinI0@public.gmane.org>
>  Philip> ---
>  Philip>  arch/arm/boot/dts/am33xx.dtsi |    8 ++++++++
>  Philip>  1 file changed, 8 insertions(+)
> 
>  Philip> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
>  Philip> index c2f14e8..eaef5e7 100644
>  Philip> --- a/arch/arm/boot/dts/am33xx.dtsi
>  Philip> +++ b/arch/arm/boot/dts/am33xx.dtsi
>  Philip> @@ -385,5 +385,13 @@
>  Philip>  				mac-address = [ 00 00 00 00 00 00 ];
>  Philip>  			};
>  Philip>  		};
>  Philip> +
>  Philip> +		elm: elm@48080000 {
>  Philip> +			compatible	= "ti,am33xx-elm";
> 
> Please drop the <tab> after compatible.

I will replace with space and submit another version

> 
> Other than that it looks goood.
> 
> Acked-by: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>

Thanks
Avinash

> 
> -- 
> Bye, Peter Korsgaard
> 
