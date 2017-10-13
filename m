From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [Patch 2/6] ARM: DRA7: hwmod: Add CAL nodes
Date: Fri, 13 Oct 2017 09:56:54 -0700
Message-ID: <20171013165654.GK4394@atomide.com>
References: <20171012192719.15193-1-bparrot@ti.com>
 <20171012192719.15193-3-bparrot@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171012192719.15193-3-bparrot-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Benoit Parrot <bparrot-l0cyMroinI0@public.gmane.org>
Cc: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Benoit Parrot <bparrot-l0cyMroinI0@public.gmane.org> [171012 12:28]:
> This patch adds the required hwmod nodes to support the Camera
> Adaptation Layer (CAL) for the DRA72 family of devices.
...

> +static struct omap_hwmod_class_sysconfig dra7xx_cal_sysc = {
> +	.sysc_offs	= 0x0010,

Also has .rev_offs at 0 so please add that too.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
