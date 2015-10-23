From: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 5/5] Add information about the new DT device name
Date: Fri, 23 Oct 2015 22:40:48 +0300
Message-ID: <562A8D40.90101@cogentembedded.com>
References: <562A557B.4090501@imms.de> <562A58DF.5020706@imms.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <562A58DF.5020706-cSCHQGRfioA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rolf Peukert <rolf.peukert-cSCHQGRfioA@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hello.

On 10/23/2015 06:57 PM, Rolf Peukert wrote:

> Add some information about the new device name to the DT documentation.
>
> Signed-off-by: Rolf Peukert <rolf.peukert-cSCHQGRfioA@public.gmane.org>
> ---
>   Documentation/devicetree/bindings/usb/omap-usb.txt | 35
> ++++++++++++++++++++++
>   1 file changed, 35 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/usb/omap-usb.txt
> b/Documentation/devicetree/bindings/usb/omap-usb.txt
> index 38d9bb8..cf98f61 100644
> --- a/Documentation/devicetree/bindings/usb/omap-usb.txt
> +++ b/Documentation/devicetree/bindings/usb/omap-usb.txt
> @@ -78,3 +78,38 @@ omap_dwc3 {
>   	ranges;
>   };
>
> +AM35x MUSB GLUE
> + - compatible : Should be "ti,am35x-musb"

    Wildcards in  "compatible" are not allowed; you should select a "least 
common denominator" model and use it.

> + - ti,hwmods : must be "am35x_otg_hs"
> + - multipoint : Should be "1" indicating the musb controller supports
> +   multipoint. This is a MUSB configuration-specific setting.

    Hm, I would think this should be boolean prop...

> + - num-eps : Specifies the number of endpoints. This is also a
> +   MUSB configuration-specific setting. Should be set to "16"
> + - ram-bits : Specifies the ram address size. Should be set to "12"
> + - interface-type : Should be set to "1". (The AM35xx SOCs feature an
> +   integrated phy, connected via UTMI+)

    Again, maybe boolean?

> + - mode : Should be "3" to represent OTG. "1" signifies HOST and "2"

    There's already standardized "dr_mode" prop for that.

> +   represents PERIPHERAL.
> + - power : Should be "50". This signifies the controller can supply up to
> +   100mA when operating in host mode.

    Why not just exparess it in mA?

MBR, Sergei

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
