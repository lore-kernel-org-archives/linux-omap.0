From: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 6/7] usb: dwc3-omap: Minor fixes to get dt working
Date: Mon, 01 Oct 2012 20:00:41 +0200
Message-ID: <5069DA49.7030901@mvista.com>
References: <1349087107-18229-1-git-send-email-kishon@ti.com> <1349087107-18229-7-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1349087107-18229-7-git-send-email-kishon-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Cc: grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hello.

On 01-10-2012 12:25, Kishon Vijay Abraham I wrote:

> Includes few minor fixes in dwc3-omap like populating the compatible
> string in a correct way, extracting the utmi-mode property properly and
> changing the index of get_irq since irq of core is removed from hwmod
> entry.
> Also updated the documentation with dwc3-omap device tree binding
> information.
>
> Signed-off-by: Kishon Vijay Abraham I<kishon-l0cyMroinI0@public.gmane.org>
> ---
>   drivers/usb/dwc3/dwc3-omap.c |    8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
> index c19affa..25bd847 100644
> --- a/drivers/usb/dwc3/dwc3-omap.c
> +++ b/drivers/usb/dwc3/dwc3-omap.c
> @@ -277,13 +277,13 @@ static int __devinit dwc3_omap_probe(struct platform_device *pdev)
>
>   	platform_set_drvdata(pdev, omap);
>
> -	irq = platform_get_irq(pdev, 1);
> +	irq = platform_get_irq(pdev, 0);
>   	if (irq<  0) {
>   		dev_err(dev, "missing IRQ resource\n");
>   		return -EINVAL;
>   	}
>
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>   	if (!res) {
>   		dev_err(dev, "missing memory base resource\n");
>   		return -EINVAL;
> @@ -326,7 +326,7 @@ static int __devinit dwc3_omap_probe(struct platform_device *pdev)
>
>   	utmi_mode = of_get_property(node, "utmi-mode",&size);
>   	if (utmi_mode&&  size == sizeof(*utmi_mode)) {
> -		reg |= *utmi_mode;
> +		reg |= be32_to_cpup(utmi_mode);

    Why not just use of_property_read_u32() instead of all this?

WBR, Sergei

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
