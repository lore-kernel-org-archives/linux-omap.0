From: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
Subject: Re: [RFC PATCH 0/6] DRIVERS: IRQCHIP: Add support for crossbar IP
Date: Mon, 30 Sep 2013 10:19:17 -0400
Message-ID: <52498865.5030303@ti.com>
References: <1380549564-31045-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1380549564-31045-1-git-send-email-r.sricharan-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sricharan R <r.sricharan-l0cyMroinI0@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Monday 30 September 2013 09:59 AM, Sricharan R wrote:
> Some socs have a large number of interrupts requests to service
> the needs of its many peripherals and subsystems. All of the interrupt
> requests lines from the subsystems are not needed at the same
> time, so they have to be muxed to the controllers appropriately.
> In such places a interrupt controllers are preceded by an
> IRQ CROSSBAR that provides flexibility in muxing the device interrupt
> requests to the controller inputs.
> 
> This series models the peripheral interrupts that can be routed through
> the crossbar to the GIC as 'routable-irqs'. The routable irqs are added
> in a separate linear domain inside the GIC. The registered routable domain's
> callback are invoked as a part of the GIC's callback, which in turn should
> allocate a free irq line and configure the IP accordingly. So every peripheral
> in the dts files mentions the fixed crossbar number as its interrupt. A free
> gic line for that gets allocated and configured when the peripheral's interrupt
> is mapped.
> 
> The minimal crossbar driver to track and allocate free GIC lines and configure the
> crossbar is added here, along with the DT bindings.
> 
You should have references to the previous discussions so that its
easier for new reviewers to understand why you ended up the approach.
I noticed you missed this in your last posts as well.

Regards,
Santosh
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
