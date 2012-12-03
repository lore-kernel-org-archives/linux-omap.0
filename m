From: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 0/3] ARM/dts: omap3: Add DT support for IGEP devices
Date: Mon, 3 Dec 2012 11:49:34 +0100
Message-ID: <50BC83BE.2020202@ti.com>
References: <1354270137-31538-1-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1354270137-31538-1-git-send-email-javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
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
To: Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Cc: Matthias Brugger <matthias.bgg-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Enric Balletbo i Serra <eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Enrico Butera <ebutera-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Javier,

On 11/30/2012 11:08 AM, Javier Martinez Canillas wrote:
> IGEP technology devices are TI OMAP3 SoC based industrial embedded
> and computer-on-module boards. This patch-set adds initial device
> tree support for these devices.
> 
> The device tree allows to boot from an MMC/SD and are working all
> the components that already have device tree support on OMAP3 SoCs:

That's cool to have one more board DT converted.

That series looks good to me, I just have a comment on the DT mux stuff.

Regards,
Benoit

> 
> - MMC/SD
> - UARTs
> - GPIO LEDs
> - TWL4030 codec audio
> - pinmux/pinconf pinctrl
> 
> Some peripheral are still not working such as Flash storage and
> Ethernet but support for these will also be included once the
> OMAP GPMC device tree binding patches hit mainline.
> 
> This is a v2 of the patch-set that solves issues pointed out by
> Enric Balletbo and it is composed of the following patches:
> 
> [PATCH v2 1/3] ARM/dts: omap3: Add generic DT support for IGEP devices
> [PATCH v2 2/3] ARM/dts: omap3: Add support for IGEPv2 board
> [PATCH v2 3/3] ARM/dts: omap3: Add support for IGEP COM Module
> 
> Best regards,
> Javier
> 
