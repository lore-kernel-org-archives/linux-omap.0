From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 01/14] usb: phy: nop: Add device tree support and
 binding information
Date: Mon, 11 Feb 2013 11:40:40 +0000
Message-ID: <20130211114040.GA2726@e106331-lin.cambridge.arm.com>
References: <1360252974-7912-1-git-send-email-rogerq@ti.com>
 <1360252974-7912-2-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1360252974-7912-2-git-send-email-rogerq@ti.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "b-cousson@ti.com" <b-cousson@ti.com>, "balbi@ti.com" <balbi@ti.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "kishon@ti.com" <kishon@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hello,

On Thu, Feb 07, 2013 at 04:02:41PM +0000, Roger Quadros wrote:
> The PHY clock, clock rate, VCC regulator and RESET regulator
> can now be provided via device tree.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> Acked-by: Felipe Balbi <balbi@ti.com>
> ---
>  .../devicetree/bindings/usb/usb-nop-xceiv.txt      |   34 ++++++++++++++++++
>  drivers/usb/otg/nop-usb-xceiv.c                    |   36 +++++++++++++++----
>  2 files changed, 62 insertions(+), 8 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/usb/usb-nop-xceiv.txt
> 
> diff --git a/Documentation/devicetree/bindings/usb/usb-nop-xceiv.txt b/Documentation/devicetree/bindings/usb/usb-nop-xceiv.txt
> new file mode 100644
> index 0000000..d7e2726
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/usb-nop-xceiv.txt
> @@ -0,0 +1,34 @@
> +USB NOP PHY
> +
> +Required properties:
> +- compatible: should be usb-nop-xceiv

This might be better as "linux,usb-no-xceiv", given this is a Linux-specific
'device'.

Saying that, I'm not sure I understand why this device needs to be instantiated
from devicetree. As I understand it from looking at the driver, it's purely a
Linux implementation detail used in the case of autonomous PHYs, and not an
actual piece of hardware or firmware system. I must admit to being unfamiliar
with this area of hardware, have I misunderstood somethign here?

Can we not have drivers for autonomous PHYs initialise/register nop-usb-xceiv?
That way we don't leak Linux implementation details to the outside world, and
the dt can describe purely what's actually present in the system.

[...]

Thanks,
Mark.
