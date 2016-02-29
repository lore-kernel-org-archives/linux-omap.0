From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: DRA7: change address-cells and size-cells
Date: Mon, 29 Feb 2016 21:45:09 +0100
Message-ID: <17470332.nnZZr9fh67@wuerfel>
References: <1456308664-28308-1-git-send-email-lokeshvutla@ti.com> <56D40505.8020702@ti.com> <20160229181606.GM13417@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160229181606.GM13417-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Lokesh Vutla <a0131933-l0cyMroinI0@public.gmane.org>, Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, nm-l0cyMroinI0@public.gmane.org, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Monday 29 February 2016 10:16:07 Tony Lindgren wrote:
> Yes I understand that if we need to set it at the top level. But what
> happens if you only set it for the memory node?
> 
> With just something like:
> 
> memory {
>        #address-cells = <2>;
>        #size-cells = <2>;
>        ...
> };

Nothing happens there: the memory node has no children, and no
ranges property, so the two properties are never referenced.

	Arnd
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
