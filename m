From: Nishanth Menon <nm@ti.com>
Subject: Re: regression(ti platforms): next-20140210 (ehci?)
Date: Mon, 10 Feb 2014 12:02:57 -0600
Message-ID: <52F91451.8050802@ti.com>
References: <52F8F77B.70605@ti.com> <52F9117C.8000405@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <52F9117C.8000405@ti.com>
Sender: linux-next-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, linux-omap <linux-omap@vger.kernel.org>, linux-usb@vger.kernel.org, "Balbi, Felipe" <balbi@ti.com>
Cc: linux-next@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

On 02/10/2014 11:50 AM, Roger Quadros wrote:
> +devicetree
> 
[...]
> In the DT node we have compatible ids for both. e.g. for omap4.dtsi
> 
>                         usbhsehci: ehci@4a064c00 {
>                                 compatible = "ti,ehci-omap", "usb-ehci";
>                                 reg = <0x4a064c00 0x400>;
>                                 interrupt-parent = <&gic>;
>                                 interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
>                         };
> 
> Shouldn't ehci-omap driver be getting a higher priority than usb-ehci?
> 
> A quick fix would be to eliminate "usb-ehci" from the DT node of all failing platforms.

If the driver is not compatible with "usb-ehci", not sure why do we
even state that in dts node?


-- 
Regards,
Nishanth Menon
