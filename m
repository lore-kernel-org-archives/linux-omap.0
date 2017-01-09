From: David Lechner <david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org>
Subject: Re: [PATCH 3/3] ARM: dts: da850: Enable cppi41 dma for da850-lcdk
Date: Mon, 9 Jan 2017 11:47:35 -0600
Message-ID: <7b716770-f86a-4328-dda8-c48c78f9989c@lechnology.com>
References: <20170109162449.5012-1-abailon@baylibre.com>
 <20170109162449.5012-4-abailon@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170109162449.5012-4-abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, nsekhar-l0cyMroinI0@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
Cc: vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 01/09/2017 10:24 AM, Alexandre Bailon wrote:
> This enable the cppi41 dma controller used by the usb otg for
> the da850-lcdk board.
>
> Signed-off-by: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
> ---
>  arch/arm/boot/dts/da850-lcdk.dts | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm/boot/dts/da850-lcdk.dts b/arch/arm/boot/dts/da850-lcdk.dts
> index afcb482..abb9b9d 100644
> --- a/arch/arm/boot/dts/da850-lcdk.dts
> +++ b/arch/arm/boot/dts/da850-lcdk.dts
> @@ -167,6 +167,10 @@
>  	status = "okay";
>  };
>
> +&cppi41dma  {

nit, there should only be one space before "{"

> +	status = "okay";
> +};
> +
>  &aemif {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&nand_pins>;
>

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
