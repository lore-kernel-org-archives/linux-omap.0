From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2] ARM: dts: AM571x-IDK Initial Support
Date: Thu, 24 Nov 2016 06:29:10 -0800
Message-ID: <20161124142910.GM4082@atomide.com>
References: <20161122041732.8385-1-lokeshvutla@ti.com>
 <CAL_JsqLv2t0qzJ1V6NGPj3iy9tOmMcnr3nsHxojb9aJxp9+8BQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAL_JsqLv2t0qzJ1V6NGPj3iy9tOmMcnr3nsHxojb9aJxp9+8BQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, spatton-l0cyMroinI0@public.gmane.org, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> [161122 07:43]:
> On Mon, Nov 21, 2016 at 10:17 PM, Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org> wrote:
> > From: Schuyler Patton <spatton-l0cyMroinI0@public.gmane.org>
> >
> > The AM571x-IDK board is a board based on TI's AM5718 SOC
> > which has a single core 1.5GHz A15 processor. This board is a
> > development platform for the Industrial market with:
> > - 1GB of DDR3L
> > - Dual 1Gbps Ethernet
> > - HDMI,
> > - PRU-ICSS
> > - uSD
> > - 16GB eMMC
> > - CAN
> > - RS-485
> > - PCIe
> > - USB3.0
> > - Video Input Port
> > - Industrial IO port and expansion connector
> >
> > The link to the data sheet and TRM can be found here:
> >
> > http://www.ti.com/product/AM5718
> >
> > Initial support is only for basic peripherals.
> >
> > Signed-off-by: Schuyler Patton <spatton-l0cyMroinI0@public.gmane.org>
> > Signed-off-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
> > Signed-off-by: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
> > Signed-off-by: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
> > ---
> > Cahnges since v1:
> > - Dropped "ti,dra722", and "ti,dra72" from compatibles
> > - Fixes few node names as suggested by Rob.
> > Logs: http://pastebin.ubuntu.com/23515001/
> 
> Please add acks when posting new versions.

I applied this with your ack as I was aware of the
context in this case :)

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
