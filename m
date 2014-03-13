From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v3 1/5] doc: Add "ti,am437x-dwc3" comaptible for dwc3
 glue
Date: Thu, 13 Mar 2014 12:32:36 +0200
Message-ID: <53218944.7000102@ti.com>
References: <1394193422-18242-1-git-send-email-george.cherian@ti.com> <1394193422-18242-2-git-send-email-george.cherian@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1394193422-18242-2-git-send-email-george.cherian@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: George Cherian <george.cherian@ti.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
Cc: balbi@ti.com, kishon@ti.com, rob@landley.net, galak@codeaurora.org, ijc+devicetree@hellion.org.uk, mark.rutland@arm.com, pawel.moll@arm.com, robh+dt@kernel.org, tony@atomide.com, anatol.pomozov@gmail.com, bcousson@baylibre.com
List-Id: linux-omap@vger.kernel.org

Hi George,

On 03/07/2014 01:56 PM, George Cherian wrote:
> Add the compatible "ti,am437x-dwc3" for dwc3 glue driver.
> 
> Signed-off-by: George Cherian <george.cherian@ti.com>
> ---
>  Documentation/devicetree/bindings/usb/omap-usb.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/omap-usb.txt b/Documentation/devicetree/bindings/usb/omap-usb.txt
> index 38b2fae..38d9bb8 100644
> --- a/Documentation/devicetree/bindings/usb/omap-usb.txt
> +++ b/Documentation/devicetree/bindings/usb/omap-usb.txt
> @@ -44,7 +44,9 @@ Board specific device node entry
>  };
>  
>  OMAP DWC3 GLUE
> - - compatible : Should be "ti,dwc3"
> + - compatible : Should be
> +	* "ti,dwc3" for OMAP5 and DRA7
> +	* "ti,am437x-dwc3" for AM437x

Why do you need a new compatible for am437x? Isn't "ti,dwc3" sufficient?

>   - ti,hwmods : Should be "usb_otg_ss"
>   - reg : Address and length of the register set for the device.
>   - interrupts : The irq number of this device that is used to interrupt the
> 

cheers,
-roger
