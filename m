From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: DRA7: change address-cells and size-cells
Date: Mon, 29 Feb 2016 10:16:07 -0800
Message-ID: <20160229181606.GM13417@atomide.com>
References: <1456308664-28308-1-git-send-email-lokeshvutla@ti.com>
 <20160226191127.GE13417@atomide.com>
 <56D40505.8020702@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <56D40505.8020702-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lokesh Vutla <a0131933-l0cyMroinI0@public.gmane.org>
Cc: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, nm-l0cyMroinI0@public.gmane.org, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Lokesh Vutla <a0131933-l0cyMroinI0@public.gmane.org> [160229 00:48]:
> On Saturday 27 February 2016 12:41 AM, Tony Lindgren wrote:
> > * Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org> [160224 02:14]:
> > 
> > Is size-cells 2 needed for all these devices too? Can't
> > you just set it for the memory nodes?
> 
> For updating memory nodes with 64bit, I have to change the address and
> size cells as 2 for the root node. So, reg property in all the children
> to the root node should also be updated with 2 address cells and 2 size
> cells or else the below warning shows up:

Yes I understand that if we need to set it at the top level. But what
happens if you only set it for the memory node?

With just something like:

memory {
       #address-cells = <2>;
       #size-cells = <2>;
       ...
};

Regards,

Tony

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
