From: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 02/11] arm/dts: omap: Add omap-usb2 dt data
Date: Tue, 17 Jul 2012 16:27:13 +0400
Message-ID: <50055A21.5010206@mvista.com>
References: <1342512611-20529-1-git-send-email-kishon@ti.com> <1342512611-20529-3-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1342512611-20529-3-git-send-email-kishon-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Cc: grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hello.

On 17-07-2012 12:10, Kishon Vijay Abraham I wrote:

> Add omap-usb2 data node in omap4 device tree file.

> Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
> ---
>   arch/arm/boot/dts/omap4.dtsi |    5 +++++
>   1 files changed, 5 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
> index bda5df3..4d2dcc1 100644
> --- a/arch/arm/boot/dts/omap4.dtsi
> +++ b/arch/arm/boot/dts/omap4.dtsi
> @@ -279,6 +279,11 @@
>   			#size-cells = <1>;
>   			ranges;
>   			ti,hwmods = "ocp2scp_usb_phy";
> +			usb2phy@0x4a0ad080 {

    There should be no "0x" prefix here.

WBR, Sergei
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
