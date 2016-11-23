From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 0/4] musb fixes for v4.9-rc cycle
Date: Wed, 23 Nov 2016 08:44:13 -0800
Message-ID: <20161123164412.GK4082@atomide.com>
References: <20161107215020.31399-1-tony@atomide.com>
 <1557347.d3YjqqaO81@avalon>
 <839f0f26-3bb0-d368-8cff-dbccaffa7244@ti.com>
 <10445300.62NO2xvFpp@avalon>
 <47c6e11e-3725-8955-5cc4-654df4d1c3bc@ti.com>
 <20161123155747.GF4082@atomide.com>
 <c76fd922-9ac8-3b32-902a-7839a4817109@ti.com>
 <20161123163448.GJ4082@atomide.com>
 <19526c30-5f18-337a-1e73-7f8965a778c1@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <19526c30-5f18-337a-1e73-7f8965a778c1-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Cc: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org> [161123 08:40]:
> On 23/11/16 18:34, Tony Lindgren wrote:
> 
> > OK. And what changes to your current .config make the musb_bus_suspend()
> > issues show up?
> > 
> > If it happens with USB-B cable from host to musb with musb set to host
> > only mode I'm not suprised there are errors :)
> 
> I have no USB cables connected. I have attached my config. If
> CONFIG_USB_MUSB_HDRC is disabled, the musb error goes away.

Maybe compare against omap2plus_defconfig? If you have musb
set to host only mode it still tries to follow the ID pin
from phy and do things on it's own. And ID pin is floating
in B mode and with no cable connected.

AFAIK, the only sane configuration for musb is the OTG mode
because the hardware tries to do things on it's own. And the
host only mode only really works if phy has ID pin grounded
or else the phy has to do trickery to rewrite the state to
musb.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
