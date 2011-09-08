From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [RFC PATCH 10/10] documentation/dt: Add OMAP GPIO properties
Date: Thu, 8 Sep 2011 11:18:19 -0700
Message-ID: <20110908181819.GI2967@ponder.secretlab.ca>
References: <1314191356-10963-1-git-send-email-b-cousson@ti.com>
	<1314191356-10963-11-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1314191356-10963-11-git-send-email-b-cousson-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
Cc: khilman-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, manjugk-l0cyMroinI0@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Randy Dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed, Aug 24, 2011 at 03:09:16PM +0200, Benoit Cousson wrote:
> Add documentation for GPIO properties specific to OMAP.
> 
> Signed-off-by: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
> Cc: Randy Dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>
> ---
>  .../devicetree/bindings/gpio/gpio-omap.txt         |   33 ++++++++++++++++++++
>  1 files changed, 33 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/gpio/gpio-omap.txt
> 
> diff --git a/Documentation/devicetree/bindings/gpio/gpio-omap.txt b/Documentation/devicetree/bindings/gpio/gpio-omap.txt
> new file mode 100644
> index 0000000..692b1c7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/gpio-omap.txt
> @@ -0,0 +1,33 @@
> +OMAP GPIO controller
> +
> +Required properties:
> +- compatible:
> +  - "ti,omap2-gpio" for OMAP2 and OMAP3 controllers
> +  - "ti,omap4-gpio" for OMAP4 controller
> +- #gpio-cells : Should be two.
> +  - first cell is the pin number
> +  - second cell is used to specify optional parameters (unused)
> +- gpio-controller : Marks the device node as a GPIO controller.
> +
> +OMAP specific properties:
> +- hwmods: Name of the hwmod associated to the GPIO
> +- id: 32 bits to identify the id (1 based index)

id should not be necessary.  Linux GPIO numbers are to be dynamically
assigned when using DT.

> +- bank_width: number of pin supported by the controller (16 or 32)
> +- debounce: set if the controller support the debouce funtionnality
> +- bank_count: number of controller support by the SoC. This is a temporary
> +  hack until the bank_count is removed from the driver.

All these properties should be prefixed with "ti,".
Use '-' instead of '_' in property names

> +
> +
> +Example:
> +
> +gpio4: gpio4 {
> +    compatible = "ti,omap4-gpio", "ti,omap-gpio";
> +    hwmods = "gpio4";
> +    id = <4>;
> +    bank_width = <32>;
> +    debounce;
> +    no_idle_on_suspend;
> +    #gpio-cells = <2>;
> +    gpio-controller;
> +};
> +
> -- 
> 1.7.0.4
> 
