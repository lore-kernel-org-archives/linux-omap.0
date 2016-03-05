From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] ARM: OMAP2+: hwmod: Introduce ti,no-idle dt property
Date: Fri, 4 Mar 2016 22:28:49 -0600
Message-ID: <20160305042849.GV13525@rob-hp-laptop>
References: <1456994525-20573-1-git-send-email-lokeshvutla@ti.com>
 <1456994525-20573-2-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1456994525-20573-2-git-send-email-lokeshvutla-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Mar 03, 2016 at 02:12:04PM +0530, Lokesh Vutla wrote:
> Introduce a dt property, ti,no-idle, that prevents an IP to idle at any
> point. This is to handle Errata i877, which tells that GMAC clocks
> cannot be disabled.
> 
> Acked-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
> Tested-by: Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/arm/omap/omap.txt | 1 +

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

>  arch/arm/mach-omap2/omap_hwmod.c                    | 9 ++++++++-
>  arch/arm/mach-omap2/omap_hwmod.h                    | 3 +++
>  3 files changed, 12 insertions(+), 1 deletion(-)
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
