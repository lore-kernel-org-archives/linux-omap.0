From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v3 1/2] arm: dts: am4372: let boards access all nodes
 through phandles
Date: Wed, 25 Jun 2014 12:14:43 +0100
Message-ID: <20140625111443.GG14495@leverpostej>
References: <1403547659-24558-1-git-send-email-balbi@ti.com>
 <1403547659-24558-2-git-send-email-balbi@ti.com>
 <CAL_JsqJx_DJqxpEJebi0Etfv5g7=eYje_53vd_44GykreA-rkQ@mail.gmail.com>
 <20140625014016.GA21616@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140625014016.GA21616-HgARHv6XitL9zxVx7UNMDg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Sricharan R <r.sricharan-l0cyMroinI0@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Jun 25, 2014 at 02:40:16AM +0100, Felipe Balbi wrote:
> Hi,
> 
> On Tue, Jun 24, 2014 at 04:11:48PM -0500, Rob Herring wrote:
> > On Mon, Jun 23, 2014 at 1:20 PM, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> wrote:
> > > by providing phandles to rtc, wdt, cpu and dispc nodes,
> > > boards can access them to add board-specific data.
> > 
> > Strictly speaking, you are adding labels, not phandles. You can do
> 
> heh, fair point. Easily editable when applying, though (?)
> 
> > phandles without using labels, but the syntax is not so obvious. I'd
> > tell you what it is but offhand I don't remember. :)
> 
> something along the lines of using the full path ?

Yup. The full path in braces:

	phandle-property = <&{/full/path/to/node@0xDEAD}>;

Mark.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
