From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: [PATCHv3 10/14] HSI: Introduce driver for SSI Protocol
Date: Sat, 19 Apr 2014 21:49:36 +0200
Message-ID: <20140419194936.GJ5148@amd.pavel.ucw.cz>
References: <1396053110-21639-1-git-send-email-sre@kernel.org>
 <1396053110-21639-11-git-send-email-sre@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1396053110-21639-11-git-send-email-sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Sebastian Reichel <sre-GFxCN5SEZAc@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Carlos Chinea <cch.devel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?utf-8?B?0JjQstCw0LnQu9C+INCU0LjQvNC40YLRgNC+0LI=?= <freemangordon-uiMcrn6V0Vs@public.gmane.org>, Joni Lapilainen <joni.lapilainen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>, Carlos Chinea <carlos.chinea-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi!

> This adds a driver for the SSI McSAAB protocol as used in
> the Nokia N900.
> 
> Signed-off-by: Carlos Chinea <carlos.chinea-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

> +#define SSIP_MIN_PN_HDR		6	/* FIXME: Revisit */
> +#define SSIP_WDTOUT		2000	/* FIXME: has to be 500 msecs> */

Can they be fixed now, or do they have to wait?


> +#ifdef __LITTLE_ENDIAN
> +	((u16 *)skb->data)[2] = swab16(((u16 *)skb->data)[2]);
> +	dev_dbg(&dev->dev, "RX length fixed (%04x -> %u)\n",
> +			((u16 *)skb->data)[2], ntohs(((u16 *)skb->data)[2]));
> +#endif

Uh. Can this be replaced by
    ((u16 *)skb->data)[2] = htons(((u16 *)skb->data)[2]);

(without the ifdef?)

> +	/*
> +	 * Modem sends Phonet messages over SSI with its own endianess...
> +	 * Assume that modem has the same endianess as we do.
> +	 */
> +	if (skb_cow_head(skb, 0))
> +		goto drop;
> +#ifdef __LITTLE_ENDIAN
> +	((u16 *)skb->data)[2] = swab16(((u16 *)skb->data)[2]);
> +#endif

Here, too?

But it looks like the comment does not match the code, because we
swap.

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
