From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2 2/2] ARM: dts: Add devicetree for NovaTech OrionLXm
Date: Fri, 21 Nov 2014 15:33:25 -0800
Message-ID: <20141121233325.GZ7046@atomide.com>
References: <1416250957-11065-1-git-send-email-george.mccollister@gmail.com>
 <1416250957-11065-2-git-send-email-george.mccollister@gmail.com>
 <20141117190847.GA4857@saruman>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141117190847.GA4857@saruman>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: George McCollister <george.mccollister-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>, Carlos Garcia <carlos-FEoyFZUZMvJAfugRpC6u6w@public.gmane.org>, "open list:OPEN FIRMWARE AND..." <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "moderated list:ARM PORT" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "open list:OMAP DEVICE TREE..." <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> [141117 11:10]:
> On Mon, Nov 17, 2014 at 01:02:35PM -0600, George McCollister wrote:
> > This adds the NovaTech OrionLXm which is based on the AM335x SoC
> > http://www.novatechweb.com/substation-automation/orionlxm/
> > 
> > RAM: 512MiB
> > Flash: 4GB eMMC
> > Ethernet PHYs: 2x Micrel KSZ8041FTLI
> > USB ports are used internally by the expansion cards.
> > Internal micro SD slot is available.
> > 
> > Signed-off-by: George McCollister <george.mccollister-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> this looks might better to my eyes:
> 
> Reviewed-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>

Applying into omap-for-v3.19/dt-v2 thanks.

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
