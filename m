From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2 0/9] ARM: DRA7: Add support for DRA718-evm
Date: Wed, 9 Nov 2016 16:00:37 -0700
Message-ID: <20161109230037.GP2428@atomide.com>
References: <20161021103841.8044-1-lokeshvutla@ti.com>
 <1b9c4d14-78d7-841f-776c-63a8c1ae1fb1@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1b9c4d14-78d7-841f-776c-63a8c1ae1fb1-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
Cc: Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Device Tree Mailing List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Linux ARM Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org> [161106 20:50]:
> Hi Tony,
> 
> On Friday 21 October 2016 04:08 PM, Lokesh Vutla wrote:
> > This series does minor dts cleanup for dra72-evm and adds support for
> > DRA718-evm.
> 
> Do you have any comments on this series?

Looks good to me except for the regulator patch that you need to repost.
Applying the rest split into various topic branches for soc/dt/defconfig.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
