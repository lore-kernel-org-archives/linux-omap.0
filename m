From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] usb: dwc3: Addition of "dr_mode" dt property.
Date: Fri, 31 May 2013 00:19:33 +0400
Message-ID: <51A7B455.1000205@cogentembedded.com>
References: <1369944894-3176-1-git-send-email-ruchika@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1369944894-3176-1-git-send-email-ruchika@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: Ruchika Kharwar <ruchika@ti.com>
Cc: linux-usb@vger.kernel.org, linux-doc@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Landley <rob@landley.net>
List-Id: linux-omap@vger.kernel.org

Hello.

On 05/31/2013 12:14 AM, Ruchika Kharwar wrote:

> This patch adds an optional parameter "dr_mode" to the dwc3 core device node.
> In the case the compile flag for the DWC3 controller is set to
> "USB_DWC3_DUAL_ROLE" a device tree could restrain to either functionality of
> host or gadget. In the case the device tree does not use this optional flag or
> specifies it superfluously to "drd" the functionality will be that
> of a dual role device.
>
> Signed-off-by: Ruchika Kharwar <ruchika@ti.com>
> ---
>   Documentation/devicetree/bindings/usb/dwc3.txt |    3 ++-
>   drivers/usb/dwc3/core.c                        |   21 +++++++++++++++++----
>   2 files changed, 19 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/usb/dwc3.txt b/Documentation/devicetree/bindings/usb/dwc3.txt
> index 7a95c65..2f5d584 100644
> --- a/Documentation/devicetree/bindings/usb/dwc3.txt
> +++ b/Documentation/devicetree/bindings/usb/dwc3.txt
> @@ -10,7 +10,8 @@ Required properties:
>   
>   Optional properties:
>    - tx-fifo-resize: determines if the FIFO *has* to be reallocated.
> -
> + - dr_mode: determines the mode of core. Supported modes are "gadget", "host"
> +   and "drd".
>   This is usually a subnode to DWC3 glue to which it is connected.
>   
>   dwc3@4a030000 {
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index c35d49d..e11660a 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -378,7 +378,7 @@ static int dwc3_probe(struct platform_device *pdev)
>   	void			*mem;
>   
>   	u8			mode;
> -
> +	char			*dr_mode;

    Please leave empty line here, after the declarations.

>   	mem = devm_kzalloc(dev, sizeof(*dwc) + DWC3_ALIGN_MASK, GFP_KERNEL);
>   	if (!mem) {
>   		dev_err(dev, "not enough memory\n");
>

WBR, Sergei

